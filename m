Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C843C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7eeS01E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FAE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbeJQBLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730580AbeJQBLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:41 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD572089E;
        Tue, 16 Oct 2018 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710416;
        bh=ImwLD+RradnnJy+W4SvCRQkip28z4UgpzIXNXlP3SzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7eeS01E0SEw0Rn9Qzdn3g4CnPoz9LaBNxUeInDeh5HZkF6yGtRnPNFq5zI9OnOwH
         Y56VAWScFqUW/qQZbjOUH90GClNK7y92/1JVIGAsTIyt6mwyqUZX0ZZ1rG6eCLfE8F
         nzUoEiE4hFa92Ga+ykdfAo8k8LSnYDUP74eTINV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 070/109] dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled
Date:   Tue, 16 Oct 2018 19:05:38 +0200
Message-Id: <20181016170528.626681342@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit beb9caac211c1be1bc118bb62d5cf09c4107e6a5 upstream.

It is best to avoid any extra overhead associated with bio completion.
DM core will indirectly call a DM target's .end_io if it is defined.
In the case of DM linear, there is no need to do so (for every bio that
completes) if CONFIG_DM_ZONED is not enabled.

Avoiding an extra indirect call for every bio completion is very
important for ensuring DM linear doesn't incur more overhead that
further widens the performance gap between dm-linear and raw block
devices.

Fixes: 0be12c1c7fce7 ("dm linear: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-linear.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -101,6 +101,7 @@ static int linear_map(struct dm_target *
 	return DM_MAPIO_REMAPPED;
 }
 
+#ifdef CONFIG_DM_ZONED
 static int linear_end_io(struct dm_target *ti, struct bio *bio,
 			 blk_status_t *error)
 {
@@ -111,6 +112,7 @@ static int linear_end_io(struct dm_targe
 
 	return DM_ENDIO_DONE;
 }
+#endif
 
 static void linear_status(struct dm_target *ti, status_type_t type,
 			  unsigned status_flags, char *result, unsigned maxlen)
@@ -187,12 +189,16 @@ static size_t linear_dax_copy_from_iter(
 static struct target_type linear_target = {
 	.name   = "linear",
 	.version = {1, 4, 0},
+#ifdef CONFIG_DM_ZONED
+	.end_io = linear_end_io,
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_ZONED_HM,
+#else
+	.features = DM_TARGET_PASSES_INTEGRITY,
+#endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
 	.map    = linear_map,
-	.end_io = linear_end_io,
 	.status = linear_status,
 	.prepare_ioctl = linear_prepare_ioctl,
 	.iterate_devices = linear_iterate_devices,



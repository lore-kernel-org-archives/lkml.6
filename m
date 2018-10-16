Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A35C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb9xcwdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ED32089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeJQBLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbeJQBLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE7B2089E;
        Tue, 16 Oct 2018 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710419;
        bh=mDQXKgPWMSS80ryHEdxh7F9OYfgXVCqJBA4hdd1C2ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kb9xcwdvPVjhkFwoqIwWzTWRtZJ9nkaCLhHllo5hK5FUQfbjo+T66yNyuHn5kOMYf
         xd005TUdODNwxXZHgGOM6egm4cTbXk/WsFCRft9vVrnAaUMfcozblSpk+BbuXvbH4+
         WH+yhqxLRgxRLmUNOWt9KPPdOfEjYxSCL9AplnsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 071/109] dm linear: fix linear_end_io conditional definition
Date:   Tue, 16 Oct 2018 19:05:39 +0200
Message-Id: <20181016170528.669225738@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 118aa47c7072bce05fc39bd40a1c0a90caed72ab upstream.

The dm-linear target is independent of the dm-zoned target. For code
requiring support for zoned block devices, use CONFIG_BLK_DEV_ZONED
instead of CONFIG_DM_ZONED.

While at it, similarly to dm linear, also enable the DM_TARGET_ZONED_HM
feature in dm-flakey only if CONFIG_BLK_DEV_ZONED is defined.

Fixes: beb9caac211c1 ("dm linear: eliminate linear_end_io call if CONFIG_DM_ZONED disabled")
Fixes: 0be12c1c7fce7 ("dm linear: add support for zoned block devices")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-flakey.c |    2 ++
 drivers/md/dm-linear.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -463,7 +463,9 @@ static int flakey_iterate_devices(struct
 static struct target_type flakey_target = {
 	.name   = "flakey",
 	.version = {1, 5, 0},
+#ifdef CONFIG_BLK_DEV_ZONED
 	.features = DM_TARGET_ZONED_HM,
+#endif
 	.module = THIS_MODULE,
 	.ctr    = flakey_ctr,
 	.dtr    = flakey_dtr,
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -101,7 +101,7 @@ static int linear_map(struct dm_target *
 	return DM_MAPIO_REMAPPED;
 }
 
-#ifdef CONFIG_DM_ZONED
+#ifdef CONFIG_BLK_DEV_ZONED
 static int linear_end_io(struct dm_target *ti, struct bio *bio,
 			 blk_status_t *error)
 {
@@ -189,7 +189,7 @@ static size_t linear_dax_copy_from_iter(
 static struct target_type linear_target = {
 	.name   = "linear",
 	.version = {1, 4, 0},
-#ifdef CONFIG_DM_ZONED
+#ifdef CONFIG_BLK_DEV_ZONED
 	.end_io = linear_end_io,
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_ZONED_HM,
 #else



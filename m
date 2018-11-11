Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51985C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431220866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVHnEJFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1431220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbeKLIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbeKLIR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:56 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CDA2154B;
        Sun, 11 Nov 2018 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975281;
        bh=v+8ILTYm08TldAlgfqxomvxdLa6oPXwSQ5DSPu8e0fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVHnEJFoleUXsNvCi5N47XOkXFBLIiAxx78+TJGZu0cqYNLpVke2XdY4VgHJFnaWi
         PogtR0nDlCWcq6J0c0+RcOXYODuC30Fh3gqCXJvdxwY/EdrD8nyxDzqZtcHVBDWjOe
         YpvcZHYwoyvvf2EU0fE9gRZlYKg6MMLY1gL9PAIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasilis Liaskovitis <vliaskovitis@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 201/361] xen/blkfront: avoid NULL blkfront_info dereference on device removal
Date:   Sun, 11 Nov 2018 14:19:08 -0800
Message-Id: <20181111221648.571738035@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasilis Liaskovitis <vliaskovitis@suse.com>

commit f92898e7f32e3533bfd95be174044bc349d416ca upstream.

If a block device is hot-added when we are out of grants,
gnttab_grant_foreign_access fails with -ENOSPC (log message "28
granting access to ring page") in this code path:

  talk_to_blkback ->
	setup_blkring ->
		xenbus_grant_ring ->
			gnttab_grant_foreign_access

and the failing path in talk_to_blkback sets the driver_data to NULL:

 destroy_blkring:
        blkif_free(info, 0);

        mutex_lock(&blkfront_mutex);
        free_info(info);
        mutex_unlock(&blkfront_mutex);

        dev_set_drvdata(&dev->dev, NULL);

This results in a NULL pointer BUG when blkfront_remove and blkif_free
try to access the failing device's NULL struct blkfront_info.

Cc: stable@vger.kernel.org # 4.5 and later
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/xen-blkfront.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2493,6 +2493,9 @@ static int blkfront_remove(struct xenbus
 
 	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
 
+	if (!info)
+		return 0;
+
 	blkif_free(info, 0);
 
 	mutex_lock(&info->mutex);



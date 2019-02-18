Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EC721908
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497724;
	bh=z30Ifm7jdW5LEFSmgxp0ZjlVb9Jx681Ika63tGrtR2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cxOrNnztfpp+uWRmZZVG9NOWTv6I2Ntf7nzRq3ga9rU8iCUKMXbn4He+4Cyi9xg/V
	 /MMt587uWYWEZowBat0rF6VaMFUFwfRScSRRQ45c5D6geM9Irgys/QRAI3/uzUHnfb
	 fL9YIJvHC2nopBV6Q3HKzUuU7LwjrbSwDabOp2xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfBRNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731886AbfBRNsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AECA21906;
        Mon, 18 Feb 2019 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497717;
        bh=z30Ifm7jdW5LEFSmgxp0ZjlVb9Jx681Ika63tGrtR2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ITkbfjzXF6fJ+U7XwdOMCsL+pVProRrAMaGDqfZrHpwMVdcmOFb/8L09pllB8O2kL
         Equ2x4LEPk2HZFAZfBMd3QIOA68zyLlGk9t2UgbEjW+qkHpLpS5x/jCtpAKArOiAdQ
         KV3Pi6BjWsCC0DPZfXdZbQa1pFU7Nx9oIO4GWAmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikael Pettersson <mikpelinux@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        Xuewei Zhang <xueweiz@google.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 80/92] scsi: sd: fix entropy gathering for most rotational disks
Date:   Mon, 18 Feb 2019 14:43:23 +0100
Message-Id: <20190218133502.587537434@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit e4a056987c86f402f1286e050b1dee3f4ce7c7eb upstream.

The problem is that the default for MQ is not to gather entropy, whereas
the default for the legacy queue was always to gather it.  The original
attempt to fix entropy gathering for rotational disks under MQ added an
else branch in sd_read_block_characteristics().  Unfortunately, the entire
check isn't reached if the device has no characteristics VPD page.  Since
this page was only introduced in SBC-3 and its optional anyway, most less
expensive rotational disks don't have one, meaning they all stopped
gathering entropy when we made MQ the default.  In a wholly unrelated
change, openssl and openssh won't function until the random number
generator is initialised, meaning lots of people have been seeing large
delays before they could log into systems with default MQ kernels due to
this lack of entropy, because it now can take tens of minutes to initialise
the kernel random number generator.

The fix is to set the non-rotational and add-randomness flags
unconditionally early on in the disk initialization path, so they can be
reset only if the device actually reports being non-rotational via the VPD
page.

Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Fixes: 83e32a591077 ("scsi: sd: Contribute to randomness when running rotational device")
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Xuewei Zhang <xueweiz@google.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2960,9 +2960,6 @@ static void sd_read_block_characteristic
 	if (rot == 1) {
 		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
-	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
-		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
 	}
 
 	if (sdkp->device->type == TYPE_ZBC) {
@@ -3099,6 +3096,15 @@ static int sd_revalidate_disk(struct gen
 	if (sdkp->media_present) {
 		sd_read_capacity(sdkp, buffer);
 
+		/*
+		 * set the default to rotational.  All non-rotational devices
+		 * support the block characteristics VPD page, which will
+		 * cause this to be updated correctly and any device which
+		 * doesn't support it should be treated as rotational.
+		 */
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
+
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);



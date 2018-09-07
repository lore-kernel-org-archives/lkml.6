Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25154C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB2F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB2F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeIHB6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:58:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42512 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeIHB6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:58:03 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33E14F07;
        Fri,  7 Sep 2018 21:15:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.18 059/145] dm crypt: dont decrease device limits
Date:   Fri,  7 Sep 2018 23:08:45 +0200
Message-Id: <20180907210909.461458836@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit bc9e9cf0401f18e33b78d4c8a518661b8346baf7 upstream.

dm-crypt should only increase device limits, it should not decrease them.

This fixes a bug where the user could creates a crypt device with 1024
sector size on the top of scsi device that had 4096 logical block size.
The limit 4096 would be lost and the user could incorrectly send
1024-I/Os to the crypt device.

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3069,11 +3069,11 @@ static void crypt_io_hints(struct dm_tar
 	 */
 	limits->max_segment_size = PAGE_SIZE;
 
-	if (cc->sector_size != (1 << SECTOR_SHIFT)) {
-		limits->logical_block_size = cc->sector_size;
-		limits->physical_block_size = cc->sector_size;
-		blk_limits_io_min(limits, cc->sector_size);
-	}
+	limits->logical_block_size =
+		max_t(unsigned short, limits->logical_block_size, cc->sector_size);
+	limits->physical_block_size =
+		max_t(unsigned, limits->physical_block_size, cc->sector_size);
+	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);
 }
 
 static struct target_type crypt_target = {



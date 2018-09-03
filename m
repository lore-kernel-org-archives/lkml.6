Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195E20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeICVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeICVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:41 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E704CA8;
        Mon,  3 Sep 2018 16:52:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3.18 56/56] cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status
Date:   Mon,  3 Sep 2018 18:49:46 +0200
Message-Id: <20180903164926.889426397@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Bauer <scott.bauer@intel.com>

commit 8f3fafc9c2f0ece10832c25f7ffcb07c97a32ad4 upstream.

Like d88b6d04: "cdrom: information leak in cdrom_ioctl_media_changed()"

There is another cast from unsigned long to int which causes
a bounds check to fail with specially crafted input. The value is
then used as an index in the slot array in cdrom_slot_status().

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Scott Bauer <sbauer@plzdonthack.me>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cdrom/cdrom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2525,7 +2525,7 @@ static int cdrom_ioctl_drive_status(stru
 	if (!CDROM_CAN(CDC_SELECT_DISC) ||
 	    (arg == CDSL_CURRENT || arg == CDSL_NONE))
 		return cdi->ops->drive_status(cdi, CDSL_CURRENT);
-	if (((int)arg >= cdi->capacity))
+	if (arg >= cdi->capacity)
 		return -EINVAL;
 	return cdrom_slot_status(cdi, arg);
 }



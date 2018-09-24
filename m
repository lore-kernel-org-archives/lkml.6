Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE55ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D5020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeIXSGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:06:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeIXSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:06:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D9191074;
        Mon, 24 Sep 2018 12:04:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 066/111] USB: yurex: Fix buffer over-read in yurex_write()
Date:   Mon, 24 Sep 2018 13:52:33 +0200
Message-Id: <20180924113111.544445463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 7e10f14ebface44a48275c8d6dc1caae3668d5a9 upstream.

If the written data starts with a digit, yurex_write() tries to parse
it as an integer using simple_strtoull().  This requires a null-
terminator, and currently there's no guarantee that there is one.

(The sample program at
https://github.com/NeoCat/YUREX-driver-for-Linux/blob/master/sample/yurex_clock.pl
writes an integer without a null terminator.  It seems like it must
have worked by chance!)

Always add a null byte after the written data.  Enlarge the buffer
to allow for this.

Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/yurex.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -431,13 +431,13 @@ static ssize_t yurex_write(struct file *
 {
 	struct usb_yurex *dev;
 	int i, set = 0, retval = 0;
-	char buffer[16];
+	char buffer[16 + 1];
 	char *data = buffer;
 	unsigned long long c, c2 = 0;
 	signed long timeout = 0;
 	DEFINE_WAIT(wait);
 
-	count = min(sizeof(buffer), count);
+	count = min(sizeof(buffer) - 1, count);
 	dev = file->private_data;
 
 	/* verify that we actually have some data to write */
@@ -456,6 +456,7 @@ static ssize_t yurex_write(struct file *
 		retval = -EFAULT;
 		goto error;
 	}
+	buffer[count] = 0;
 	memset(dev->cntl_buffer, CMD_PADDING, YUREX_BUF_SIZE);
 
 	switch (buffer[0]) {



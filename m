Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7853C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BEC20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BEC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeLIWEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36818 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbeLIWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:39 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002ia-2z; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Uk-0R; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.415106178@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 197/328] USB: yurex: Fix buffer over-read in
 yurex_write()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/misc/yurex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -437,13 +437,13 @@ static ssize_t yurex_write(struct file *
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
 	dev = (struct usb_yurex *)file->private_data;
 
 	/* verify that we actually have some data to write */
@@ -462,6 +462,7 @@ static ssize_t yurex_write(struct file *
 		retval = -EFAULT;
 		goto error;
 	}
+	buffer[count] = 0;
 	memset(dev->cntl_buffer, CMD_PADDING, YUREX_BUF_SIZE);
 
 	switch (buffer[0]) {


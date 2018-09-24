Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C96ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0FA2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0FA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbeIXSna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:43:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeIXSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:43:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 848FF109F;
        Mon, 24 Sep 2018 12:41:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 177/235] gpiolib: dont allow userspace to set values of input lines
Date:   Mon, 24 Sep 2018 13:52:43 +0200
Message-Id: <20180924113122.447077803@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <brgl@bgdev.pl>

[ Upstream commit e5332d5437764f775cf4e3b8ca3bf592af063a02 ]

User space can currently both read and set values of input lines using
the character device. This was not allowed by the old sysfs interface
nor is it a correct behavior.

Check the first descriptor in the set for the OUT flag when asked to
set values and return -EPERM if the line is input.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -449,7 +449,13 @@ static long linehandle_ioctl(struct file
 
 		return 0;
 	} else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
-		/* TODO: check if descriptors are really output */
+		/*
+		 * All line descriptors were created at once with the same
+		 * flags so just check if the first one is really output.
+		 */
+		if (!test_bit(FLAG_IS_OUT, &lh->descs[0]->flags))
+			return -EPERM;
+
 		if (copy_from_user(&ghd, ip, sizeof(ghd)))
 			return -EFAULT;
 



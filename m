Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71537C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2866A2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2866A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIMHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43602 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006PH-VF; Thu, 13 Sep 2018 02:40:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/50] simserial: switch to ->[sg]et_serial()
Date:   Thu, 13 Sep 2018 03:40:05 +0100
Message-Id: <20180913024049.24567-6-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/hp/sim/simserial.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index 663388a73d4e..de5e69162ad5 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -297,18 +297,25 @@ static void rs_unthrottle(struct tty_struct * tty)
 	printk(KERN_INFO "simrs_unthrottle called\n");
 }
 
+static int rs_setserial(struct tty_struct *tty, struct serial_struct *ss)
+{
+	return 0;
+}
+
+static int rs_getserial(struct tty_struct *tty, struct serial_struct *ss)
+{
+	return 0;
+}
+
 static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
-	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
-	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
+	if ((cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT)) {
 		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
 	switch (cmd) {
-	case TIOCGSERIAL:
-	case TIOCSSERIAL:
 	case TIOCSERGSTRUCT:
 	case TIOCMIWAIT:
 		return 0;
@@ -448,6 +455,8 @@ static const struct tty_operations hp_ops = {
 	.throttle = rs_throttle,
 	.unthrottle = rs_unthrottle,
 	.send_xchar = rs_send_xchar,
+	.set_serial = rs_setserial,
+	.get_serial = rs_getserial,
 	.hangup = rs_hangup,
 	.proc_show = rs_proc_show,
 };
-- 
2.11.0


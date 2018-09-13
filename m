Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B7C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7540B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7540B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeIMHsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43826 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYt-0006Tx-Oq; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 47/50] gigaset: add ->compat_ioctl()
Date:   Thu, 13 Sep 2018 03:40:46 +0100
Message-Id: <20180913024049.24567-47-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and get rid of COMPAT_IOCTL() for its private ioctls

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/isdn/gigaset/interface.c | 11 +++++++++++
 fs/compat_ioctl.c                |  5 -----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/gigaset/interface.c b/drivers/isdn/gigaset/interface.c
index f9698c0c3885..d9a578ac32cd 100644
--- a/drivers/isdn/gigaset/interface.c
+++ b/drivers/isdn/gigaset/interface.c
@@ -233,6 +233,14 @@ static int if_ioctl(struct tty_struct *tty,
 	return retval;
 }
 
+#ifdef CONFIG_COMPAT
+static long if_compat_ioctl(struct tty_struct *tty,
+		    unsigned int cmd, unsigned long arg)
+{
+	return if_ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int if_tiocmget(struct tty_struct *tty)
 {
 	struct cardstate *cs = tty->driver_data;
@@ -472,6 +480,9 @@ static const struct tty_operations if_ops = {
 	.open =			if_open,
 	.close =		if_close,
 	.ioctl =		if_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl =		if_compat_ioctl,
+#endif
 	.write =		if_write,
 	.write_room =		if_write_room,
 	.chars_in_buffer =	if_chars_in_buffer,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ca2b51d9cb61..7eec04b6e757 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1021,11 +1021,6 @@ COMPATIBLE_IOCTL(CAPI_SET_FLAGS)
 COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
-/* Siemens Gigaset */
-COMPATIBLE_IOCTL(GIGASET_REDIR)
-COMPATIBLE_IOCTL(GIGASET_CONFIG)
-COMPATIBLE_IOCTL(GIGASET_BRKCHARS)
-COMPATIBLE_IOCTL(GIGASET_VERSION)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
-- 
2.11.0


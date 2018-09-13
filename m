Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0870C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B6321476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeIMHsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43820 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeIMHsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYt-0006Tq-Ku; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 46/50] vt_compat_ioctl(): clean up, use compat_ptr() properly
Date:   Thu, 13 Sep 2018 03:40:45 +0100
Message-Id: <20180913024049.24567-46-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we need it for "convert the structure" cases too

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/vt/vt_ioctl.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index a78ad10a119b..82d38d7ba014 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1171,17 +1171,13 @@ long vt_compat_ioctl(struct tty_struct *tty,
 {
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
-	unsigned int console;
-	void __user *up = (void __user *)arg;
+	unsigned int console = vc->vc_num;
+	void __user *up = compat_ptr(arg);
 	int perm;
-	int ret = 0;
 
-	console = vc->vc_num;
 
-	if (!vc_cons_allocated(console)) { 	/* impossible? */
-		ret = -ENOIOCTLCMD;
-		goto out;
-	}
+	if (!vc_cons_allocated(console)) 	/* impossible? */
+		return -ENOIOCTLCMD;
 
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
@@ -1197,17 +1193,14 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	 */
 	case PIO_FONTX:
 	case GIO_FONTX:
-		ret = compat_fontx_ioctl(cmd, up, perm, &op);
-		break;
+		return compat_fontx_ioctl(cmd, up, perm, &op);
 
 	case KDFONTOP:
-		ret = compat_kdfontop_ioctl(up, perm, &op, vc);
-		break;
+		return compat_kdfontop_ioctl(up, perm, &op, vc);
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		ret = compat_unimap_ioctl(cmd, up, perm, vc);
-		break;
+		return compat_unimap_ioctl(cmd, up, perm, vc);
 
 	/*
 	 * all these treat 'arg' as an integer
@@ -1232,21 +1225,15 @@ long vt_compat_ioctl(struct tty_struct *tty,
 	case VT_DISALLOCATE:
 	case VT_RESIZE:
 	case VT_RESIZEX:
-		goto fallback;
+		return vt_ioctl(tty, cmd, arg);
 
 	/*
 	 * the rest has a compatible data structure behind arg,
 	 * but we have to convert it to a proper 64 bit pointer.
 	 */
 	default:
-		arg = (unsigned long)compat_ptr(arg);
-		goto fallback;
+		return vt_ioctl(tty, cmd, (unsigned long)up);
 	}
-out:
-	return ret;
-
-fallback:
-	return vt_ioctl(tty, cmd, arg);
 }
 
 
-- 
2.11.0


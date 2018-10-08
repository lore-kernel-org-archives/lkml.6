Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71BC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F72077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 04:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51F72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJHLQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:16:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51075 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJHLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 07:16:56 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9846Yku459575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 7 Oct 2018 21:06:34 -0700
Received: from carbon-x1.hos.anvin.org (localhost [127.0.0.1])
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2) with ESMTP id w9846Txd1248328;
        Sun, 7 Oct 2018 21:06:29 -0700
Received: (from hpa@localhost)
        by carbon-x1.hos.anvin.org (8.15.2/8.15.2/Submit) id w9846Ttt1248327;
        Sun, 7 Oct 2018 21:06:29 -0700
X-Authentication-Warning: carbon-x1.hos.anvin.org: hpa set sender to hpa@zytor.com using -f
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tobias Klausmann <klausman@schwarzvogel.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-alpha@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, stable@vger.kernel.org
Subject: [PATCH stable v2 1/2] arch/alpha, termios: implement BOTHER, IBSHIFT and termios2
Date:   Sun,  7 Oct 2018 21:06:19 -0700
Message-Id: <20181008040620.1248277-2-hpa@zytor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008040620.1248277-1-hpa@zytor.com>
References: <20181008040620.1248277-1-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Alpha has had c_ispeed and c_ospeed, but still set speeds in c_cflags
using arbitrary flags. Because BOTHER is not defined, the general
Linux code doesn't allow setting arbitrary baud rates, and because
CBAUDEX == 0, we can have an array overrun of the baud_rate[] table in
drivers/tty/tty_baudrate.c if (c_cflags & CBAUD) == 037.

Resolve both problems by #defining BOTHER to 037 on Alpha.

However, userspace still needs to know if setting BOTHER is actually
safe given legacy kernels (does anyone actually care about that on
Alpha anymore?), so enable the TCGETS2/TCSETS*2 ioctls on Alpha, even
though they use the same structure. Define struct termios2 just for
compatibility; it is the exact same structure as struct termios. In a
future patchset, this will be cleaned up so the uapi headers are
usable from libc.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <stable@vger.kernel.org>
---
 arch/alpha/include/asm/termios.h       |  8 +++++++-
 arch/alpha/include/uapi/asm/ioctls.h   |  5 +++++
 arch/alpha/include/uapi/asm/termbits.h | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index 6a8c53dec57e..b7c77bb1bfd2 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -73,9 +73,15 @@
 })
 
 #define user_termios_to_kernel_termios(k, u) \
-	copy_from_user(k, u, sizeof(struct termios))
+	copy_from_user(k, u, sizeof(struct termios2))
 
 #define kernel_termios_to_user_termios(u, k) \
+	copy_to_user(u, k, sizeof(struct termios2))
+
+#define user_termios_to_kernel_termios_1(k, u) \
+	copy_from_user(k, u, sizeof(struct termios))
+
+#define kernel_termios_to_user_termios_1(u, k) \
 	copy_to_user(u, k, sizeof(struct termios))
 
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 3729d92d3fa8..dc8c20ac7191 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -32,6 +32,11 @@
 #define TCXONC		_IO('t', 30)
 #define TCFLSH		_IO('t', 31)
 
+#define TCGETS2		_IOR('T', 42, struct termios2)
+#define TCSETS2		_IOW('T', 43, struct termios2)
+#define TCSETSW2	_IOW('T', 44, struct termios2)
+#define TCSETSF2	_IOW('T', 45, struct termios2)
+
 #define TIOCSWINSZ	_IOW('t', 103, struct winsize)
 #define TIOCGWINSZ	_IOR('t', 104, struct winsize)
 #define	TIOCSTART	_IO('t', 110)		/* start output, like ^Q */
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index de6c8360fbe3..4575ba34a0ea 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -26,6 +26,19 @@ struct termios {
 	speed_t c_ospeed;		/* output speed */
 };
 
+/* Alpha has identical termios and termios2 */
+
+struct termios2 {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_cc[NCCS];		/* control characters */
+	cc_t c_line;			/* line discipline (== c_cc[19]) */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* Alpha has matching termios and ktermios */
 
 struct ktermios {
@@ -152,6 +165,7 @@ struct ktermios {
 #define B3000000  00034
 #define B3500000  00035
 #define B4000000  00036
+#define BOTHER    00037
 
 #define CSIZE	00001400
 #define   CS5	00000000
@@ -169,6 +183,9 @@ struct ktermios {
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define CIBAUD	07600000
+#define IBSHIFT	16
+
 /* c_lflag bits */
 #define ISIG	0x00000080
 #define ICANON	0x00000100
-- 
2.17.1


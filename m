Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0563C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78369218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfBCNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:53:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54136 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbfBCNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:07 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003td-Js; Sun, 03 Feb 2019 13:49:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00076v-DC; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "" <linux-alpha@vger.kernel.org>,
        "Johan Hovold" <johan@kernel.org>,
        "Matt Turner" <mattst88@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        "" <linux-serial@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Richard Henderson" <rth@twiddle.net>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.777894721@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 165/305] arch/alpha, termios: implement BOTHER,
 IBSHIFT and termios2
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

commit d0ffb805b729322626639336986bc83fc2e60871 upstream.

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
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: <linux-alpha@vger.kernel.org>
Cc: <linux-serial@vger.kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/alpha/include/asm/termios.h       |  8 +++++++-
 arch/alpha/include/uapi/asm/ioctls.h   |  5 +++++
 arch/alpha/include/uapi/asm/termbits.h | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -72,9 +72,15 @@
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
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -31,6 +31,11 @@
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
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -25,6 +25,19 @@ struct termios {
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
@@ -147,6 +160,7 @@ struct ktermios {
 #define B3000000  00034
 #define B3500000  00035
 #define B4000000  00036
+#define BOTHER    00037
 
 #define CSIZE	00001400
 #define   CS5	00000000
@@ -164,6 +178,9 @@ struct ktermios {
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define CIBAUD	07600000
+#define IBSHIFT	16
+
 /* c_lflag bits */
 #define ISIG	0x00000080
 #define ICANON	0x00000100


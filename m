Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70786C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FBB2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4MneYfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FBB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbeKTDSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390256AbeKTDSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B52E208E3;
        Mon, 19 Nov 2018 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646458;
        bh=T13FWIaEZpAVu0n6oIABIpWj+wY9ak99AIoMXRTXUiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4MneYfhuV07fR1aoHgJJ9FeGi7UEuOYpJeRWKIL05ZRG390pAdC6ZE8wbAsz93fp
         izWyX5GAqAQzVpfFJBjmduYT6j0HRzv+UVa3SkkDpvcIQAjEvgilbNN1RtDlDLRc9g
         Cw9Vs1awNozyj40yB+nQxb5P5UyPtKvCQgMl3naQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
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
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4.9 49/83] arch/alpha, termios: implement BOTHER, IBSHIFT and termios2
Date:   Mon, 19 Nov 2018 17:29:15 +0100
Message-Id: <20181119162622.209313510@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
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

From: H. Peter Anvin (Intel) <hpa@zytor.com>

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/include/asm/termios.h       |    8 +++++++-
 arch/alpha/include/uapi/asm/ioctls.h   |    5 +++++
 arch/alpha/include/uapi/asm/termbits.h |   17 +++++++++++++++++
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



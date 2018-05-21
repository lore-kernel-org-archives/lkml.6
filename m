Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpYfGLy14ecwBUxpKcFRtFvsgXcRbTM6bXt4XHqSxW9msTgxn0sL6OM5w7K24DXok0MYn3i
ARC-Seal: i=1; a=rsa-sha256; t=1526937641; cv=none;
        d=google.com; s=arc-20160816;
        b=HTSGu1tjIwhQP9WUp9RvR8meCfqkhthuMkQ3Gxcji9nlFtO517idRaO87RGxY98Z6c
         NELcu21P2gyYDbgRQdn17P9WPqQbdpa2k6LrgBUK6cyja8CxmauaArnEWoNVy78fukv9
         z5XKbODBIlSZ5PxTVY+7L5Z2srGoU7evJNb9lMdhsyIKo51QRMvHhSCxzr/TBzM55fOi
         KE9Re6UHB0l73D7DzpmG0drVV45t69J+XC6xiqRQ/Ibb2eggZ30P3HNYMpTIhbaI8Ku6
         Z1z8NIN+Xo3+Nm8tsa5ZwUOctHO6sZfC6EysAPW44hFcceJma8UOUSHU/mUaYLkBrIwj
         BaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Au6SKJnYjK8loaM3pp9Edr1f9o7T/FEwSvE2GIbHuj8=;
        b=i4hyibGGLkMNAs+qxL8PI3vsUlmEUKe23Fpp3yOecjL4Q0yLM7BUhYxV1U3W07kmSj
         /xRX1OPhLCmAAKrFhmCysfvgIs6MiN78Apyl0lT+7BvSzkeWPKJxEDSusHCbZ+7d95DD
         9Sb4HNh9C43Ekl/ZyGGr41JE+WGptyqEK04r5RWxgk9gzELTLiR0kN2nHa51GQYTDBWF
         G19ND4DaivbyYbsPCJPLva0BNNSUn5OlCCBblpCEsGdrQJ/YP9FeYgursAT0E/lXhjBI
         azCPp2F1y5h5Spe6jwFtOFRt2T/lHyzlYymhSRV7Fd1J4XfD7/S6wCwUVFwXe1++WXHk
         Ychg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kNxn4OUf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kNxn4OUf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 35/95] ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
Date: Mon, 21 May 2018 23:11:25 +0200
Message-Id: <20180521210455.093441660@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109792890386805?=
X-GMAIL-MSGID: =?utf-8?q?1601110164142645944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit eb0146daefdde65665b7f076fbff7b49dade95b9 upstream.

Prohibit kprobes on do_undefinstr because kprobes on
arm is implemented by undefined instruction. This means
if we probe do_undefinstr(), it can cause infinit
recursive exception.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/traps.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
 #include <linux/bug.h>
@@ -417,7 +418,8 @@ void unregister_undef_hook(struct undef_
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
+static nokprobe_inline
+int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 {
 	struct undef_hook *hook;
 	unsigned long flags;
@@ -490,6 +492,7 @@ die_sig:
 
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
+NOKPROBE_SYMBOL(do_undefinstr)
 
 /*
  * Handle FIQ similarly to NMI on x86 systems.

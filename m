Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr7gJh7NZQeUJdAPj9+/SYIAd0bTgL1AMc7VpFzZSA3EDfI+Xt5IwxpUBoTxRaZJoe9kMPs
ARC-Seal: i=1; a=rsa-sha256; t=1526937850; cv=none;
        d=google.com; s=arc-20160816;
        b=izSF9c0b6RVn6qvWfUhO60lZ7eSkhlGL6MnlJERvpZjqTwGzJjnJKHTD6H0+kdyial
         HHqvD0NdE1rx+4+0SqoGOEwTYSE3X+sF4XrU5XhkkhatBEBCKVbr2m2FpllY61fIsbB4
         Pfy0Hlndq9C/BHbWysVoxvnk+5V/dFKDlr1h6iMHPhrm37DO/U8QZlHwNOhpLp+Y+ZfU
         6ZmlLz2QpkSdApRokV/JVR9kfOL9eAs6/YdMhbTkjIbFrABKke7vxiIhEkiCxNdELxXx
         o3MxiBNOX5Q9a9YkDp3F9iQrrnIuE05XbBQSbZNlyQOMHuACGWqchiwFsR48fj1D2t+4
         PWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kOzkMCZat7j5iJJ6wfKG9DgPq86ztMlOPFUaQxZpWys=;
        b=h08rAUa4y39gjRHOm/Am7UNfl4zp28nGXwpBaU1/kDNUHNLSCguBvP08tLM3LafcpH
         PJWPI5/sdrkP7I1YMObEStOwtE3xdOsUUKHcFPJ/zCRkpDF45U10tPv+ascZPmZ4uqbC
         ur7mLwxHzrTRFWfMWqz9T3CJKCB2cNvZM0PSThtXJ/NA3+KrgiQ0BewZjh2WGK3ri97l
         kv8p5fSabmeiyhUKPpcMa1Pbp93YinHc0pRepFsef5kYSp8ElwDTsZKj2nH3pX+y59cV
         YUrGI0dKeNM/Rb/jOrKh0snlz1z+o2iz1VbjeT/aa6Q7ZzS3VUQsMn+O677Ah/fxfBas
         fLzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OTY8Ys7W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OTY8Ys7W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.16 048/110] ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
Date: Mon, 21 May 2018 23:11:45 +0200
Message-Id: <20180521210508.942917094@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109792890386805?=
X-GMAIL-MSGID: =?utf-8?q?1601110383405282339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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

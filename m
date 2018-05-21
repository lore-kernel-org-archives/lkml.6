Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpYTzj+VuRx1txvSfyuP1cF1r96qT/bQo4+DbZOtJpsYtE1qSO9QzusXAvko60GSvFq6dAo
ARC-Seal: i=1; a=rsa-sha256; t=1526937287; cv=none;
        d=google.com; s=arc-20160816;
        b=W0oTWQZNWEDRLN2vXVrNrjZU1etQK6NKRjJXBUjaWWnh0gdptXvNIOY89ilvjpfF+Y
         mAPbZpx/hApvTa+5iKCmda1CQrtMv85Wa+ah1vlksBpDu3SAPZsqEdYmFxdNl6VrMVVa
         lyM4Lb3QG3hKh+AyEdf6OmvH1/0jSVUJmNn4DZD3I6EEH8lunfSOdai/w9fZB5xDHS+j
         a5GMTKOB+UhFPOKu1YL7BBqjvZcfgfz5C1H9tIuILJ3S0RpEFcI+NeqsvGTvA+i9g8r9
         RDo2aAkonM7tkh2hTwIYYTtUjTC/U+luoocISF5G+9Wj3SE2riglVib8ymHWOJfkSshy
         aUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ztSRXmbnEnCM50mHFf/Sxg6dK8dEYohNb9XbFke5pVE=;
        b=yFnHkckCbk9xk6lzKqfZ07SnW93T9tLE3YfJaU8g+Fkruh9jvmua5xaBLA1S0oZZSU
         vSiBlUczswOfQbLBPErpMXbY/eYta56Cu1wwxyiUedYMzdoX9bY9PJoZxU1+JWI1dHK4
         NeNITNOEaDs78mgI1tIIZdwTc6i1Lri0e0VNVICDHkBQWnuL7P03By0bC6CtzLxr29bC
         JJVXsG8PfXrrNC02J4iP9luC3g6DtFiDZl5d22iKo5pzF8tXZe69mgWVqwIslE0jfuP3
         Vfr7fQlGRnQOAKPblNlyCYpTNao57j/RFqdv5vvzHruJyMK0ifdpBOK0NxnUxuMba1Ds
         Ch7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mwqp2JR5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mwqp2JR5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.9 27/87] ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
Date: Mon, 21 May 2018 23:11:03 +0200
Message-Id: <20180521210422.874003888@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109792890386805?=
X-GMAIL-MSGID: =?utf-8?q?1601109792890386805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -415,7 +416,8 @@ void unregister_undef_hook(struct undef_
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
+static nokprobe_inline
+int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 {
 	struct undef_hook *hook;
 	unsigned long flags;
@@ -488,6 +490,7 @@ die_sig:
 
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
+NOKPROBE_SYMBOL(do_undefinstr)
 
 /*
  * Handle FIQ similarly to NMI on x86 systems.

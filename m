Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqF17yhy+5YeYqFMxcfNWYyihclHyYX+PDRq2Vcln2dGlJPo/FUEu8PbzmfsTBNnYyGxhLj
ARC-Seal: i=1; a=rsa-sha256; t=1526937637; cv=none;
        d=google.com; s=arc-20160816;
        b=czyU3KsWX5b2XovI4BlGg2LLClzvp2sO4Aao3EUNz9yiy9SjwsZNN/y1T3sWfFe3z0
         DlaJ1X54D3kc/NLzLVKGGs1S6ZVDw6jWrkyYe8Z+gf5+mjmo5T2IVAmfRlhEBJFXGOjq
         XNU/1vfx8nM/8HtKczYaMyrieCaQuBIN1jrbyqyy0FCnVPh3WTkKtz2puFVih7s/bMsZ
         BtZhizdk+/MFZ+oSBUS+b23v+5rxq43eUSQBGZVAeJpxMv3i/0Zmlpa3qc6qtwrsy8+J
         n50Rt5wrL8/p3kWOyexa+0aOa1k1/HezncyCB4gjzOqaF3yCIZUz0Zm1OOdEBIEwL92y
         OSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BWJ6TDM3Uxdv+nB33pGMNOX3q3H4erawE+KBe1BMam8=;
        b=QLCVgVtfRC/2cxQxU/dIwCFPj1FVDO4simspNuLMwPPhv/EN2F7pK/f5a8Q24ymdUx
         /4ziDLLvWz/5tGzp8oqTwNewKlomW7PhR7lp1RxgHTrausVwGNhRgZcI4zZFd/j1m8Xe
         /XVrrgb/hPZaPQOqadJGc1RQET1WdOEo6vroQSjyDM00cWQwSESob+sQq7E4tBCJzmP1
         acGb+x/1sB6LE8iwpht0Que8otfnujuqgR3NhHGr8JfduTnAVUnhWL9KypjZN9FJWyi0
         h6Oc7qh3xIDdGofHXvAvT7dvz6WAZSBiXOXDm0avjp6AK3PFDxa57qJWsA2NJwhFjSAm
         B+EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=przbB1YT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=przbB1YT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 65/95] proc: Provide details on speculation flaw mitigations
Date: Mon, 21 May 2018 23:11:55 +0200
Message-Id: <20180521210459.725321100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109972788944421?=
X-GMAIL-MSGID: =?utf-8?q?1601110160318450252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit fae1fa0fc6cca8beee3ab8ed71d54f9a78fa3f64 upstream

As done with seccomp and no_new_privs, also show speculation flaw
mitigation state in /proc/$pid/status.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/array.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -85,6 +85,7 @@
 #include <linux/delayacct.h>
 #include <linux/seq_file.h>
 #include <linux/pid_namespace.h>
+#include <linux/prctl.h>
 #include <linux/ptrace.h>
 #include <linux/tracehook.h>
 #include <linux/string_helpers.h>
@@ -347,6 +348,27 @@ static inline void task_seccomp(struct s
 #ifdef CONFIG_SECCOMP
 	seq_put_decimal_ull(m, "\nSeccomp:\t", p->seccomp.mode);
 #endif
+	seq_printf(m, "\nSpeculation Store Bypass:\t");
+	switch (arch_prctl_spec_ctrl_get(p, PR_SPEC_STORE_BYPASS)) {
+	case -EINVAL:
+		seq_printf(m, "unknown");
+		break;
+	case PR_SPEC_NOT_AFFECTED:
+		seq_printf(m, "not vulnerable");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
+		seq_printf(m, "thread mitigated");
+		break;
+	case PR_SPEC_PRCTL | PR_SPEC_ENABLE:
+		seq_printf(m, "thread vulnerable");
+		break;
+	case PR_SPEC_DISABLE:
+		seq_printf(m, "globally mitigated");
+		break;
+	default:
+		seq_printf(m, "vulnerable");
+		break;
+	}
 	seq_putc(m, '\n');
 }
 

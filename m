Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqDhYNHGEGZqJ/w2whVWbmUSPcPVs/fgDaP6qAf2jEaD3gQDF1k7AUowTA1wlHzpTTJJNpF
ARC-Seal: i=1; a=rsa-sha256; t=1526937932; cv=none;
        d=google.com; s=arc-20160816;
        b=SngIvjGlvPZwgHXyW2JOASR9KOIwaks/WKiRYjh2AcQ/5gX5mOUzjGQ4ndqP1S2nXS
         Ca/Km8SMRLcFu1PKTt2MDgbcBwUEOtzuX+GzCNDMVf1Yalp+RR0TYZKVUrC8x4ZphTZk
         ApwBbKEMCX4mQZPhP4a57VEOs0b/hk8C8Y8mHQp8u7Z2Xms0DdgAZfhJlz5e6jlPvKYa
         mjcr5N4wXksPqbuNUTKk3F5aIgVNl3IIro6Kf1g2GN6EezSyCCDfJg0y/ZMJWXscqP3h
         M/8Ds/n9o1roKR9QluP9lPZbXVjbr8w2vTcnBqDPZwtLS3KSJRMincnHKtI9UxZydhXx
         PcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=e6c4duRE+ZH+UbsUKx+0oVmngMphFKOlINvbWnBkbJg=;
        b=fr1RA1jOTfIwT9GLtS4+ULfGOcGCOgEx80qTDbM8m+oDm82R6ufx4cSHtmSGt7K+sa
         xeuAU54vwzj9QgC1eNJSV82yfGn/Sz9P8HWCfO07v9xBL2SVEJKKC5LbDHj3zoA+Icse
         hJH2lM9UZjSt6oEMrVWQHRH2sOx5JPrGMOIxk1KoPagslXBlRMXUC2naMqpirtNZWS4E
         3MpJn2PSgsc6Vp//xK2hKo4gt6AU3LIVYEzSUwicpeEfJYgem3VPJwHYgZPDeE2UxyZi
         M2zYH4L+IssQIkIfAp7NBlY1KYiEgHXVrkzYEE+5pBAjwHkWVsaB4w2zGey6EwviwDNh
         iPhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m4xQRGGV;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m4xQRGGV;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 079/110] proc: Provide details on speculation flaw mitigations
Date: Mon, 21 May 2018 23:12:16 +0200
Message-Id: <20180521210513.220298217@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109972788944421?=
X-GMAIL-MSGID: =?utf-8?q?1601110469237733001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 

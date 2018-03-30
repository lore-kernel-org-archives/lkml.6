Return-Path: <kernel-hardening-return-12832-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/uIQcX5lsqaN+eX7pRm3GKj8H3YEszomxAWoEu+Xzmc+JSyvTWtM65zQUHl+tQ81Fu0KfM
ARC-Seal: i=1; a=rsa-sha256; t=1522400020; cv=none;
        d=google.com; s=arc-20160816;
        b=K5K017Q037ZwjIPOfiagokAJ6x2Vgx6kDNfDAbu4qf6GiJVCz8DaOR0/twyYQzom/x
         vE/0MpCULUhHWLyg7BAsYPOXl8UuDDbHF99w3XjhCSAopyS8p6nC+lOVz4w6YsExRYwl
         +Uh6wwyjnw5IRhorIWQmPBoB7OEwR8H1uO+jFH7Pbqo5QvxCl6WT0UUCYN5HiFM27Pvk
         UBiVeCoSRWxmkU79CIOsvlFG4Ot5GpwLTJa/jZUWsYr99nNju7M9AZELeFkRbkta3daf
         zoXudscMgY19WuPCFBbXYaTAIBizoe9Zqbg/cPV/sbNQYQyw5N7IWphOH5RIahVgk6/l
         CLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=qGnZyqfAqz97h1IJ1jKpe0mHDRkFqYwhjmIcLz/kaRs=;
        b=rLKuHVgIuVjlqUAgHpzbnxB2yHBkPMmbtnxlPdYidmhJhApqy8z2zGbu4rwx796XRx
         sq8q61gCHV9Sm4Gv674LY5JLF4NbCObYP6ijNsE4UtWLYTAt9I688mNQNN4gD3KWcFau
         7e/amNPIzOtpmWTJkMuKpiCqfiaEoYFoAoN4NrXG58FBCj0TvTiRXqMG94cCSjrg9h+t
         x+WUmDEdgIqVnF7ti1gVFNw65RvE7MUOwFCaSqwt37d6ZEeHFda25NVUwViTc8fYf7U4
         H7uf8gpTMLOG7shyTZdNdB4K7WPvkAfRjFQSvZ6LG/taj2a4w2OSlNjl3V07KFdQ10TX
         Ttog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OSmL0gPr;
       spf=pass (google.com: domain of kernel-hardening-return-12832-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12832-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OSmL0gPr;
       spf=pass (google.com: domain of kernel-hardening-return-12832-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12832-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [v2] ftrace: drop a VLA in module_exists()
Date: Fri, 30 Mar 2018 10:53:08 +0200
Message-Id: <1522399988-8815-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352124099470452?=
X-GMAIL-MSGID: =?utf-8?q?1596352124099470452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid a VLA[1] by using a real constant expression instead of a variable.
The compiler should be able to optimize the original code and avoid using
an actual VLA. Anyway this change is useful because it will avoid a false
positive with -Wvla, it might also help the compiler generating better
code.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 kernel/trace/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eac9ce2..16bbf06 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
 	const char this_mod[] = "__this_module";
-	const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
-	char modname[modname_size + 1];
+	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 2];
 	unsigned long val;
 	int n;
 
-	n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
+	n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
 
-	if (n > modname_size)
+	if (n > sizeof(modname) - 1)
 		return false;
 
 	val = module_kallsyms_lookup_name(modname);
-- 
1.9.1

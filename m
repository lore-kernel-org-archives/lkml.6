Return-Path: <kernel-hardening-return-12516-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsxIqHno3rn5StP3BvSQoRQNdnhtQuXpjfmpqz3Du0QD/FA/2a+cxmJZl+qzwpofc/pkpaZ
ARC-Seal: i=1; a=rsa-sha256; t=1520970695; cv=none;
        d=google.com; s=arc-20160816;
        b=uXW0hohlzktNeCHpqIsiBQ5XiPNEsGz5nOh0W6Jcr6PeXQKVVQoHIDsIrJhk+jUEAL
         I4nNSarUekiCzFBTxWnCUNrgsPeo7GdN+OV/YbAJuUtoHJCUoAOAhy6GQjxrINywhSP4
         TYknkxcE0pDWZcinobdlr5dRrASi+vILk2DlDQU8PJL+q1//+RdEBbkfGE3YHUL8/4tP
         WED7xS8wpOLOhB7bNcNyhmtcSwrzZf0EWv5sXaIEidYPRHJjtFh/fj98xLatM8zMbw9+
         HO4IIHPorNq7C2nxrlaVu6NYr4BQ2nkoPTq10WC4iRQ3E7PltYPXQ5XbZfhi3/R+J5SB
         q/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Z5p+IFringKLuINSVeFM5lLckFQhbotJDTQeKdVAK6E=;
        b=o10IDfKVVNnBRFsoZDLswNy7Om9nKovaZToAWEXlkIl9TeW+9+91XRBjS6WqVysZkv
         9fD6YY1KzhpSgEz5TWrOf31dt1RBrcnwqbSTTAKaLr+SHRAYpoq+KE5jUd598vvPf2kB
         v9zsz/PcICTSjg8v1bMQtib8TJZDDSv9V5w6jXTt88+hKI+FJ8SJygLdZPMd6JZvgBmS
         pHQ8jLxPoq6NF8pmwEQQKLGsJYxBwGASpk/aWow5MZndzJklaTOWIQ4DSZcb6zU02mrf
         8tUx5TddfJe5icreB7/1prIC7EW9BfVzGG7X6GIuYcz5f466pPGGHnnXIICPUJovxHs5
         KQeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tEORs4zt;
       spf=pass (google.com: domain of kernel-hardening-return-12516-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12516-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tEORs4zt;
       spf=pass (google.com: domain of kernel-hardening-return-12516-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12516-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH] ftrace: drop a VLA in module_exists()
Date: Tue, 13 Mar 2018 20:51:03 +0100
Message-Id: <1520970663-19633-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853368165293411?=
X-GMAIL-MSGID: =?utf-8?q?1594853368165293411?=
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
index eac9ce2..adebb92 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
 {
 	/* All modules have the symbol __this_module */
 	const char this_mod[] = "__this_module";
-	const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
-	char modname[modname_size + 1];
+	char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1];
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

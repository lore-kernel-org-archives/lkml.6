Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZrsGg4b0F7+Y5KbPUoos4zDviiBMNSJtXXqbUTHGz/7t+n9HIT6rEpz1kfeEBzfL45+V6OL
ARC-Seal: i=1; a=rsa-sha256; t=1525314775; cv=none;
        d=google.com; s=arc-20160816;
        b=PQLltjlxK5ncF9WBgFbEurYAsG66zBHtUmxdd6JuqZ1FRYwRPUXhUB4Yi/bF7ZT5UN
         GuF5bdEwulPTcCbXW7F41bPZkhIgJFUD6D8F2VxF8lDMJYE+L4TS0T4jZT3ftg2zqNFA
         pAPwJnmaLuCIqXHISK2P/FT43OrDGTWQ09FpOjpFVNYjE20AagOrU5ABNeR7tgSdsjvk
         7eP50fPTb7xZuU8/U6CdGUqmAO7Opz/IVxrOhoGO7ABhoDwgQdfGSpQnALSVslTZJfnu
         bjenyPnRFO7xfi0rb/vaBqozXz7xUu7En7ijWXDaHX07+7/x2m7BZUBFDioLziuMtCoZ
         3Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=HMA0hbwlC4zI5YEu9/wA01ioBW44far+/N9bJdoCjiQ=;
        b=L1vsoBlkQu8Tbc49mOYtAQ9EH2GaynMqRuc+ztJ0Rgu/XUVXOJ/p3wnm9HxpBnlLnZ
         e9JHYfFx7svCizeohWHyp4zJm7zR21NLurb8bbeSbO1WTR85E775bYROIgSuZ9bZjw79
         QSnT+ynma8eetpcw/uHX/++92vbzET8ANmb6n36IRrP3wTcy9BML2buwFHseg7H8NiXa
         ir9lFMpj6YBheLXN1sGB+V1FPgo/lQ6faE+IBHcnHBkfToVc2FYXQsuRgtTAY7DgCY+J
         u2VS/on8+FIaBeAkVQ0EqasCNSWwQJEJhwj7f8WEBc9idxaz9e9ml0gv1bdmtinVGH/a
         /cuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.81 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 3/3] x86/Centaur: Report correct CPU/cache topology
Date: Thu, 3 May 2018 10:32:46 +0800
Message-ID: <1525314766-18910-4-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599408466472857252?=
X-GMAIL-MSGID: =?utf-8?q?1599408466472857252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
but the function is unused so for. The Centaur init code also missies to
initialize x86_info::max_cores, so the CPU topology can't be described
correctly.

Initialize x86_info::max_cores and invoke init_intel_cacheinfo() to make
CPU and cache topology information available and correct.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 80d5110..c265494 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -160,6 +160,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, 0*32+31);
 #endif
 	early_init_centaur(c);
+	init_intel_cacheinfo(c);
+	c->x86_max_cores = detect_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
-- 
1.9.1

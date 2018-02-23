Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2258K/Np+ln37pbKTCFwFZuOl9mJiw6p+rFX6sKfbNCT+FPv1BFB2czkdDyYckVN8ljUWeQV
ARC-Seal: i=1; a=rsa-sha256; t=1519412044; cv=none;
        d=google.com; s=arc-20160816;
        b=h5ZAFQDln/aqabW2WSjqgiIrO933YCCXoq0ORwwSlElodu730FoClIVpyFPDR8bxa7
         rDsUUYukJiuWjpOHEnCASamGMiHn7sAXxerQFEMyuYecPpaZVNF8gOJK4JZ4uwD5ti+h
         zLqFbLC8m+OX2Dko90WZtijeLpHIikUAtt0DpFH4NDjnWk2cjyCTmnOidl2/ZyjMt+pu
         jcc+jKwLxeN8jy56RE/hholaCjEOVQCiwbBwqlTwwkf/PswP5oO+IHZMw3yFju0eYB5i
         X0K3/WTXu4ia3K4iGtJimWwAfPDOSKKpbIVA4I+qYNMVsLebHHvg6tEGmUHe5iP/WZjA
         fBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gfCAYv0cRJ0oWVij9FVs4X01K0a2fJnHpID/ma84urQ=;
        b=c+CUy3J3/oYy6r9/OL9BcZTwyA4RoskwuHXd9v/9+DFTp5Jlhmgp8flPRsAgmH1V+Z
         w2z2fniXZYy2ZBTUJDl6L5VXbFkKIrKV+Ek62P0++0bnruJjzow6AvIP7NpduLzMAAPl
         ueW0g78XMvBjkzmEKvwdiQYhxr4wl/F0SBA6G6U0PejxE5R4enTptdQWBg6nLATUS9iD
         qbEbNbS62C6g1niUxXkaRyxEQrrep1SMEUW8sAzP/Gc4tR/SeEGsNf2mYeIVZZBgObZ6
         HTKpTTywiHEmRR86CuBgHi6Kj/eNe2NDKZsXocox02+9oXf3WirMjHIzjBE17teZQIKu
         dD8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 104/159] m68k: add missing SOFTIRQENTRY_TEXT linker section
Date: Fri, 23 Feb 2018 19:26:52 +0100
Message-Id: <20180223170756.003062677@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217642973745829?=
X-GMAIL-MSGID: =?utf-8?q?1593219004712952014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Ungerer <gerg@linux-m68k.org>


[ Upstream commit 969de0988b77e5a57aac2f7270191a3c50540c52 ]

Commit be7635e7287e ("arch, ftrace: for KASAN put hard/soft IRQ entries
into separate sections") added a new linker section, SOFTIRQENTRY_TEXT,
to the linker scripts for most architectures. It didn't add it to any of
the linker scripts for the m68k architecture. This was not really a problem
because it is only defined if either of CONFIG_FUNCTION_GRAPH_TRACER or
CONFIG_KASAN are enabled - which can never be true for m68k.

However commit 229a71860547 ("irq: Make the irqentry text section
unconditional") means that SOFTIRQENTRY_TEXT is now always defined. So on
m68k we now end up with a separate ELF section for .softirqentry.text
instead of it being part of the .text section. On some m68k targets in some
configurations this can also cause a fatal link error:

  LD      vmlinux
/usr/local/bin/../m68k-uclinux/bin/ld.real: section .softirqentry.text loaded at [0000000010de10c0,0000000010de12dd] overlaps section .rodata loaded at [0000000010de10c0,0000000010e0fd67]

To fix add in the missing SOFTIRQENTRY_TEXT section into the m68k linker
scripts. I noticed that m68k is also missing the IRQENTRY_TEXT section,
so this patch also adds an entry for that too.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/kernel/vmlinux-nommu.lds |    2 ++
 arch/m68k/kernel/vmlinux-std.lds   |    2 ++
 arch/m68k/kernel/vmlinux-sun3.lds  |    2 ++
 3 files changed, 6 insertions(+)

--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -45,6 +45,8 @@ SECTIONS {
 	.text : {
 		HEAD_TEXT
 		TEXT_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -16,6 +16,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	CPUIDLE_TEXT
 	LOCK_TEXT
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -16,6 +16,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	CPUIDLE_TEXT
 	LOCK_TEXT

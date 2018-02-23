Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ukGoImp1o3cgwZ9VtAmYWGdMqQsL/ieINoQ7Q+cZ9QyGbTAbtqBQGREa+uAVSmn8MiBB7
ARC-Seal: i=1; a=rsa-sha256; t=1519410978; cv=none;
        d=google.com; s=arc-20160816;
        b=cNRf9l8H/bhoGXlfd0Bolv1D4Zi8KxqXxTjBvaJErs1H0vUK5r4Bd64YnJmn5Xuroq
         83nT1CDUTQ0EDFG3ksuhSc3TzekKf7T+/YtKx1Mjy9LgKHNiY3GdRMl0uyXOqSRsEn+V
         mp10c6QzsToQn3EJYkrkAzBUregHHKLygeMBq9G3qcjlmKStuYLpTneN7LiY4ZjUOPeb
         P0AfsoSOcUA5zIPl3Q3PrfYxQCv3O1tXQETgdG/oqtfBO0rk7sYhDJONqJ0+3iY3I0VY
         LuwiSMH/fyBRi+VLDMJuN1VBV2VrWGkwMA9ZqM13oQF6wak0FIKVv+3XWzZ54fi/Gp+8
         A1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=13sVStWPVj7BIupz6o9FmSL7aGpd/e9/V63LeDE66xw=;
        b=eoLNE8kYuRaqAdJsB6ociD/zyp36O2k70OMi7qgigN6ea6jnqrsqjvNACnU1zq0JLD
         zC5hbUqrnkdDA1pqvL8TCqEbHbVCqbpFNKGDloCOb9AfAJ1zBn3FTRNSAT3/ZxETw6dC
         /E0ZuE1D5bXLXAdmhg5/VhgrUq4fJc4ErmCvMPYcMZTaIixua+gL+uxQ8yzTXd+G03vP
         ejKYFK+YaXHdepBmyOh4dJsFgakKMGnKjDiISfvpj08UISG48P31MFg0944cKDZ1GML4
         w8hXzf+LOMvGZYZiV6ayNfddFyu+9LuWE18qJb78/6g6kKPJ5Sc++W154tm0EkJv4dpr
         bzhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 042/193] m68k: add missing SOFTIRQENTRY_TEXT linker section
Date: Fri, 23 Feb 2018 19:24:35 +0100
Message-Id: <20180223170332.640722819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217642973745829?=
X-GMAIL-MSGID: =?utf-8?q?1593217886939661538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/kernel/vmlinux-nommu.lds |    2 ++
 arch/m68k/kernel/vmlinux-std.lds   |    2 ++
 arch/m68k/kernel/vmlinux-sun3.lds  |    2 ++
 3 files changed, 6 insertions(+)

--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -44,6 +44,8 @@ SECTIONS {
 	.text : {
 		HEAD_TEXT
 		TEXT_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
 		*(.fixup)
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -15,6 +15,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -15,6 +15,8 @@ SECTIONS
   .text : {
 	HEAD_TEXT
 	TEXT_TEXT
+	IRQENTRY_TEXT
+	SOFTIRQENTRY_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs8KY4LTIF23A+4VE5+XbHVfDkO06ApotBT9HD4e9qBXLBChOkom5wICzhct2ReVFf6KzY/
ARC-Seal: i=1; a=rsa-sha256; t=1521483613; cv=none;
        d=google.com; s=arc-20160816;
        b=Vx+UYEK8vSZnZMKw6kUjyOSx3ohVIe1JWxRlqwcFZ5BfZSKZ4RNxsxy2/CJW+hm3Ed
         9zWXWyIGGX1hjduOw5fOOo8DA8fj1iPl0EXDII1PKAlYTvS9ZeqO7bdTNAAVrl4ZXm2Z
         n0SxFYrJD50Zsr4aLfIf8hMzkjDWxf9ppJcvVo0xv4hFirwcgMUQi79kIeH5cFTF2y6w
         M6wYDs+Q/6q+ddcVmGDAcoKN0vV1Mhbf0nxFH1rAILXKlY9dgG+3W60vLD/nIgu11Dgo
         xbNpYKi/+QhMmw7Aa/p4xJCu2YBfI7Z8027V1B73SpF2XwqVtsaphxmczi8l1yz/v174
         610w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IBaW3QMCg0d02GOZ1t6kdxTFs1jR/vLx0CTbAzPoTZo=;
        b=Z6a27QQ1roa2XXBsdWvGQPsWRhrn24HZ7TIZJ1XqVEET4jkttgM1dNZd1CM7A1Qy1T
         TXp/IlJeKtlkbUVlXXevvXiKAnLoO7++AtBclMfHJDPiV8ucRuDgpUU7247Su3Ym/Iql
         LrtCmDPBWwMfB30ChxJ7j55Ve5QXK+X66PvGAdbcDpkHmK6edu7qTPaPPTnRauGEm3jU
         BP1ij7Zv6ReZluB7/d3nSnc1sVkYHIfU7Bn5ZxBYkJFnYsvXtinU9GqJodqp8Lzj8o/K
         nF7Ml0INE+oP6nRA0QF/I+gu7NBgESr7M9lhJGzTr2TvmvZqeyDH9o7jd4ofpe0l2a4P
         aZ9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Garnier <thgarnie@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 052/241] x86/boot/32: Defer resyncing initial_page_table until per-cpu is set up
Date: Mon, 19 Mar 2018 19:05:17 +0100
Message-Id: <20180319180753.377148577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391201432890069?=
X-GMAIL-MSGID: =?utf-8?q?1595391201432890069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>


[ Upstream commit 23b2a4ddebdd17fad265b4bb77256c2e4ec37dee ]

The x86 smpboot trampoline expects initial_page_table to have the
GDT mapped.  If the GDT ends up in a virtually mapped per-cpu page,
then it won't be in the page tables at all until perc-pu areas are
set up.  The result will be a triple fault the first time that the
CPU attempts to access the GDT after LGDT loads the perc-pu GDT.

This appears to be an old bug, but somehow the GDT fixmap rework
is triggering it.  This seems to have something to do with the
memory layout.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/a553264a5972c6a86f9b5caac237470a0c74a720.1490218061.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/setup.c        |   15 ---------------
 arch/x86/kernel/setup_percpu.c |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1200,21 +1200,6 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
-#ifdef CONFIG_X86_32
-	/* sync back kernel address range */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
-	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
-	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
-
 	tboot_probe();
 
 	map_vsyscall();
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,4 +287,25 @@ void __init setup_per_cpu_areas(void)
 
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
+
+#ifdef CONFIG_X86_32
+	/*
+	 * Sync back kernel address range.  We want to make sure that
+	 * all kernel mappings, including percpu mappings, are available
+	 * in the smpboot asm.  We can't reliably pick up percpu
+	 * mappings using vmalloc_fault(), because exception dispatch
+	 * needs percpu data.
+	 */
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+#endif
 }

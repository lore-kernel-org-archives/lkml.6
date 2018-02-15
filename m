Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226277MXfZKigH8l1ocS1tWyRJgMneja0jaiz/bTFKxhm5l9y+hJAqXiFXHBVXQrCsJWKJNC
ARC-Seal: i=1; a=rsa-sha256; t=1518708676; cv=none;
        d=google.com; s=arc-20160816;
        b=P8ORoaWFfllDklyILF3YjlraJd0LPbfD5+g3ZNCrJtO90gpJJ/RVvAFfEhzBsR58i4
         DYzZlKWhIN8/XqBumo754Dc9YhOPV2lCO8IFS97XfR6J5Dv5VYoxLF4gklxpTAzu6dOt
         rn06zuZYMqh1uLOhH9msjHlaxaNh24n7Wn3uABQr6IQwjnLZex1n8vJgatMFxDoHmDdP
         vKfJR32BHN9uKXBAwbSFLTIK5LT/OwoK5RPqPS2JqxW6LhPjKVaqsW3ZOhaznDP9j6O9
         wccWyNnm0+gBNvzLvUKgno0sF9vcvJHhZ+gm/MrR72BcRknLRSb3+/P7nM8S6yD4sl1b
         Yxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LZ3VeFe4ZfthCBi9nGB7UyZ7WcFJG2iDc40RsJxQ2IM=;
        b=TLIOoRZJ8u15hOp+TVQjJWuvua3x0mLpjGNFTG004WLYZ/qbCtuAmGaO/wmMEaNHBO
         bK8vfFTNEEk2xtjl2nb1xrbN5JTJMsJNfOcFxDfESmuTP5O37aAEw5qPl5Dyrr3/5yFm
         +1MKLxMKagnwnU2omJno/dIuKcLUy+jwbeff9x4+bLxRfPBdtkBiG2jUrxp2cH6McGrq
         o/2s7B/RupErzvVBnljVglb19u3GPT9ncIRmYHWZeLiW1c8GuYKkm6LR4CBYwfnR9xkz
         CnZc+QCsnQtfwUycOgsgmB7h6AAvbqfpx/t4pD15dnvzsWsvQ1uqRjawu2xL340f6BoE
         ghdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 038/195] [Variant 3/Meltdown] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
Date: Thu, 15 Feb 2018 16:15:29 +0100
Message-Id: <20180215151707.637473541@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481468965479077?=
X-GMAIL-MSGID: =?utf-8?q?1592481468965479077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 18011eac28c7 upstream.

When unmapping the kernel at EL0, we use tpidrro_el0 as a scratch register
during exception entry from native tasks and subsequently zero it in
the kernel_ventry macro. We can therefore avoid zeroing tpidrro_el0
in the context-switch path for native tasks using the entry trampoline.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/process.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -314,16 +314,14 @@ void tls_preserve_current_state(void)
 
 static void tls_thread_switch(struct task_struct *next)
 {
-	unsigned long tpidr, tpidrro;
-
 	tls_preserve_current_state();
 
-	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
-		  next->thread.tp_value : 0;
+	if (is_compat_thread(task_thread_info(next)))
+		write_sysreg(next->thread.tp_value, tpidrro_el0);
+	else if (!arm64_kernel_unmapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */

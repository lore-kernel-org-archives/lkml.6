Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vuQ8NHy3VtF6vCqPzo8rLoLL2dbS9ceCh6CXtqyqaZ2++huSbGdCbTS35KynryFfZpYUq
ARC-Seal: i=1; a=rsa-sha256; t=1523980961; cv=none;
        d=google.com; s=arc-20160816;
        b=YSDQGjNmQguJdCEG1gGBudQgxn39Np0QFrxk+uPrfJnIhXbQ1aod+jcZ4ueSoC5Uni
         h6gxS4X1Ih1adZ97Zw8wJnbCXiV7W8LtqQ/ZvtgACoGydCOFTBEzGUhg4g+qgWFsIDt/
         I2wGQc8CHQYsT+Xml7qp93TvOXygb50cSzgVZ6vtdwy6X4XIi5+1mzcaYSjkQoh/G81E
         25I+zG3MEmk7QDPHQhDfRmyZBDA0oYq7BVo0PPPUWjjA9K5uxbuybHAT1W++nFmQrDbU
         6z/KtUIqOrLTQgmLnFBmvKeRk+DGF8q0k8fwWUo/vQfW1bBtYyzspBaliJx5rbtKtNXv
         pKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YT8sung2xwOM85Yd0sLfqRaaQ/CS62tQrhmMpinCmtU=;
        b=WMY/XTYRjOBZU7wPR2CtKnMdgRtJCEHPRh7UmGWlT5ZmlDHcvNKjZbOhMRiciVwJc9
         bvrKcmLMRO1nj2PkMOJJL+8ANepmDbSQkaXGzvXQ+Ag+ngsjeJXLWPMWO1R240eC5wNe
         ro6qSXnrUvtlMorv+l0jtFGilGrDnX8IIUciF6v7ubj8nWvT5f+wh1Qm9dOfoqaHaoiR
         aNjvd5CbqAp7qrn9NlK1rlQuhAHuTdBS/6qRm8AZ/GfF1R45pyo75lkBscIo8Uw7Zc5q
         tFuIxtQqRjAYd1j0AO6/14w1FgeUQav5fk+t222C/sdwvlofHsiHoDbHBgTd8RjKTY4y
         lgbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@suse.de>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 30/68] x86/mce/AMD: Get address from already initialized block
Date: Tue, 17 Apr 2018 17:57:43 +0200
Message-Id: <20180417155750.564053358@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009860124329571?=
X-GMAIL-MSGID: =?utf-8?q?1598009860124329571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 27bd59502702fe51d9eb00450a75b727ec6bfcb4 upstream.

The block address is saved after the block is initialized when
threshold_init_device() is called.

Use the saved block address, if available, rather than trying to
rediscover it.

This will avoid a call trace, when resuming from suspend, due to the
rdmsr_safe_on_cpu() call in get_block_address(). The rdmsr_safe_on_cpu()
call issues an IPI but we're running with interrupts disabled. This
triggers:

    WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-8-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -436,6 +436,21 @@ static u32 get_block_address(unsigned in
 {
 	u32 addr = 0, offset = 0;
 
+	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+		return addr;
+
+	/* Get address from already initialized block. */
+	if (per_cpu(threshold_banks, cpu)) {
+		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
+
+		if (bankp && bankp->blocks) {
+			struct threshold_block *blockp = &bankp->blocks[block];
+
+			if (blockp)
+				return blockp->address;
+		}
+	}
+
 	if (mce_flags.smca) {
 		if (smca_get_bank_type(bank) == SMCA_RESERVED)
 			return addr;

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VkhcGcxwiRWc6vQnG5wfMYylrKIvRHjYZ5PZfq0ENhV5bkKiQTFmEp2+zC6ml5Jl/ObnR
ARC-Seal: i=1; a=rsa-sha256; t=1523981030; cv=none;
        d=google.com; s=arc-20160816;
        b=CPyttTrFrXDdbDe/zwJEUG4gD37gF5lpBTZ+OuZ12Cu4PfsfDxl4rQh3vB2SQTtzuh
         FVLsVhY5PCxTYi08tgOs5GAmMSlcyEAlpX3qaIPfNqalbb0TgbvJ4op0b2TUQPT2l+Z0
         87Wf546/4mEz5wEde5ocJIq+NjaUnFF9jA4ouC+OH6PdQQFb0X88/Spzg5VA3UpKfw30
         8jWlt+8lfWu2WrXPxnKWv356OaEHJRv+nf1kdoQtKY9HhOraw/aZ+TUI/dMCIcIgSMM0
         6wDAZ/GbAvNU9D6xxzQev+dtJ5FdN+tI80TYb8AQF5d8z9NNoCQJoHbA5+xY5PSPgyGL
         GCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qTWl/1G4yVcY9HcS2ZfG9QjP3D5exJloaNfzO8irfJ0=;
        b=c8fNQ5aP6BI2UIIPgnjfzRXSoKqO7laxj16WiRbbWawH42qf/hkIhoLv/JlEez7xUV
         NvqtuT/SDOZ8UulDeAQ4/K8Eab5EZp0AK6De6R9SYX1vataImUqkYyfLHt9TaZW180on
         IauD7v7Eio+EjO/N6hpk4QFmtAZHzoiKfcjyPJs+UZ1AH9AaVAk7IKanBTFn5JLYr12Z
         1COtLjlEM+HEJMGKcUV5S7ga4KNgZeyIRFY+0aepxJauvS0W6k562Etg6Vr2201Fz3AJ
         rqTcyNP8SfM6isk1tEoQRkjhEI/whpa/ns9wTY7VP1+c5nN2FSd3wR2v2OB/viQEmMCI
         ASoQ==
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
Subject: [PATCH 4.15 22/53] x86/mce/AMD: Get address from already initialized block
Date: Tue, 17 Apr 2018 17:58:47 +0200
Message-Id: <20180417155724.189120729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009860124329571?=
X-GMAIL-MSGID: =?utf-8?q?1598009933453164349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -416,6 +416,21 @@ static u32 get_block_address(unsigned in
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
 		if (!block) {
 			addr = MSR_AMD64_SMCA_MCx_MISC(bank);

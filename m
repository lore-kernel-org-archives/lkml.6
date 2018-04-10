Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49geO+mOIDJqhVlKucKcquvFyBkbraeooq3A9tZnhpCS5NNLWmvH5j2gD8KYcT0Aka3hzb2
ARC-Seal: i=1; a=rsa-sha256; t=1523399841; cv=none;
        d=google.com; s=arc-20160816;
        b=MJ6iTgBhA4DnQkiHWcMf+RhxquWOdZ2Tf/f9McEXRF/R8/r4enhepl/9BAYR0JMc6m
         vgu4GEBRvm72nBY0B8nvJXA3q4xiyevtlIhPlaJp513kErI3OsMcPwSAX+8odoV/nswK
         wN3KY+QaegzBVSNI9NQI0eVMleGCbAwKNPDryod/C6U2rMlfO2qVmG7QN7f1+kqzjtz5
         KgML8ShXx+tdsTbfyivbU7OA4WjWzzyi9EMIqmF1PWcnTDPKS4f9ifgfO3vdKpgROJFN
         Z5kFOHGWL/TJpVVPGzGUkiDkgNRsWEZ9iXTXtFzcUZ5YZVApD2FAdsNc/dM/ouO0fU/D
         rDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PNFgTWNKkrUCH5GBHpvDChK52uyFrHMgRFPj3fOBHZI=;
        b=Xt/cqShh/69TraKVRHdNGI4GpTGozzYFlE3EKa8yyGZnTqJo5Mg/ElBsX/brDUsosz
         7hkVOIif0jrovDrGCZaEFkQkEZ8Jlv4pTUitkoYSUMxRUoeUmnMRJCUxW9J44C0/u7qF
         h9EkCCobjLd5sjVColz5GnsZhV/5sL6QQCTum++S2pQLObutPbLvzU1pcPrkXgqRz+FE
         odVSIcoK15w4mFl1bEhv1MOAXvpXRnEhGiI4P1NFqKEObsdwXliV00AKrQzwlQHtFX15
         8nQIGrK698WXebBl6jtUw7Kgjy3mp2Z8BZ1QGFd8RQ7HrFYa2rN9D9IHsVTPMCEYbSdU
         6oKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 083/138] objtool: Add Clang support
Date: Wed, 11 Apr 2018 00:24:33 +0200
Message-Id: <20180410212911.858115266@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400512537270748?=
X-GMAIL-MSGID: =?utf-8?q?1597400512537270748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 3c1f05835cbf9fdfe60b81c718d82ceb94b6c55e upstream.

Since the ORC unwinder was made the default on x86_64, Clang-built
defconfig kernels have triggered some new objtool warnings:

  drivers/gpu/drm/i915/i915_gpu_error.o: warning: objtool: i915_error_printf()+0x6c: return with modified stack frame
  drivers/gpu/drm/i915/intel_display.o: warning: objtool: pipe_config_err()+0xa6: return with modified stack frame

The problem is that objtool has never seen clang-built binaries before.

Shockingly enough, objtool is apparently able to follow the code flow
mostly fine, except for one instruction sequence.  Instead of a LEAVE
instruction, clang restores RSP and RBP the long way:

   67c:   48 89 ec                mov    %rbp,%rsp
   67f:   5d                      pop    %rbp

Teach objtool about this new code sequence.

Reported-and-test-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/fce88ce81c356eedcae7f00ed349cfaddb3363cc.1521741586.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1385,6 +1385,17 @@ static int update_insn_state(struct inst
 				state->vals[op->dest.reg].offset = -state->stack_size;
 			}
 
+			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
+				 cfa->base == CFI_BP) {
+
+				/*
+				 * mov %rbp, %rsp
+				 *
+				 * Restore the original stack pointer (Clang).
+				 */
+				state->stack_size = -state->regs[CFI_BP].offset;
+			}
+
 			else if (op->dest.reg == cfa->base) {
 
 				/* mov %reg, %rsp */

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+c0hxN5ox2nwGAGUuweS7CywMdwUX2mN9vAokzX+Q+F9gGpz6BPciZuUkYNU0iChMkogT
ARC-Seal: i=1; a=rsa-sha256; t=1524405435; cv=none;
        d=google.com; s=arc-20160816;
        b=QZ9BmMiGorpBqeKv9Qwr/PHV1jPHlFsSxZhvpBG8iTjmZeLzXTPhkvpIhtGF1iNqBC
         hUj7jtRLf5RjNXrXM+FHdbs8FrchsCpFVT4W63YjBbWKC0SppMWZ0Gm3YYF97tTIGyzd
         ep7/87hMCGh/AXutY41BroZua9QV5+sGs6pXxxD9x1+GRjZEZ/e5mij/ZoL6aBknslal
         nvEmMjjrNYaLz7kOAdZ2SxT4/9TWZTKQPVodg+tDqnOuO1JPKzXCxa964mwaC7WrWOeh
         OhjlgLtiJWJHEANeFAcxt4hN9yQUnDHJRirwiR7yTRAbej1HC+fBtpDZm7VMW2WfHZtn
         h6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8SIe16ExkdHKPcNgbgEgu5/NcG85zzVBpqiR0UBut8Y=;
        b=x8umzn0WT2vV3idPZrchQN5wUZAbrHf76o1X/32ZRu2pHIyt2H+wPCP3rEdDTNiJvh
         a8a96VvAyhoBwAiciPv0zEIZi6lMGVI02veClazQJRZ5/ehJco3nutl80fGyoPJIiJaO
         +6OuVovQu/9EwMQVNHm+uros8YUn+Tb74fGRGgomstWvnK99W21SuuOIk3LEU+JlFCb6
         NtIylEFNnszbYzmaK5vEU1iS40kpk2BrrhaIzeUtLEy3plyKKvC/7LiJSGpi2VYNzyFK
         yiFwvsP3csCnodroZBR35uJQeGWrwM1GdeyDycHyg2IjioEbvge7SbNLEJIuWfZHVwP0
         1shA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH 4.16 065/196] powerpc/kprobes: Fix call trace due to incorrect preempt count
Date: Sun, 22 Apr 2018 15:51:25 +0200
Message-Id: <20180422135107.613454427@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454953524683601?=
X-GMAIL-MSGID: =?utf-8?q?1598454953524683601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

commit e6e133c47e6bd4d5dac05b35d06634a8e5648615 upstream.

Michael Ellerman reported the following call trace when running
ftracetest:

  BUG: using __this_cpu_write() in preemptible [00000000] code: ftracetest/6178
  caller is opt_pre_handler+0xc4/0x110
  CPU: 1 PID: 6178 Comm: ftracetest Not tainted 4.15.0-rc7-gcc6x-gb2cd1df #1
  Call Trace:
  [c0000000f9ec39c0] [c000000000ac4304] dump_stack+0xb4/0x100 (unreliable)
  [c0000000f9ec3a00] [c00000000061159c] check_preemption_disabled+0x15c/0x170
  [c0000000f9ec3a90] [c000000000217e84] opt_pre_handler+0xc4/0x110
  [c0000000f9ec3af0] [c00000000004cf68] optimized_callback+0x148/0x170
  [c0000000f9ec3b40] [c00000000004d954] optinsn_slot+0xec/0x10000
  [c0000000f9ec3e30] [c00000000004bae0] kretprobe_trampoline+0x0/0x10

This is showing up since OPTPROBES is now enabled with CONFIG_PREEMPT.

trampoline_probe_handler() considers itself to be a special kprobe
handler for kretprobes. In doing so, it expects to be called from
kprobe_handler() on a trap, and re-enables preemption before returning a
non-zero return value so as to suppress any subsequent processing of the
trap by the kprobe_handler().

However, with optprobes, we don't deal with special handlers (we ignore
the return code) and just try to re-enable preemption causing the above
trace.

To address this, modify trampoline_probe_handler() to not be special.
The only additional processing done in kprobe_handler() is to emulate
the instruction (in this case, a 'nop'). We adjust the value of
regs->nip for the purpose and delegate the job of re-enabling
preemption and resetting current kprobe to the probe handlers
(kprobe_handler() or optimized_callback()).

Fixes: 8a2d71a3f273 ("powerpc/kprobes: Disable preemption before invoking probe handler for optprobes")
Cc: stable@vger.kernel.org # v4.15+
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/kprobes.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -455,29 +455,33 @@ static int trampoline_probe_handler(stru
 	}
 
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-	regs->nip = orig_ret_address;
+
 	/*
-	 * Make LR point to the orig_ret_address.
-	 * When the 'nop' inside the kretprobe_trampoline
-	 * is optimized, we can do a 'blr' after executing the
-	 * detour buffer code.
+	 * We get here through one of two paths:
+	 * 1. by taking a trap -> kprobe_handler() -> here
+	 * 2. by optprobe branch -> optimized_callback() -> opt_pre_handler() -> here
+	 *
+	 * When going back through (1), we need regs->nip to be setup properly
+	 * as it is used to determine the return address from the trap.
+	 * For (2), since nip is not honoured with optprobes, we instead setup
+	 * the link register properly so that the subsequent 'blr' in
+	 * kretprobe_trampoline jumps back to the right instruction.
+	 *
+	 * For nip, we should set the address to the previous instruction since
+	 * we end up emulating it in kprobe_handler(), which increments the nip
+	 * again.
 	 */
+	regs->nip = orig_ret_address - 4;
 	regs->link = orig_ret_address;
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
 	}
-	/*
-	 * By returning a non-zero value, we are telling
-	 * kprobe_handler() that we don't want the post_handler
-	 * to run (and have re-enabled preemption)
-	 */
-	return 1;
+
+	return 0;
 }
 NOKPROBE_SYMBOL(trampoline_probe_handler);
 

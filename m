Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAG1UT2RDJrlgvtlWN5r4dP/V7p1IXhMCNFlQ2cNgMu1zV3dRRSQH+8WF7uuhJL8m01nWQ
ARC-Seal: i=1; a=rsa-sha256; t=1519412238; cv=none;
        d=google.com; s=arc-20160816;
        b=HlG9A5iHZWuQmA0eTqL9r5vd5WYL665ALU+z6cApyYBm+xigrbPjTh/YGeNetZNWZE
         q7bry1grMsBZYAvJVbqQcIFYmlTZ4udIBbpK8sIn/sTa0z0rfDn3JJuRZnek+gh3eyzj
         Jhjs6H98gtvziuN4HJ7xbwmdZMxknSepqQYFaO7JuUkQaRuOmhVB8f3CdQspCTNn0tAF
         U4CioubOBBgejeCKy2PcaHMrnUczM7acJ4WDfYIMJod/izkuD0xdssbTgs1dxRc4AyLq
         7i4WJAJAPaH1srfB1ZDx13bWeUj5jcRhbFuL56/mu7LHIfzD9nP9k6ARL0HpdsSTNskR
         QiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5/AlM9oj183c0CHmJ0h8cwAoOFMpZLLR4DYRKGqyOPs=;
        b=mvie1ZxQERbSWUpp+xctcFKEJIsaNRA6+4ptmXAZLcOWFabfwq9RIgY6T3n0aWyguj
         dGjGavKE24BOiXqjKpDC5OX432zR7gPlumF6cTxycU7rLUp+UR4SRe7SPRQfoxEHffO/
         ssVn7hN8aKYxWR09yB5EfVAFe8k2hK2haCwq8TqRYz15VJWbB15QSCqBqmIQHbX7Ju+X
         OU1G0DPW+L+CwM2VvKC4QgoAwjNQn9/pNuQs0m7ITgcvaagQEvbVSfTLKuv+MI4ZjtAr
         /ICOXs9LdXLpZ44vczT0L5DBSWzkHF7eluhCT9I7wwW2BEuPbInWvz0cEHSzuPHusbPq
         aEiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>
Subject: [PATCH 4.15 11/45] KVM: x86: fix escape of guest dr6 to the host
Date: Fri, 23 Feb 2018 19:28:50 +0100
Message-Id: <20180223170717.106961823@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217684161240424?=
X-GMAIL-MSGID: =?utf-8?q?1593219207459718220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit efdab992813fb2ed825745625b83c05032e9cda2 upstream.

syzkaller reported:

   WARNING: CPU: 0 PID: 12927 at arch/x86/kernel/traps.c:780 do_debug+0x222/0x250
   CPU: 0 PID: 12927 Comm: syz-executor Tainted: G           OE    4.15.0-rc2+ #16
   RIP: 0010:do_debug+0x222/0x250
   Call Trace:
    <#DB>
    debug+0x3e/0x70
   RIP: 0010:copy_user_enhanced_fast_string+0x10/0x20
    </#DB>
    _copy_from_user+0x5b/0x90
    SyS_timer_create+0x33/0x80
    entry_SYSCALL_64_fastpath+0x23/0x9a

The testcase sets a watchpoint (with perf_event_open) on a buffer that is
passed to timer_create() as the struct sigevent argument.  In timer_create(),
copy_from_user()'s rep movsb triggers the BP.  The testcase also sets
the debug registers for the guest.

However, KVM only restores host debug registers when the host has active
watchpoints, which triggers a race condition when running the testcase with
multiple threads.  The guest's DR6.BS bit can escape to the host before
another thread invokes timer_create(), and do_debug() complains.

The fix is to respect do_debug()'s dr6 invariant when leaving KVM.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2939,6 +2939,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 	pagefault_enable();
 	kvm_x86_ops->vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
+	/*
+	 * If userspace has set any breakpoints or watchpoints, dr6 is restored
+	 * on every vmexit, but if not, we might have a stale dr6 from the
+	 * guest. do_debug expects dr6 to be cleared after it runs, do the same.
+	 */
+	set_debugreg(0, 6);
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,

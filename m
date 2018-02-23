Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu/yyCUKPSIIQMFgdHWWm+z+3pckQ6AErg/mXDoxckUcRTjRtIw1b3hA6Zy4pwWi+BLiwdZ
ARC-Seal: i=1; a=rsa-sha256; t=1519411857; cv=none;
        d=google.com; s=arc-20160816;
        b=lMR78gY9TypJbqymFwlJwJ+NwY/boDt9WWyqvLh0XeVjZMeUkoiPkiNKZ7kp3DbIZW
         cg1gQRW/8PLWVDAHGXhzgDauo67+vh1dflAvxYJ2ufuTobI5fglRVMEosK6KixtvDsCm
         OCy9nB4xTk15c1y6eWja17wUROuIOf4UJWPGG3rfOnyQdMPS//5LJXbu2CKAcTIl90pJ
         P9Mk8EWsx43zn4xEa3KeiP2otgy88E5qhlQ205V3FDCw3JqrhO0v+zzr8yVXJ8YJx8Ta
         AGOob/GveOSzkAGxHX2kovKOehy8ZidCCbZY5JwadZD/Aq9zcGrYUlKaYHmWwJ4uhyz0
         Pxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HpvtrO3twBN/BvXHadsEesS0bF0ZWiVlQkn5iWbU7wA=;
        b=uEawkbOlenUxyHIFnoQ+fwQ4qMDVsV4wFNHes2RXkQE529DwKe+z4P4IBtpZZmfRgr
         kN1SEfoYuHjW85Tj0hi/lxiL4NfjHL0O3U1W7h1PTOmH820fa9N0YgjOXHEz8xWLAqUk
         pw/lwMCJEKhqZU13yE5iLe6lICOpCEtpmxaprLC7YnM4IGGNgClRO4cLkPFEMy33oCoI
         32Llr7/dVyMs69doTjLp3R0MVg3TMCSKsvLNDODUoGe7DAKZ6AtrZkDv2F+g+w+ziDJC
         a9AnlNmQ5ch9eGKA3RKG9m5xKLR7307m/cO2zLa8LSn0Ky6KiwdAP2ERrcbR+WNDAVR+
         YSHw==
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
Subject: [PATCH 4.14 033/159] KVM: x86: fix escape of guest dr6 to the host
Date: Fri, 23 Feb 2018 19:25:41 +0100
Message-Id: <20180223170747.311455615@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217684161240424?=
X-GMAIL-MSGID: =?utf-8?q?1593218807534873505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2926,6 +2926,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
+	/*
+	 * If userspace has set any breakpoints or watchpoints, dr6 is restored
+	 * on every vmexit, but if not, we might have a stale dr6 from the
+	 * guest. do_debug expects dr6 to be cleared after it runs, do the same.
+	 */
+	set_debugreg(0, 6);
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,

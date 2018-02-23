Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242tOT12X2ACBKFTzSiOiSe2dFIStKgJCg17upTX2vU137lMmwJhuDQWSnBdlepBQQPbtyd
ARC-Seal: i=1; a=rsa-sha256; t=1519410741; cv=none;
        d=google.com; s=arc-20160816;
        b=zumZvWg82VSPQ46mywfveLkwsCM4+cS23qD06Tz3wHLTdTg8Gzg/hnVSp/K42x56e4
         ta4KO7JhjvsR2FAldnAYUWrH1L0HUrXjRkplKCLkoc90GSdSN10BVc/pvGAUajvavMAf
         alCijJK3Ql4oP130KhN9oHFNh55fL7RoVJST0elINo7HU8VP3M3wQJZQK+R7CX8gp8MD
         GaElsksafALyX/ipT/I1Y3aIodrviOc28ElBj3KZsRLPM02sKzL/54YsUq9xEhs52htw
         01a8IHmJcWZbtNy7wlSeCm0xCETwbuYqgMZejIdPGZMbxT///rfnz+YMdf3GTcdMXrZJ
         N+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8CDhmKW1Qbevhs/TjEWpiv9atP9kzbZ4b3TBtDsozaw=;
        b=FHd2M98beVHT/JII6muVgPSjhLcSXw4oFrAhfNN3HGBAxFvVDCkTDUvDEqNetLJPuA
         8XJ+me8v2P7hNNhy8q705ClS3CuxjLkZJiYHt6Yfa1ZtRnDBCVSKDZG0xUH/Y1K7T23I
         nf2dUebiBKZj5VxKGMU3RrGoxagsBZue3QRqI30hZFgT1d83LgAgJqhBdVL5uEwlWdqx
         L4O4B3xS+Y8bSqzktTH/yoPdDp8U2gN0zqbOC5NE8DUQQ7l8s/4oI3fcn9CjYcQ8MbmI
         VyX8t4GSOThvjT/WnPs4BJUyocYa+tVcRPz+0oRCn05gdWQjrTvk5DiML8AgUV2m0FTZ
         34cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 3.18 57/58] KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously
Date: Fri, 23 Feb 2018 19:26:56 +0100
Message-Id: <20180223170215.665624911@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217637115498580?=
X-GMAIL-MSGID: =?utf-8?q?1593217637115498580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit 9a6e7c39810e4a8bc7fc95056cefb40583fe07ef upstream.

qemu-system-x86-8600  [004] d..1  7205.687530: kvm_entry: vcpu 2
qemu-system-x86-8600  [004] ....  7205.687532: kvm_exit: reason EXCEPTION_NMI rip 0xffffffffa921297d info ffffeb2c0e44e018 80000b0e
qemu-system-x86-8600  [004] ....  7205.687532: kvm_page_fault: address ffffeb2c0e44e018 error_code 0
qemu-system-x86-8600  [004] ....  7205.687620: kvm_try_async_get_page: gva = 0xffffeb2c0e44e018, gfn = 0x427e4e
qemu-system-x86-8600  [004] .N..  7205.687628: kvm_async_pf_not_present: token 0x8b002 gva 0xffffeb2c0e44e018
    kworker/4:2-7814  [004] ....  7205.687655: kvm_async_pf_completed: gva 0xffffeb2c0e44e018 address 0x7fcc30c4e000
qemu-system-x86-8600  [004] ....  7205.687703: kvm_async_pf_ready: token 0x8b002 gva 0xffffeb2c0e44e018
qemu-system-x86-8600  [004] d..1  7205.687711: kvm_entry: vcpu 2

After running some memory intensive workload in guest, I catch the kworker
which completes the GUP too quickly, and queues an "Page Ready" #PF exception
after the "Page not Present" exception before the next vmentry as the above
trace which will result in #DF injected to guest.

This patch fixes it by clearing the queue for "Page not Present" if "Page Ready"
occurs before the next vmentry since the GUP has already got the required page
and shadow page table has already been fixed by "Page Ready" handler.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Fixes: 7c90705bf2a3 ("KVM: Inject asynchronous page fault into a PV guest if page is swapped out.")
[Changed indentation and added clearing of injected. - Radim]
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[port from upstream v4.14-rc1, Don't assign to kvm_queued_exception::injected or
 x86_exception::async_page_fault]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7756,6 +7756,13 @@ static int apf_put_user(struct kvm_vcpu
 				      sizeof(val));
 }
 
+static int apf_get_user(struct kvm_vcpu *vcpu, u32 *val)
+{
+
+	return kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.apf.data, val,
+				      sizeof(u32));
+}
+
 void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 				     struct kvm_async_pf *work)
 {
@@ -7782,6 +7789,7 @@ void kvm_arch_async_page_present(struct
 				 struct kvm_async_pf *work)
 {
 	struct x86_exception fault;
+	u32 val;
 
 	if (work->wakeup_all)
 		work->arch.token = ~0; /* broadcast wakeup */
@@ -7789,14 +7797,24 @@ void kvm_arch_async_page_present(struct
 		kvm_del_async_pf_gfn(vcpu, work->arch.gfn);
 	trace_kvm_async_pf_ready(work->arch.token, work->gva);
 
-	if ((vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED) &&
-	    !apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
-		fault.vector = PF_VECTOR;
-		fault.error_code_valid = true;
-		fault.error_code = 0;
-		fault.nested_page_fault = false;
-		fault.address = work->arch.token;
-		kvm_inject_page_fault(vcpu, &fault);
+	if (vcpu->arch.apf.msr_val & KVM_ASYNC_PF_ENABLED &&
+	    !apf_get_user(vcpu, &val)) {
+		if (val == KVM_PV_REASON_PAGE_NOT_PRESENT &&
+		    vcpu->arch.exception.pending &&
+		    vcpu->arch.exception.nr == PF_VECTOR &&
+		    !apf_put_user(vcpu, 0)) {
+			vcpu->arch.exception.pending = false;
+			vcpu->arch.exception.nr = 0;
+			vcpu->arch.exception.has_error_code = false;
+			vcpu->arch.exception.error_code = 0;
+		} else if (!apf_put_user(vcpu, KVM_PV_REASON_PAGE_READY)) {
+			fault.vector = PF_VECTOR;
+			fault.error_code_valid = true;
+			fault.error_code = 0;
+			fault.nested_page_fault = false;
+			fault.address = work->arch.token;
+			kvm_inject_page_fault(vcpu, &fault);
+		}
 	}
 	vcpu->arch.apf.halted = false;
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;

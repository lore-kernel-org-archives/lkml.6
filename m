Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJ1FvBBzw6DIq8Rxcz4gVZ89gqCewGysEqwZxJinMG5eJRi8VNRXrIzYDXrYqvWDFddTVs
ARC-Seal: i=1; a=rsa-sha256; t=1525116537; cv=none;
        d=google.com; s=arc-20160816;
        b=ha2zD113/WwrbMLyJUpL4TMb2jwCHsutRa5X4fmYIN1sR898qS2omWfISMv8B9JzRx
         g4G1V4F7ecb33rrZJgWMuNygghtP3WPnccoG1Ok2jGVsuoO+rrC5RUj0N1suyGc8Att1
         74wwFJ8Qgea74/9LMvDayJNUMGdf4lAo2kYZkVAIvGfn7+q/WCTvx8Tem6TIIfAcVuCy
         apxSxMyTPE8+KroWGulDKI1MEwQMyVffgWMyPePeFL3uhSvNBJ/IEQ07xLbcmYoDCcSk
         HbyC/Mi2Kwd75VjZMawEJmbZjDgf/JnDhJZJiULJOACtBC7apiPSlv/IMKIuZnuNLt4L
         Wllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=AI02XonvfkK+fF5r5lW7sRBRc6O3OUxhm9flUhSoDpU=;
        b=LG50UQOVLB9EXFFRQL2nELB0+vFKiRLb7rfIzsTkc0iZ63Sj59kRmcZE6HGiI5fkP3
         t/DQWnY+hibeBwrJqPGNgukZ1v3Z0FroFnYRQkJ+fvpwjfqr15HeYm6cd3j3WweoPSBj
         Q0ErekGMlH+9dPoiK7bIm/ipnU6fjxWWmj5MW+PUrZ69dN4nIXPC+7oCxdDjXAtG/wKH
         tR2CJjVBeT6VHTqbx0szXeC448howjVpWGpaQ1haP17qz5Q+h6W1gLlzMge4kL0SYZz9
         NpiQClxWblHYeAK6ff/zoxR+at72GO8h83kU/sG/YYXuAHwAaaGW9lBnEAt/12Zv7Add
         2Pbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5867922DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Shannon Zhao <zhaoshenglong@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.16 078/113] KVM: arm/arm64: Close VMID generation race
Date: Mon, 30 Apr 2018 12:24:49 -0700
Message-Id: <20180430184018.481197643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200599118656888?=
X-GMAIL-MSGID: =?utf-8?q?1599200599118656888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit f0cf47d939d0b4b4f660c5aaa4276fa3488f3391 upstream.

Before entering the guest, we check whether our VMID is still
part of the current generation. In order to avoid taking a lock,
we start with checking that the generation is still current, and
only if not current do we take the lock, recheck, and update the
generation and VMID.

This leaves open a small race: A vcpu can bump up the global
generation number as well as the VM's, but has not updated
the VMID itself yet.

At that point another vcpu from the same VM comes in, checks
the generation (and finds it not needing anything), and jumps
into the guest. At this point, we end-up with two vcpus belonging
to the same VM running with two different VMIDs. Eventually, the
VMID used by the second vcpu will get reassigned, and things will
really go wrong...

A simple solution would be to drop this initial check, and always take
the lock. This is likely to cause performance issues. A middle ground
is to convert the spinlock to a rwlock, and only take the read lock
on the fast path. If the check fails at that point, drop it and
acquire the write lock, rechecking the condition.

This ensures that the above scenario doesn't occur.

Cc: stable@vger.kernel.org
Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arm.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -63,7 +63,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *,
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
 static unsigned int kvm_vmid_bits __read_mostly;
-static DEFINE_SPINLOCK(kvm_vmid_lock);
+static DEFINE_RWLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -470,11 +470,16 @@ static void update_vttbr(struct kvm *kvm
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
+	bool new_gen;
 
-	if (!need_new_vmid_gen(kvm))
+	read_lock(&kvm_vmid_lock);
+	new_gen = need_new_vmid_gen(kvm);
+	read_unlock(&kvm_vmid_lock);
+
+	if (!new_gen)
 		return;
 
-	spin_lock(&kvm_vmid_lock);
+	write_lock(&kvm_vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -482,7 +487,7 @@ static void update_vttbr(struct kvm *kvm
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		spin_unlock(&kvm_vmid_lock);
+		write_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -516,7 +521,7 @@ static void update_vttbr(struct kvm *kvm
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 	kvm->arch.vttbr = kvm_phys_to_vttbr(pgd_phys) | vmid;
 
-	spin_unlock(&kvm_vmid_lock);
+	write_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)

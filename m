Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoJ6WqSn3r6GRJbc2vd4YVeXYKhommkDhFcdp1UhmX3LsUhTYR8cSJxfUBRezlEVaFaqENu
ARC-Seal: i=1; a=rsa-sha256; t=1525116468; cv=none;
        d=google.com; s=arc-20160816;
        b=TCJGWglyywGsoR+io5DbnOC0jqYMnEfQ4jz/a7B6Oq2pFEE+VZQxxsboTqz7vjldOM
         cnK4xKmHSpdti62QuuY6h3dDDiN5rR1ytwAXJ6z3XUfDaLv3Maq8RJodi7KzrG5VS3eo
         1dEisSzb/nndnSastR/Pg2lcR3dtC5CsAH1KNe7+DouhGzQAAufOpKkVRPndvm3sMlVV
         CYl2Xo/VjVy9uLLt0XObifl6rGvT88NSsr7RNRgMHqyW8P5QaMWHupRnNST8Jvm50PnW
         7NJ4Xsi0n94nvtkPr2QI7yguNAEpD1WGvUWl1K3NuOx5HajzhqLSiYGJVoT7m4NlWADQ
         co5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Se02EUgjj+69eTjbOIA3e10bSuLDFjAVbc0CrjR1K+U=;
        b=Ih+JPuZQCeCQwNKKAJAeXND6HmEGgBkNO/N+qNG1ALsiEQt1hlHleCEhASw0+92XEg
         Xmt3fM+gylu/7yg7weO7R2pi5vzqV5ZgT7u/y7XTonjYz/Xb/8DMy4tT7eg3bAnMEgpT
         d3BjaM6P8YG6NgrXNMqxGNJJAeinzogyGLUJchO3JNkSrerwpXLHhAz87bJ46ao4z5lW
         1YxAUMi8WwENW+BClQ1k0XUgUeSSpg7/NZke4rq2udZYC1Ut461gM7b7WjwGgcD+4nif
         CGn8wz25h0NcdC7pMppavS8zJRFyyNwUB2teSu2OW3FRXFMh7La2lX049qVL80K06iZt
         4guw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B8122E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Shannon Zhao <zhaoshenglong@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 68/91] KVM: arm/arm64: Close VMID generation race
Date: Mon, 30 Apr 2018 12:24:50 -0700
Message-Id: <20180430184007.791224754@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200599118656888?=
X-GMAIL-MSGID: =?utf-8?q?1599200526070147653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -61,7 +61,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *,
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
 static unsigned int kvm_vmid_bits __read_mostly;
-static DEFINE_SPINLOCK(kvm_vmid_lock);
+static DEFINE_RWLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -462,11 +462,16 @@ static void update_vttbr(struct kvm *kvm
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
@@ -474,7 +479,7 @@ static void update_vttbr(struct kvm *kvm
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		spin_unlock(&kvm_vmid_lock);
+		write_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -508,7 +513,7 @@ static void update_vttbr(struct kvm *kvm
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
 	kvm->arch.vttbr = pgd_phys | vmid;
 
-	spin_unlock(&kvm_vmid_lock);
+	write_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)

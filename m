Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvScnH9wJxvjHQNxGuwZX5n8Pkzt4cv2mVIsGW/JJ1FTFLAdkEj0FHksY95kJ4KxT1kw1Pq
ARC-Seal: i=1; a=rsa-sha256; t=1520452076; cv=none;
        d=google.com; s=arc-20160816;
        b=bymPMzFuHtdDNDedIkpueu/9m7S9jpOXEYqDd7+B8xXNtdHhcbCG1PtBVxJIuflK3Q
         g5YJihhJzU3TJUkPsBx5ato8kqhd02v6ZLHMRHTXxvaUqD3pXmzc7UdIF6EP6+63jb/e
         YM/JdfljMUPhDjcgaWpZruqX18IzivoMDDVho7tifYEyKfu6GvPzG2gTF2Elx8RrkwhW
         l/DPmFSyhWJzxJ6/iKzX60wG5cK8vPGouGOIf7mnm5UvsSPWpkiwZ0s0coGvZzTdePCK
         FjBivFEkiYwpryVBj9f/jPduL1ydPp2CbUrOLVXq4H5du7G7zryRTmiedjim8XCdClnz
         D9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JoK7RHZWr75GOKhsr9Tz/qBeMCy/NsXqjFBlCjMyFQQ=;
        b=n9YMYE+QC26BjO1QfB1JiZN6doJbzZ47wP436RlS1nSZ4IVqzILnogcfHNAUuQWVSR
         kOCGwYfkh+Mqvw3AbTn9t6ASRKcT9zHCcR7qOrfuQBjiTnitgkCCcFEb4ql76KVa4G4D
         QRoiqCrgzPZ5DcXLPSmNWyyz8IkX/eiLfx/lVe0OWXKk9F+QLtzjSkQwgIDTMD6gMm9t
         21AF35d2boqpWLXvuzJQZqJUf71RWuZcZIaCvvDn8AeVf633McSv/110MkHug+Za2vWP
         f0sAo7oi8bMXZEOxZN6afcGJaCIecbNVd6DOuAxecWFsVV0Zo3crDT55cPGmAWY55uR2
         xxUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liran Alon <liran.alon@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 100/110] KVM: x86: move LAPIC initialization after VMCS creation
Date: Wed,  7 Mar 2018 11:39:23 -0800
Message-Id: <20180307191052.654831952@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309330030468200?=
X-GMAIL-MSGID: =?utf-8?q?1594309556097913377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 0b2e9904c15963e715d33e5f3f1387f17d19333a upstream.

The initial reset of the local APIC is performed before the VMCS has been
created, but it tries to do a vmwrite:

 vmwrite error: reg 810 value 4a00 (err 18944)
 CPU: 54 PID: 38652 Comm: qemu-kvm Tainted: G        W I      4.16.0-0.rc2.git0.1.fc28.x86_64 #1
 Hardware name: Intel Corporation S2600CW/S2600CW, BIOS SE5C610.86B.01.01.0003.090520141303 09/05/2014
 Call Trace:
  vmx_set_rvi [kvm_intel]
  vmx_hwapic_irr_update [kvm_intel]
  kvm_lapic_reset [kvm]
  kvm_create_lapic [kvm]
  kvm_arch_vcpu_init [kvm]
  kvm_vcpu_init [kvm]
  vmx_create_vcpu [kvm_intel]
  kvm_vm_ioctl [kvm]

Move it later, after the VMCS has been created.

Fixes: 4191db26b714 ("KVM: x86: Update APICv on APIC reset")
Cc: stable@vger.kernel.org
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    1 -
 arch/x86/kvm/x86.c   |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2107,7 +2107,6 @@ int kvm_create_lapic(struct kvm_vcpu *vc
 	 */
 	vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
 	static_key_slow_inc(&apic_sw_disabled.key); /* sw disabled at reset */
-	kvm_lapic_reset(vcpu, false);
 	kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
 
 	return 0;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7779,6 +7779,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 	if (r)
 		return r;
 	kvm_vcpu_reset(vcpu, false);
+	kvm_lapic_reset(vcpu, false);
 	kvm_mmu_setup(vcpu);
 	vcpu_put(vcpu);
 	return r;

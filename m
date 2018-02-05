Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224BEwwJvkyNJ0YLlvfOhVmzAYc7C3LIYu55n+1pBtsq8zPJ2HMNmCm7/Lb3k4e5S3CxrPzu
ARC-Seal: i=1; a=rsa-sha256; t=1517855028; cv=none;
        d=google.com; s=arc-20160816;
        b=eVljo3O0YFIvxUcbOorlV6PBWN5m2nmJWGFDz/HC84TbsQn3reX7XVA5g2pOwQ8xUH
         J3rhty32debefPhU4Wp4PwfqlPDCD3ipfswx1TAhc9rdOvXFjjRo6PW3Ia6Zg3D9Of/W
         f+S1Xcw//HLjkic34OuOqtrQRShBeCUivBkIaFAyHYRxKohctFsVmQJwxJORDhOrMCmI
         r7U6VW1dl0HnJwTIjyZqFrqMPrE4N+qT5AfofeGs96Flap0UnGrHIwD1O2Qpbo8q7U7e
         c81E3MjwuX7ptfVr53TNMo6k+ufj82SUbjp3TL1iLYhhI7h7jEIOsRXUMybQPl/HuRpX
         Yc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gkOp/9cAPDJtxoI/tkHdkTzSRlpg2TNvrUMj/64zWVI=;
        b=Xoc6bH/5Gaw/Y+MTVl57BXLeEaQjuVeeWn+srpusDJ0Zpll/w1W+4HNqD3yPJV0Q+t
         JdSrExAWIke8TCXYemgjWnh3SgVU8WnrRNtsQ5IEhmCvXdOugOlivOwhWveaIvXhp4Eq
         zHjzfS+q2Pl2gILxT7ioh/hFU+x0iUkBTt+4k9iDGs4M+a2K/AOMcqHGG8mQnlX8w0z7
         D3sChBkh1P2qCk1mAiBZrqtGcD0gKNaBjgyOr6IsQglOig12ZPjlv7lKDimKqjV94CyB
         9PHw8OSCvV16nQhlb6Gd/5LTOYpHnajCS5yTRF4qY6Nh8F0BGf0aPlagyiheURrD3sZ1
         KFcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 27/64] KVM: VMX: introduce alloc_loaded_vmcs
Date: Mon,  5 Feb 2018 10:22:46 -0800
Message-Id: <20180205182139.673376976@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586354878827231?=
X-GMAIL-MSGID: =?utf-8?q?1591586354878827231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini pbonzini@redhat.com

commit f21f165ef922c2146cc5bdc620f542953c41714b

Group together the calls to alloc_vmcs and loaded_vmcs_init.  Soon we'll also
allocate an MSR bitmap there.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3814,11 +3814,6 @@ static struct vmcs *alloc_vmcs_cpu(int c
 	return vmcs;
 }
 
-static struct vmcs *alloc_vmcs(void)
-{
-	return alloc_vmcs_cpu(raw_smp_processor_id());
-}
-
 static void free_vmcs(struct vmcs *vmcs)
 {
 	free_pages((unsigned long)vmcs, vmcs_config.order);
@@ -3837,6 +3832,22 @@ static void free_loaded_vmcs(struct load
 	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
 }
 
+static struct vmcs *alloc_vmcs(void)
+{
+	return alloc_vmcs_cpu(raw_smp_processor_id());
+}
+
+static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
+{
+	loaded_vmcs->vmcs = alloc_vmcs();
+	if (!loaded_vmcs->vmcs)
+		return -ENOMEM;
+
+	loaded_vmcs->shadow_vmcs = NULL;
+	loaded_vmcs_init(loaded_vmcs);
+	return 0;
+}
+
 static void free_kvm_area(void)
 {
 	int cpu;
@@ -7135,12 +7146,11 @@ static int enter_vmx_operation(struct kv
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs *shadow_vmcs;
+	int r;
 
-	vmx->nested.vmcs02.vmcs = alloc_vmcs();
-	vmx->nested.vmcs02.shadow_vmcs = NULL;
-	if (!vmx->nested.vmcs02.vmcs)
+	r = alloc_loaded_vmcs(&vmx->nested.vmcs02);
+	if (r < 0)
 		goto out_vmcs02;
-	loaded_vmcs_init(&vmx->nested.vmcs02);
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
@@ -9535,13 +9545,11 @@ static struct kvm_vcpu *vmx_create_vcpu(
 	if (!vmx->guest_msrs)
 		goto free_pml;
 
-	vmx->loaded_vmcs = &vmx->vmcs01;
-	vmx->loaded_vmcs->vmcs = alloc_vmcs();
-	vmx->loaded_vmcs->shadow_vmcs = NULL;
-	if (!vmx->loaded_vmcs->vmcs)
+	err = alloc_loaded_vmcs(&vmx->vmcs01);
+	if (err < 0)
 		goto free_msrs;
-	loaded_vmcs_init(vmx->loaded_vmcs);
 
+	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;

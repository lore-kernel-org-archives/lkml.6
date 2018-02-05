Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227V0FxkBe0u17CdFGqDjZOnrOhaYT8vf5ejDEtm4sS4aG6K3cEYaKrMox4N+cl9pWne8YTB
ARC-Seal: i=1; a=rsa-sha256; t=1517855160; cv=none;
        d=google.com; s=arc-20160816;
        b=0BHhCHmerls+bLlLfIqecuIiyOpsDZU9Cqy/huDakBRlIHRDHy/zgHNtvJS5DTxmph
         boLKLWhNjQHOidps/5vk4r0wDpVBvq0ATy3Li/59g0TaGymyAHdGqyzcN6Er1czU0OOM
         B6VO9IyO8dspNAcu44hfC3duxR19f7WWCAbZVcHj82AziF38eVlK2AcEAUwRSTdexfuA
         plCueEqfrrq73IqNde532M/OgPHyb78o3IOrqnMt1mzFiLReP709xADF2eurTOHuNVq/
         kh3h4jeyaimMVvJshbMGPRKqyRNNSuLtA3ZOWoCUb15qFm6s4ojikT88pwsXww15rojx
         1pwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8/c79yjkb+e4BWYTydubxG1iRcLOOUgQAv56Cx/mW2M=;
        b=XqB4NXx7PJbsuzLokxGT4Rj1sUAWEnXZ6+i31EfoFgcweHlPt3uxq3ksn/HXKYHSi8
         rVYhtb9mDOESXqZDSOWSS3ToGJApDyEdEb5ZLEPvxPupf+uJ2VNFTCqjZYUc+KuaGVOY
         oBWoRx2ksvtD5g/FuP3g35WWvmUdsRdnYbwKfcII8QbS3ZCxoJd5KqwEehiLPaz4PkPG
         0twbVxtywMhAIYc4an0IZERsgljnDXiyCGmfIiQ1irZ+TwyJ8NEjmd6UcHRZCCf39x2A
         UZEjXTN02PbsZ84MqsJIYky7wAs2vlg31E8FFJurI/nnV2b7YYxO4WCjs9Kk8lV0erDI
         3Gjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.15 23/60] KVM: VMX: introduce alloc_loaded_vmcs
Date: Mon,  5 Feb 2018 10:22:56 -0800
Message-Id: <20180205182214.882760776@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586354878827231?=
X-GMAIL-MSGID: =?utf-8?q?1591586493127164039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3829,11 +3829,6 @@ static struct vmcs *alloc_vmcs_cpu(int c
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
@@ -3852,6 +3847,22 @@ static void free_loaded_vmcs(struct load
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
@@ -7145,12 +7156,11 @@ static int enter_vmx_operation(struct kv
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
@@ -9545,13 +9555,11 @@ static struct kvm_vcpu *vmx_create_vcpu(
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

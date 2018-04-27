Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq8CzzzfPMLWSokVD3uyqePXCUArXm+Qri+GXIVfMeORVxBBfr3kwvytu9mTS6KfBrQE2zX
ARC-Seal: i=1; a=rsa-sha256; t=1524837843; cv=none;
        d=google.com; s=arc-20160816;
        b=kohRZ4sS3r5GYSELuM+4PSX4QntlZ4FqKxURRezM9TLni5oNRQ2HmWtAc4TCYnlLWy
         xQl/aKx0AwNGrkT/A1AtT84HiieeW2Kafwl+i9qIS/zMObW7FwN5sfghXRC1hF6cn1DA
         vAF5a3LtPZiBISqw+/DD/sHt+ZCsQ1zNGw9iRNFlEAMbpDGBwWPb25O2Ne0iMXd1dAgt
         1ljWzp7reG1DLJsm4jLy9yum1fCOh7HeAyF7VqUTFtILu/kbAk5QWxOT5YbXDHdG3Ott
         bjpFcMVr0aQszew2QD6NcLegFHa/fhcEgfnwiYVnJVs1bW1E/iNj+EfAXmJ2XcbIV++5
         t9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=M7KvcBf49SmgBzJdQ3Kr/GC17gDEUcJWJPX8dlWCzwg=;
        b=fN4kZxcAKT+a9jIIpf+0gw758Jl5kfsl08j1f27SyUnbpdXHKH/Y1IoxRRCPMU37PF
         SfpQjzluMT9GrQIiUUl2K8XAFTPQ7oU5LT+TjDcP+eWHrHb1KBVN1m8GuZSOeocnYfGf
         Y0RV/JVqpYeySui1s/rcFLFlZuy/wh1Y9mcqFJBVf9CiF8xW/AIGf7zkL8QDE5J5nv2z
         FYXIiw/sEX0HnF5P+1gnPZepq7zwIUtaxZsJtPHbmv8gn2CpQvY4DEMH3kxhEhAh2LmA
         ZD0Ft7ILo0RrKKONgGeHKtjOMuOFqah6fcJfFEEuahMOmmsNvda9EfHLvHqmMh+1gTbf
         g8Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC7221890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Janosch Frank <frankja@linux.vnet.ibm.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH 4.9 37/74] KVM: s390: force bp isolation for VSIE
Date: Fri, 27 Apr 2018 15:58:27 +0200
Message-Id: <20180427135711.467958579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908366989271942?=
X-GMAIL-MSGID: =?utf-8?q?1598908366989271942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit f315104ad8b0c32be13eac628569ae707c332cb5 ]

If the guest runs with bp isolation when doing a SIE instruction,
we must also run the nested guest with bp isolation when emulating
that SIE instruction.
This is done by activating BPBC in the lpar, which acts as an override
for lower level guests.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/vsie.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -764,6 +764,7 @@ static int do_vsie_run(struct kvm_vcpu *
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	int guest_bp_isolation;
 	int rc;
 
 	handle_last_fault(vcpu, vsie_page);
@@ -774,6 +775,20 @@ static int do_vsie_run(struct kvm_vcpu *
 		s390_handle_mcck();
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
+
+	/* save current guest state of bp isolation override */
+	guest_bp_isolation = test_thread_flag(TIF_ISOLATE_BP_GUEST);
+
+	/*
+	 * The guest is running with BPBC, so we have to force it on for our
+	 * nested guest. This is done by enabling BPBC globally, so the BPBC
+	 * control in the SCB (which the nested guest can modify) is simply
+	 * ignored.
+	 */
+	if (test_kvm_facility(vcpu->kvm, 82) &&
+	    vcpu->arch.sie_block->fpf & FPF_BPBC)
+		set_thread_flag(TIF_ISOLATE_BP_GUEST);
+
 	local_irq_disable();
 	guest_enter_irqoff();
 	local_irq_enable();
@@ -783,6 +798,11 @@ static int do_vsie_run(struct kvm_vcpu *
 	local_irq_disable();
 	guest_exit_irqoff();
 	local_irq_enable();
+
+	/* restore guest state for bp isolation override */
+	if (!guest_bp_isolation)
+		clear_thread_flag(TIF_ISOLATE_BP_GUEST);
+
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	if (rc > 0)

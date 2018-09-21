Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BFECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFAF20645
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFAF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbeIVFKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:10:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725756AbeIVFKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:10:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LNMvtC105225
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:23:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn89gkrkb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:23:28 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 21 Sep 2018 19:19:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 19:19:00 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LNIwfS27132068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 23:18:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3217112061;
        Fri, 21 Sep 2018 19:18:25 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C203B112064;
        Fri, 21 Sep 2018 19:18:24 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 19:18:24 -0400 (EDT)
Subject: Re: [PATCH v10 03/26] KVM: s390: refactor crypto initialization
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 21 Sep 2018 19:18:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092123-0040-0000-0000-000004741CD3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009748; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091739; UDB=6.00564117; IPR=6.00871764;
 MB=3.00023443; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 23:19:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092123-0041-0000-0000-0000087C1E45
Message-Id: <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 03:42 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> This patch refactors the code that initializes and sets up the
> crypto configuration for a guest. The following changes are
> implemented via this patch:
> 
> 1. Prior to the introduction of AP device virtualization, it
>     was not necessary to provide guest access to the CRYCB
>     unless the MSA extension 3 (MSAX3) facility was installed
>     on the host system. With the introduction of AP device
>     virtualization, the CRYCB must be made accessible to the
>     guest if the AP instructions are installed on the host
>     and are to be provided to the guest.
> 
> 2. Introduces a flag indicating AP instructions executed on
>     the guest shall be interpreted by the firmware. It is
>     initialized to indicate AP instructions are to be
>     to be interpreted and is used to set the SIE bit for
>     each vcpu during vcpu setup.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |    2 +
>   arch/s390/include/uapi/asm/kvm.h |    1 +
>   arch/s390/kvm/kvm-s390.c         |   71 ++++++++++++++++++--------------------
>   3 files changed, 37 insertions(+), 37 deletions(-)
> 

(...)

> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 9a50f02..8c23afc 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>   #define KVM_S390_VM_CPU_FEAT_KSS	13
> +#define KVM_S390_VM_CPU_FEAT_AP		14
>   struct kvm_s390_vm_cpu_feat {
>   	__u64 feat[16];
>   };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 876fbb2..d717041 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -40,6 +40,7 @@
>   #include <asm/sclp.h>
>   #include <asm/cpacf.h>
>   #include <asm/timex.h>
> +#include <asm/ap.h>
>   #include "kvm-s390.h"
>   #include "gaccess.h"
>   

(...)

> @@ -2586,17 +2575,25 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   
>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>   {
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> +	/*
> +	 * If neither the AP instructions nor the MSAX3 facility are configured
> +	 * for the guest, there is nothing to set up.
> +	 */
> +	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
> +	    !test_kvm_facility(vcpu->kvm, 76))
>   		return;
>   
> +	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>   	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>   
> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +		vcpu->arch.sie_block->eca |= ECA_APIE;
> +
> +	/* Set up protected key support */
>   	if (vcpu->kvm->arch.crypto.aes_kw)
>   		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>   	if (vcpu->kvm->arch.crypto.dea_kw)
>   		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
> -
> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>   }
>   
>   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
> 

The fixup! patch below modifies this patch (03/26) to illustrate how

David's recommendation will be implemented for v11 of the series. It

is one of three fixup! patches (the other two are in responses to
11/26
  and 25/26) included to generate discussion in v10 rather than

waiting until v11 for comments.

-----------------------------------8<-----------------------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 20 Sep 2018 12:26:08 -0400
Subject: [FIXUP v10] fixup!: KVM: s390: refactor crypto initialization

---
  arch/s390/include/asm/kvm_host.h |    1 +
  arch/s390/include/uapi/asm/kvm.h |    1 -
  arch/s390/kvm/kvm-s390.c         |    9 ++++-----
  3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h 
b/arch/s390/include/asm/kvm_host.h
index 423cce7..79fa0a3 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -718,6 +718,7 @@ struct kvm_s390_crypto {
  	__u32 crycbd;
  	__u8 aes_kw;
  	__u8 dea_kw;
+	__u8 apie;
  };

  #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/include/uapi/asm/kvm.h 
b/arch/s390/include/uapi/asm/kvm.h
index 8c23afc..9a50f02 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -130,7 +130,6 @@ struct kvm_s390_vm_cpu_machine {
  #define KVM_S390_VM_CPU_FEAT_PFMFI	11
  #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
  #define KVM_S390_VM_CPU_FEAT_KSS	13
-#define KVM_S390_VM_CPU_FEAT_AP		14
  struct kvm_s390_vm_cpu_feat {
  	__u64 feat[16];
  };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d717041..ae4769b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2576,17 +2576,16 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
  {
  	/*
-	 * If neither the AP instructions nor the MSAX3 facility are configured
-	 * for the guest, there is nothing to set up.
+	 * If the AP instructions are not available and the MSAX3 facility
+	 * is not configured for the guest, there is nothing to set up.
  	 */
-	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
-	    !test_kvm_facility(vcpu->kvm, 76))
+	if (!ap_instructions_available() && !test_kvm_facility(vcpu->kvm, 76))
  		return;

  	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
  	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);

-	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
+	if (vcpu->kvm->arch.crypto.apie)
  		vcpu->arch.sie_block->eca |= ECA_APIE;

  	/* Set up protected key support */
-- 
1.7.1


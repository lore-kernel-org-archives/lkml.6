Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B6C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA120C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA120C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeHTT5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:57:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbeHTT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EC5E40216F0;
        Mon, 20 Aug 2018 16:41:25 +0000 (UTC)
Received: from [10.36.117.169] (ovpn-117-169.ams2.redhat.com [10.36.117.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF09110B7C96;
        Mon, 20 Aug 2018 16:41:19 +0000 (UTC)
Subject: Re: [PATCH v9 07/22] KVM: s390: refactor crypto initialization
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-8-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <1ba9032d-963a-6ce1-0d10-11bebbaa315f@redhat.com>
Date:   Mon, 20 Aug 2018 18:41:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534196899-16987-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 20 Aug 2018 16:41:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 20 Aug 2018 16:41:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 23:48, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> This patch refactors the code that initializes and sets up the
> crypto configuration for a guest. The following changes are
> implemented via this patch:
> 
> 1. Prior to the introduction of AP device virtualization, it
>    was not necessary to provide guest access to the CRYCB
>    unless the MSA extension 3 (MSAX3) facility was installed
>    on the host system. With the introduction of AP device
>    virtualization, the CRYCB must be made accessible to the
>    guest if the AP instructions are installed on the host
>    and are to be provided to the guest.
> 
> 2. Introduces a flag indicating AP instructions executed on
>    the guest shall be interpreted by the firmware. It is
>    initialized to indicate AP instructions are to be
>    to be interpreted and is used to set the SIE bit for
>    each vcpu during vcpu setup.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |    2 +
>  arch/s390/include/uapi/asm/kvm.h |    1 +
>  arch/s390/kvm/kvm-s390.c         |   81 +++++++++++++++++++-------------------
>  3 files changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index af39561..4a739d4 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
>  #define ECA_AIV		0x00200000
>  #define ECA_VX		0x00020000
>  #define ECA_PROTEXCI	0x00002000
> +#define ECA_APIE	0x00000008
>  #define ECA_SII		0x00000001
>  	__u32	eca;			/* 0x004c */
>  #define ICPT_INST	0x04
> @@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
>  	__u8	reservede4[4];		/* 0x00e4 */
>  	__u64	tecmc;			/* 0x00e8 */
>  	__u8	reservedf0[12];		/* 0x00f0 */
> +#define CRYCB_FORMAT_MASK 0x00000003
>  #define CRYCB_FORMAT1 0x00000001
>  #define CRYCB_FORMAT2 0x00000003
>  	__u32	crycbd;			/* 0x00fc */
> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> index 4cdaa55..a580dec 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>  #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>  #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>  #define KVM_S390_VM_CPU_FEAT_KSS	13
> +#define KVM_S390_VM_CPU_FEAT_AP		14
>  struct kvm_s390_vm_cpu_feat {
>  	__u64 feat[16];
>  };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 19f4f44..f7de123 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -40,6 +40,7 @@
>  #include <asm/sclp.h>
>  #include <asm/cpacf.h>
>  #include <asm/timex.h>
> +#include <asm/ap.h>
>  #include "kvm-s390.h"
>  #include "gaccess.h"
>  
> @@ -1881,49 +1882,37 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	return r;
>  }
>  
> -static int kvm_s390_query_ap_config(u8 *config)
> -{
> -	u32 fcn_code = 0x04000000UL;
> -	u32 cc = 0;
> -
> -	memset(config, 0, 128);
> -	asm volatile(
> -		"lgr 0,%1\n"
> -		"lgr 2,%2\n"
> -		".long 0xb2af0000\n"		/* PQAP(QCI) */
> -		"0: ipm %0\n"
> -		"srl %0,28\n"
> -		"1:\n"
> -		EX_TABLE(0b, 1b)
> -		: "+r" (cc)
> -		: "r" (fcn_code), "r" (config)
> -		: "cc", "0", "2", "memory"
> -	);
> -
> -	return cc;
> -}
> -
>  static int kvm_s390_apxa_installed(void)
>  {
> -	u8 config[128];
> -	int cc;
> +	struct ap_config_info info;
>  
> -	if (test_facility(12)) {
> -		cc = kvm_s390_query_ap_config(config);
> -
> -		if (cc)
> -			pr_err("PQAP(QCI) failed with cc=%d", cc);
> -		else
> -			return config[0] & 0x40;
> +	if (ap_instructions_available()) {
> +		if (ap_qci(&info) == 0)
> +			return info.apxa;
>  	}
>  
>  	return 0;
>  }
>  
> +/*
> + * The format of the crypto control block (CRYCB) is specified in the 3 low
> + * order bits of the CRYCB designation (CRYCBD) field as follows:
> + * Format 0: Neither the message security assist extension 3 (MSAX3) nor the
> + *	     AP extended addressing (APXA) facility are installed.
> + * Format 1: The APXA facility is not installed but the MSAX3 facility is.
> + * Format 2: Both the APXA and MSAX3 facilities are installed
> + */
>  static void kvm_s390_set_crycb_format(struct kvm *kvm)
>  {
>  	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
>  
> +	/* Clear the CRYCB format bits - i.e., set format 0 by default */
> +	kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT_MASK);
> +
> +	/* Check whether MSAX3 is installed */
> +	if (!test_kvm_facility(kvm, 76))
> +		return;
> +
>  	if (kvm_s390_apxa_installed())
>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
>  	else
> @@ -1941,12 +1930,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
>  
>  static void kvm_s390_crypto_init(struct kvm *kvm)
>  {
> -	if (!test_kvm_facility(kvm, 76))
> -		return;
> -
>  	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
>  	kvm_s390_set_crycb_format(kvm);
>  
> +	if (!test_kvm_facility(kvm, 76))
> +		return;
> +
>  	/* Enable AES/DEA protected key functions by default */
>  	kvm->arch.crypto.aes_kw = 1;
>  	kvm->arch.crypto.dea_kw = 1;
> @@ -2474,17 +2463,29 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  
>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>  {
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> +	/*
> +	 * If neither the AP instructions nor the MSAX3 facility are installed
> +	 * on the host, then there is no need for a CRYCB in SIE because they
> +	 * will not be installed on the guest either.
> +	 */
> +	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
> +	    !test_facility(76))

I think this can just stay "test_kvm_facility(vcpu->kvm, 76)", and the
comment should be changed to

"If neither the AP instructions nor the MSAX3 facility are configured
for the guest, there is nothing to set up."

Or am I missing something important here?

After the CPU has been created, both feature can no longer change. The
only thing that might change is kvm->arch.crypto.aes_kw/dea_kw but only
with test_kvm_facility(vcpu->kvm, 76).

>  		return;
>  
> +	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>  	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>  
> -	if (vcpu->kvm->arch.crypto.aes_kw)
> -		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
> -	if (vcpu->kvm->arch.crypto.dea_kw)
> -		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
> +	vcpu->arch.sie_block->eca &= ~ECA_APIE;

As this feature can never flip, clearing the flag is not necessary.

> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>  
> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
> +	/* If MSAX3 is installed on the guest, set up protected key support */
> +	if (test_kvm_facility(vcpu->kvm, 76)) {
> +		if (vcpu->kvm->arch.crypto.aes_kw)
> +			vcpu->arch.sie_block->ecb3 |= ECB3_AES;
> +		if (vcpu->kvm->arch.crypto.dea_kw)
> +			vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
> +	}

As the feature can never change, and aes_kw/dea_kw are only set to 1 in
case we have test_kvm_facility(vcpu->kvm, 76), this change is not needed.

I think this function can be pretty much left alone. Just add the
KVM_S390_VM_CPU_FEAT_AP handling.

>  }
>  
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
> 


-- 

Thanks,

David / dhildenb

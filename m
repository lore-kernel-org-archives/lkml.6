Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82503C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F858218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yqlvzxw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAWR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:57:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:57:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHsZq8112222;
        Wed, 23 Jan 2019 17:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZvXK89nm9DMNFWrlFdbQdEe8HSDPOa2vv3Rd7TZ7TNI=;
 b=yqlvzxw6LbzugxsufQQCmisZcZnv0gJ9Hu2cUVV7SH9vW6+V78o1JR8p04ufqkXSMquB
 TuFOmrjWdhLA/12eRMyfkaER5pGUZoq6ZO9cjs24ZLX3JERSdZLcOtIpCVeJgtP19DOi
 Tdvtm6xcbIyASyifkDNdiVtivPof21/SJmuLs2B7+wTOZiXtV55ObkggnFGy+ikoFJyv
 VGYH2TEKZs6t0IdTfT53P0dqh+uhfE6tbwEOivoku7YviewfefWBp5gqISKgz9ZMVb4f
 2ocUu51+OtQI1qVJzlyMupmKVM/cETHPFrm8SK7e+uhK+bkWymfSftFzz+6OSyaF2RNi 3A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q3uauugb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:57:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHvmM7003215
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:57:49 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHvmOd013340;
        Wed, 23 Jan 2019 17:57:48 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:57:48 -0800
Date:   Wed, 23 Jan 2019 12:57:33 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 07/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 virtual APIC page
Message-ID: <20190123175711.GL19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-8-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-8-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:07AM +0100, KarimAllah Ahmed wrote:
> Use kvm_vcpu_map when mapping the virtual APIC page since using
> kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
> a "struct page".
> 
> One additional semantic change is that the virtual host mapping lifecycle
> has changed a bit. It now has the same lifetime of the pinning of the
> virtual APIC page on the host side.

Could you expand a bit on the 'same lifetime .. on the host side'  to be
obvious for folks what exactly the semantic is?

And how does this ring with this comment:
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
> v4 -> v5:
> - unmap with dirty flag
> 
> v1 -> v2:
> - Do not change the lifecycle of the mapping (pbonzini)

.. Where Paolo does not want the semantics of the mapping to be changed?

Code wise feel free to smack my Reviewed-by on it, but obviously the
question on the above comment needs to be resolved.

Thank you.

> - Use pfn_to_hpa instead of gfn_to_gpa
> ---
>  arch/x86/kvm/vmx/nested.c | 32 +++++++++++---------------------
>  arch/x86/kvm/vmx/vmx.c    |  5 ++---
>  arch/x86/kvm/vmx/vmx.h    |  2 +-
>  3 files changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 4127ad9..dcff99d 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -229,10 +229,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
>  		kvm_release_page_dirty(vmx->nested.apic_access_page);
>  		vmx->nested.apic_access_page = NULL;
>  	}
> -	if (vmx->nested.virtual_apic_page) {
> -		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
> -		vmx->nested.virtual_apic_page = NULL;
> -	}
> +	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
>  	if (vmx->nested.pi_desc_page) {
>  		kunmap(vmx->nested.pi_desc_page);
>  		kvm_release_page_dirty(vmx->nested.pi_desc_page);
> @@ -2817,6 +2814,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  {
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	struct kvm_host_map *map;
>  	struct page *page;
>  	u64 hpa;
>  
> @@ -2849,11 +2847,7 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  	}
>  
>  	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
> -		if (vmx->nested.virtual_apic_page) { /* shouldn't happen */
> -			kvm_release_page_dirty(vmx->nested.virtual_apic_page);
> -			vmx->nested.virtual_apic_page = NULL;
> -		}
> -		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->virtual_apic_page_addr);
> +		map = &vmx->nested.virtual_apic_map;
>  
>  		/*
>  		 * If translation failed, VM entry will fail because
> @@ -2868,11 +2862,9 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  		 * control.  But such a configuration is useless, so
>  		 * let's keep the code simple.
>  		 */
> -		if (!is_error_page(page)) {
> -			vmx->nested.virtual_apic_page = page;
> -			hpa = page_to_phys(vmx->nested.virtual_apic_page);
> -			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
> -		}
> +		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map))
> +			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
> +
>  	}
>  
>  	if (nested_cpu_has_posted_intr(vmcs12)) {
> @@ -3279,11 +3271,12 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
>  
>  	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
>  	if (max_irr != 256) {
> -		vapic_page = kmap(vmx->nested.virtual_apic_page);
> +		vapic_page = vmx->nested.virtual_apic_map.hva;
> +		if (!vapic_page)
> +			return;
> +
>  		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
>  			vapic_page, &max_irr);
> -		kunmap(vmx->nested.virtual_apic_page);
> -
>  		status = vmcs_read16(GUEST_INTR_STATUS);
>  		if ((u8)max_irr > ((u8)status & 0xff)) {
>  			status &= ~0xff;
> @@ -3917,10 +3910,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  		kvm_release_page_dirty(vmx->nested.apic_access_page);
>  		vmx->nested.apic_access_page = NULL;
>  	}
> -	if (vmx->nested.virtual_apic_page) {
> -		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
> -		vmx->nested.virtual_apic_page = NULL;
> -	}
> +	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map, true);
>  	if (vmx->nested.pi_desc_page) {
>  		kunmap(vmx->nested.pi_desc_page);
>  		kvm_release_page_dirty(vmx->nested.pi_desc_page);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 71d88df..e13308e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3627,14 +3627,13 @@ static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
>  
>  	if (WARN_ON_ONCE(!is_guest_mode(vcpu)) ||
>  		!nested_cpu_has_vid(get_vmcs12(vcpu)) ||
> -		WARN_ON_ONCE(!vmx->nested.virtual_apic_page))
> +		WARN_ON_ONCE(!vmx->nested.virtual_apic_map.gfn))
>  		return false;
>  
>  	rvi = vmx_get_rvi();
>  
> -	vapic_page = kmap(vmx->nested.virtual_apic_page);
> +	vapic_page = vmx->nested.virtual_apic_map.hva;
>  	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
> -	kunmap(vmx->nested.virtual_apic_page);
>  
>  	return ((rvi & 0xf0) > (vppr & 0xf0));
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 6fb69d8..f618f52 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -142,7 +142,7 @@ struct nested_vmx {
>  	 * pointers, so we must keep them pinned while L2 runs.
>  	 */
>  	struct page *apic_access_page;
> -	struct page *virtual_apic_page;
> +	struct kvm_host_map virtual_apic_map;
>  	struct page *pi_desc_page;
>  
>  	struct kvm_host_map msr_bitmap_map;
> -- 
> 2.7.4
> 

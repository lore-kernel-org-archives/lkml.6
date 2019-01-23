Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3721855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="svkM/mB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfAWRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:45:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:45:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHiFpr103740;
        Wed, 23 Jan 2019 17:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SwLh9jUkuRceSleHqx133UfY6I2ewVgornbggMEcOoo=;
 b=svkM/mB0IQMi9qY16VCAyBjPQRPSLj4kKWwk0+jYTJc09YE8Y9xlRD6Ayu/TZrKYm0Va
 hMz3e/0Lp7aTqYFRv845v5k11dSMzgRrOy5zxFD4J/zEVt6nUqpPNUx5V7dZZmdZB0B1
 4dJgnlBNxAxD2NMphTLhCX7MtJQKqO3aDzlPeH8mmzkka6hgGTUqEGivzX6dnFNPilNb
 SSc9hhJj02CUu59KBCOsh8lJHzqhyNJWjLy+cGSCNkaEVk1MNuUxZog9tVodn0anGLe3
 MIucVOKUpyzkNil+w9Io0UYF+gHV40ubLaSSJlSuKlzNWtPZ+XcCO+U+eQG0b98EQ/pG iA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uauue5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:45:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHj3ld001523
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:45:03 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NHj3Jb020889;
        Wed, 23 Jan 2019 17:45:03 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:45:02 -0800
Date:   Wed, 23 Jan 2019 12:44:41 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 05/13] X86/nVMX: handle_vmptrld: Use kvm_vcpu_map when
 copying VMCS12 from guest memory
Message-ID: <20190123174438.GJ19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-6-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-6-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:05AM +0100, KarimAllah Ahmed wrote:
> Use kvm_vcpu_map to the map the VMCS12 from guest memory because
> kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
> a "struct page".
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
> v4 -> v5:
> - Switch to the new guest mapping API instead of reading directly from
>   guest.
> - unmap with dirty flag
> v3 -> v4:
> - Return VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID on failure (jmattson@)
> v1 -> v2:
> - Massage commit message a bit.
> ---
>  arch/x86/kvm/vmx/nested.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 536468a..5602b0c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4521,11 +4521,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  		return 1;
>  
>  	if (vmx->nested.current_vmptr != vmptr) {
> +		struct kvm_host_map map;
>  		struct vmcs12 *new_vmcs12;
> -		struct page *page;
>  
> -		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
> -		if (is_error_page(page)) {
> +		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmptr), &map)) {
>  			/*
>  			 * Reads from an unbacked page return all 1s,
>  			 * which means that the 32 bits located at the
> @@ -4536,12 +4535,13 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
>  			return kvm_skip_emulated_instruction(vcpu);
>  		}
> -		new_vmcs12 = kmap(page);
> +
> +		new_vmcs12 = map.hva;
> +
>  		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
>  		    (new_vmcs12->hdr.shadow_vmcs &&
>  		     !nested_cpu_has_vmx_shadow_vmcs(vcpu))) {
> -			kunmap(page);
> -			kvm_release_page_clean(page);
> +			kvm_vcpu_unmap(&map, false);
>  			return nested_vmx_failValid(vcpu,
>  				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
>  		}
> @@ -4553,8 +4553,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  		 * cached.
>  		 */
>  		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
> -		kunmap(page);
> -		kvm_release_page_clean(page);
> +		kvm_vcpu_unmap(&map, false);
>  
>  		set_current_vmptr(vmx, vmptr);
>  	}
> -- 
> 2.7.4
> 

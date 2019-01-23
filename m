Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDEC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15D121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTcCmUPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAWRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:18:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAWRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:18:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHEgVE022802;
        Wed, 23 Jan 2019 17:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BYlqG3bym7VGNeB5A/g5IXhdKxNY1y+E06xHBj5zteA=;
 b=DTcCmUPUikRM12hY9LFuRmxeVEwTZjU1oYCScL3WuIMuGuhWdsW2ockSLv4sm0j6kjEQ
 sHX5XuoNBhillu4v0ZvnpIgzPLtt58ocBFrAdiD4V5HCfbzKCLIB1fC8PP3OourtBM8c
 ffGRlgyO7WShVT7xJAk9M2uLgP4X4nTpww8HAFQJtkn7e/6HuR5Bdcwag0Y//OpqQnf/
 mPOqKpzoJo5KaFOucM5UNdg9OefhyeOa4w32OZuCjVxAZCMVhKOw6Ikh/9RTvEXbvLvL
 QsjW1HAAlII0rdDb4i0U/goNbBRVSUgVrZ4z5bL+8vcw27rAlFFEI/WVjEzT4A7zkwyY YQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q3sdekdva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:18:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHI2bM027152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:18:03 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHI18r016619;
        Wed, 23 Jan 2019 17:18:01 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:18:00 -0800
Date:   Wed, 23 Jan 2019 12:17:44 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 02/13] X86/nVMX: Update the PML table without mapping
 and unmapping the page
Message-ID: <20190123171730.GG19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-3-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-3-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:02AM +0100, KarimAllah Ahmed wrote:
> Update the PML table without mapping and unmapping the page. This also
> avoids using kvm_vcpu_gpa_to_page(..) which assumes that there is a "struct
> page" for guest memory.
> 
> As a side-effect of using kvm_write_guest_page the page is also properly
> marked as dirty.
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
> v1 -> v2:
> - Use kvm_write_guest_page instead of kvm_write_guest (pbonzini)
> - Do not use pointer arithmetic for pml_address (pbonzini)
> ---
>  arch/x86/kvm/vmx/vmx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4d39f73..71d88df 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7199,9 +7199,7 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
>  {
>  	struct vmcs12 *vmcs12;
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	gpa_t gpa;
> -	struct page *page = NULL;
> -	u64 *pml_address;
> +	gpa_t gpa, dst;
>  
>  	if (is_guest_mode(vcpu)) {
>  		WARN_ON_ONCE(vmx->nested.pml_full);
> @@ -7221,15 +7219,13 @@ static int vmx_write_pml_buffer(struct kvm_vcpu *vcpu)
>  		}
>  
>  		gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS) & ~0xFFFull;
> +		dst = vmcs12->pml_address + sizeof(u64) * vmcs12->guest_pml_index;
>  
> -		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->pml_address);
> -		if (is_error_page(page))
> +		if (kvm_write_guest_page(vcpu->kvm, gpa_to_gfn(dst), &gpa,
> +					 offset_in_page(dst), sizeof(gpa)))
>  			return 0;
>  
> -		pml_address = kmap(page);
> -		pml_address[vmcs12->guest_pml_index--] = gpa;
> -		kunmap(page);
> -		kvm_release_page_clean(page);
> +		vmcs12->guest_pml_index--;
>  	}
>  
>  	return 0;
> -- 
> 2.7.4
> 

Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F317C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14472184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3Mvx4DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAWRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:00:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54456 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAWRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:00:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NGxGjX009140;
        Wed, 23 Jan 2019 17:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=X/uCg52rQL0X37oiYpP9CWxwi/dxjQRWHrF1dQtkiuA=;
 b=m3Mvx4DXCEzPkctG86kSTMiukCisQxEVuw4HPq1xMIvjQC55PTP/6/YLN5B/5X7a/1a5
 jYLs2nqmxAedk7MTpdK1NzhwLHPkZRqEMwdi/IcCXfmoGEO9+Rje5MaKFnPdsDppeyOS
 yvOleAvb3YVvFPmw4+7FWN/7xAxMULvivkjvoGMu2rV5YF9JhKXiZbfUBrxWCi5KDLIY
 ZhAA8c3DzrYbwUMoL81lj9G72j6SAFoxUAGeMG+d1IX5sNp+TnzyhAED8QlCN+1wEvHc
 Tchwxptl42thWNZgpFeEqbmXbFnQ3TXQhFpbSFRJWdyPjR98JeTklQ1x/XsL+XcYHyOC RA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q3sdekaea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:00:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NH00ig023145
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:00:00 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NGxxwx024081;
        Wed, 23 Jan 2019 16:59:59 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 08:59:59 -0800
Date:   Wed, 23 Jan 2019 11:59:45 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 01/13] X86/nVMX: handle_vmon: Read 4 bytes from guest
 memory
Message-ID: <20190123165932.GF19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-2-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-2-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:01AM +0100, KarimAllah Ahmed wrote:
> Read the data directly from guest memory instead of the map->read->unmap
> sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
> assumes that there is a "struct page" for guest memory.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Mind if I join party?

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

> 
> ---
> v1 -> v2:
> - Massage commit message a bit.
> ---
>  arch/x86/kvm/vmx/nested.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3170e29..536468a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4192,7 +4192,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>  {
>  	int ret;
>  	gpa_t vmptr;
> -	struct page *page;
> +	uint32_t revision;
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
>  		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
> @@ -4241,18 +4241,10 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>  	if (!PAGE_ALIGNED(vmptr) || (vmptr >> cpuid_maxphyaddr(vcpu)))
>  		return nested_vmx_failInvalid(vcpu);
>  
> -	page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
> -	if (is_error_page(page))
> +	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
> +	    revision != VMCS12_REVISION)
>  		return nested_vmx_failInvalid(vcpu);
>  
> -	if (*(u32 *)kmap(page) != VMCS12_REVISION) {
> -		kunmap(page);
> -		kvm_release_page_clean(page);
> -		return nested_vmx_failInvalid(vcpu);
> -	}
> -	kunmap(page);
> -	kvm_release_page_clean(page);
> -
>  	vmx->nested.vmxon_ptr = vmptr;
>  	ret = enter_vmx_operation(vcpu);
>  	if (ret)
> -- 
> 2.7.4
> 

Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80BEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AFE20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NpIIBjbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AFE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeLEWCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:02:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38130 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:02:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB5LxTH4065707;
        Wed, 5 Dec 2018 22:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dnK95Ha9vuSbCq4ScqwJPrv/LSu/YMCHUJZyCbC50To=;
 b=NpIIBjbCaT/I4b0IHBjHcb7y2Vkl4Gemj2vvU+9EZDvQB7EQ8CVCfNooM+c6VyKMby0+
 xdwLlw6PX3H2+rlgT5nJzqduCOXhe6eKNNTvTzwi3RejCil3+xHR6eoreETKTL2vNPu8
 95IPrHYMKXY3L+JnqswBdvqHkwldyt7CyXGwUshTHr0wnMWz5jPh7bGaOXwtrU2JS/jA
 nlrsl/gCxoov50z53L2s0bm1H1aPEV65Xh/9gHiJG3KDRrH2lGGb0EDtebMu11Ve5o0q
 F0zpxyKklM5nQshJYWgGFKcVpDnVubHZamMo8vTJymgzqsywD3GXe46fyqeXjfBjLGzz Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftf91p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 22:02:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB5M29gE014114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 22:02:09 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB5M28jp026624;
        Wed, 5 Dec 2018 22:02:08 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 14:02:07 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B2EE96A00FC; Wed,  5 Dec 2018 17:02:06 -0500 (EST)
Date:   Wed, 5 Dec 2018 17:02:06 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] kvm: x86: Report STIBP on GET_SUPPORTED_CPUID
Message-ID: <20181205220206.GA16013@char.us.oracle.com>
References: <20181205191956.31480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205191956.31480-1-ehabkost@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:19:56PM -0200, Eduardo Habkost wrote:
> Months ago, we have added code to allow direct access to MSR_IA32_SPEC_CTRL
> to the guest, which makes STIBP available to guests.  This was implemented
> by commits d28b387fb74d ("KVM/VMX: Allow direct access to
> MSR_IA32_SPEC_CTRL") and b2ac58f90540 ("KVM/SVM: Allow direct access to
> MSR_IA32_SPEC_CTRL").
> 
> However, we never updated GET_SUPPORTED_CPUID to let userspace know that
> STIBP can be enabled in CPUID.  Fix that by updating

Ooops!
> kvm_cpuid_8000_0008_ebx_x86_features and kvm_cpuid_7_0_edx_x86_features.

Shouldn't there also be a patch in QEMU to use it? (aka, +stibp).

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7bcfa61375c0..cc6dd65828a4 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -381,7 +381,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	/* cpuid 0x80000008.ebx */
>  	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
>  		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> -		F(AMD_SSB_NO);
> +		F(AMD_SSB_NO) | F(AMD_STIBP);
>  
>  	/* cpuid 0xC0000001.edx */
>  	const u32 kvm_cpuid_C000_0001_edx_x86_features =
> @@ -411,7 +411,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> -		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP);
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 

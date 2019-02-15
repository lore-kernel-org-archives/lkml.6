Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0647821B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ws19ZnyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfBOQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:47:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbfBOQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:47:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FGhjdt057358;
        Fri, 15 Feb 2019 16:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2KALMt0tE8OK3y1UnaOWuXxCv9ugVnJdfochFiQHh2s=;
 b=Ws19ZnyRgrywZL3snKB1G+qVKIYwszwUcg5xfreJusL1N6oRuxgI6nmW54KWiZFuBAXO
 L9YHv82DLeenDljN843qiecAX0dM5DkGM6iTEJUmdvROg+UseArLLaUT59eZdypS8a8L
 9bJ9oxu3hZxTkIfVNyVcwg2SrbdAa1IHQ16Yq5QPVMuAo+p+wBOvdIqezBGnV0hK8Tx/
 0A4QEtKeBhGN1iEnP8kWcoyn3S2XUm9uYETZjK2WqRAUdYafkTPR0oAyaS1CLs3blcze
 IXmQTJ/EchEo1aN0uk0dMbr0vnYsQ2yLcg6ZepXUP2YWYAMpnoFVN4qJZ1Y2hxgwV2+3 DQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrekxw82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 16:46:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1FGkmf9024583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 16:46:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1FGklo5008973;
        Fri, 15 Feb 2019 16:46:47 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 16:46:46 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 583E76A0123; Fri, 15 Feb 2019 11:46:45 -0500 (EST)
Date:   Fri, 15 Feb 2019 11:46:45 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] kvm: vmx: Fix entry nubmer check for
 add_atomic_switch_msr()
Message-ID: <20190215164645.GD889@char.us.oracle.com>
References: <20190214040858.15975-1-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214040858.15975-1-xiaoyao.li@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:08:58PM +0800, Xiaoyao Li wrote:
> Commit ca83b4a7f2d068da79a0 ("x86/KVM/VMX: Add find_msr() helper function")
> introduces the helper function find_msr(), which returns -ENOENT when
> not find the msr in vmx->msr_autoload.guest/host. Correct checking contion

s/not find/cannot find/
s/contion/condition/ ?

> of no more available entry in vmx->msr_autoload.
> 
> Fixes: ca83b4a7f2d0 ("x86/KVM/VMX: Add find_msr() helper function")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 95d618045001..1aaef2d536bd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -863,7 +863,8 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
>  	if (!entry_only)
>  		j = find_msr(&m->host, msr);
>  
> -	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
> +	if ((i < 0 && m->guest.nr == NR_AUTOLOAD_MSRS) ||
> +		(j < 0 &&  m->host.nr == NR_AUTOLOAD_MSRS)) {
>  		printk_once(KERN_WARNING "Not enough msr switch entries. "
>  				"Can't add msr %x\n", msr);
>  		return;
> -- 
> 2.19.1
> 

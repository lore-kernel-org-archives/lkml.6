Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEE218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XOn/GUa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfAYQeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:34:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfAYQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:34:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PGTHV7067701;
        Fri, 25 Jan 2019 16:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Fv+v1Me7wX02BNYeSJtqLCQpia0cVcnlWRUbIzikwAs=;
 b=XOn/GUa5tdjpAXRycwWRoGBEjVSsUrkQEFUK5Jk9o6a0oEsQ/Iw71WeS34UHRim/ZdMZ
 HYEIP/wVTq3xbNDlm5quaxab8p1m/1AUqQ4SLrIUz1XrlSm4Np01Yv+0L98VKuDM8QUX
 J//mzS43t4dI+v24lII+81sj7+to/p6DogkDwBOur62v5QO5hw8Qxr0ndal3v5d1mZrW
 Uz1yPV+I+S8ChfD5RvDSrZPJGKk/iMpkPsIXemHZDobqXiI3XShHBXWFO+MCgW2NgPX3
 0I8a4tMjbVRLgG4AjvEk3qCS6eKqWzihYNBAKK8oczVGFivVClQFqm7JNRiFe2cTMrKr BA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhs6na7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 16:33:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0PGXiPk026817
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 16:33:44 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0PGXg8p003171;
        Fri, 25 Jan 2019 16:33:43 GMT
Received: from Konrads-MacBook-Pro.local (/10.39.251.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 08:33:42 -0800
Date:   Fri, 25 Jan 2019 11:33:36 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Luwei Kang <luwei.kang@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Message-ID: <20190125163329.GA41385@Konrads-MacBook-Pro.local>
References: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9147 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:34:00PM +0800, Luwei Kang wrote:
> Some Posted-Interrupts from passthrough devices may be lost or
> overwritten when the vCPU is in runnable state.
> 
> The SN (Suppress Notification) of PID (Posted Interrupt Descriptor) will
> be set when the vCPU is preempted (vCPU in KVM_MP_STATE_RUNNABLE state
> but not running on physical CPU). If a posted interrupt coming at this
> time, the irq remmaping facility will set the bit of PIR (Posted
> Interrupt Requests) but ON (Outstanding Notification).

s/but ON/and ON is set too/?
> So this interrupt can't be sync to APIC virtualization register and
> will not be handled by Guest because ON is zero.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6915f1..820a03b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6048,7 +6048,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
>  	bool max_irr_updated;
>  
>  	WARN_ON(!vcpu->arch.apicv_active);
> -	if (pi_test_on(&vmx->pi_desc)) {
> +	if (!bitmap_empty((unsigned long *)vmx->pi_desc.pir, NR_VECTORS)) {
>  		pi_clear_on(&vmx->pi_desc);
>  		/*
>  		 * IOMMU can write to PIR.ON, so the barrier matters even on UP.

Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0420A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OubtZ1GL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A0420A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeHYAOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:14:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeHYAOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:14:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7OKTojl104857;
        Fri, 24 Aug 2018 20:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JtA9wN2aPf++6DfKg0YHm4GURF3ZsElt/HbvdhDXpAA=;
 b=OubtZ1GLzupQwQKddBPHUvVeYl+CXYzA50EMR8Mq+U1ly3NyJNtocKxOHCLcA28ZWKtV
 PdV1Tpd9h4gzPDvyjD6WTGCM/DgayXtXVTqw5WToro8jBTSEziEEhZlTXtV/AAJvkfzF
 VXggbOg6eUgQbeo5ZNeXH5FgtQvyUbgABvefi+X7pW+yLL3ofEk2WQgmnEPVayypc3Xv
 7P4SO0eB35E2RC8t9ALiY4fARYc0SMZcTTzmGHdo4lUQcHn8GNCKuBVA5/Rk3/yr13gY
 IBT9+rL3ciZBb/LeFzowzA/3ovL+gZ/NG2p9Jz2eT5q9wieO5p+/j9+fbeCvCqWfuF1V fA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3ra36f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 20:37:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7OKbiTm003715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 20:37:44 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7OKbhcI005186;
        Fri, 24 Aug 2018 20:37:43 GMT
Received: from dhcp-10-132-91-181.usdhcp.oraclecorp.com (/10.132.91.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 13:37:43 -0700
Subject: Re: [PATCH] x86/kvm/nVMX: avoid redundant double assignment of
 nested_run_pending
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
References: <20180823162424.13282-1-vkuznets@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <97047d0e-cfbb-8c23-a0d3-62bcb92a56c4@oracle.com>
Date:   Fri, 24 Aug 2018 13:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20180823162424.13282-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/23/2018 09:24 AM, Vitaly Kuznetsov wrote:
> nested_run_pending is set 20 lines above and check_vmentry_prereqs()/
> check_vmentry_postreqs() don't seem to be resetting it (the later, however,
> checks it).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/vmx.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6c3514750d0c..8a63b8cf9458 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -14221,9 +14221,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>   	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
>   		return -EINVAL;
>   
> -	if (kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING)
> -		vmx->nested.nested_run_pending = 1;
> -
>   	vmx->nested.dirty_vmcs12 = true;
>   	ret = enter_vmx_non_root_mode(vcpu, NULL);
>   	if (ret)
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548E0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MlzcjPom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeGSB4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:56:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53758 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbeGSB4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:56:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6J1F7pC170241;
        Thu, 19 Jul 2018 01:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QWDS3z0PwcdVOinL1kxvehqHihX+ly1hOpOQ6oJK1JU=;
 b=MlzcjPoml6i68DySEO9ES7wR4kOhFjsYeP/7FtnYhZxGvpPzpgbXeGBSI0i4bLzuHBck
 9FuOPCDFEMMZbJ3bYas9jrjNFc+WxyLAG0xKwWeZkfgZ5qAn/Se8v7dHkO2NF81NBZ4E
 XA6r3xq5gDCwty1VpSNd7HKmjI+G7tUWPD7TzMXX1Cy3dJmgv3jsBJLuMz0ooOVGDC3P
 5wvcYmm893/zZEPZfhtUpjwwEH4OBh3ZCZbwfq6L/Y+pJ59ldvDdpqInmR7WQunQPX8X
 4kfX103d3pzLN0NpAWMlk/4b21PIznQq2mjat6Kw4/X9jiwLOXLtEa3KhgkWPmPN+WP/ 0Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k9yjx3tbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 01:15:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6J1Fnrc028928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 01:15:50 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6J1FmaY031768;
        Thu, 19 Jul 2018 01:15:49 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Jul 2018 18:15:48 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 2C5E36A00EB; Wed, 18 Jul 2018 21:15:46 -0400 (EDT)
Date:   Wed, 18 Jul 2018 21:15:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] x86/kvm: Don't use pvqspinlock code if only 1 vCPU
Message-ID: <20180719011546.GB28585@char.US.ORACLE.com>
References: <1531864767-30648-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531864767-30648-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:59:27PM -0400, Waiman Long wrote:
> On a VM with only 1 vCPU, the locking fast path will always be
> successful. In this case, there is no need to use the the PV qspinlock
> code which has higher overhead on the unlock side than the native
> qspinlock code.

Why not make this global? That is for both KVM and Xen and any
other virtualized guest that uses this?

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/kvm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5b2300b..575c9a5 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -748,6 +748,10 @@ void __init kvm_spinlock_init(void)
>  	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
>  		return;
>  
> +	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
> +	if (num_possible_cpus() == 1)
> +		return;
> +
>  	__pv_init_lock_hash();
>  	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
> -- 
> 1.8.3.1
> 

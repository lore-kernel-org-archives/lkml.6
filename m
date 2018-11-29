Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91359C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D3213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CHJy6XNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2D3213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeK3BtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:49:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387874AbeK3BtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:49:11 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEYJAu041246;
        Thu, 29 Nov 2018 14:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wQS5TFT485CVsLcwk7d+LmN32dy4HXs2UAmzE3KKBV4=;
 b=CHJy6XNAZWpzVX0q5yS9IfWR72VoVqy/u1NdZGXuAErUgKr9Zy3G81YAnQnZTupi/5Vo
 lzKGckg69kFcDAAkatOfk2YaTHkSgFtzGgMXA2+Lep8+McIXKmM2YaJjXP6iR89JY+CZ
 XtVVljsxMPdNUvHO/d2GfNOCCfPqcAoBDlI7RKrlN/dcoKA4zIH/PUcTV36RyURaGVAj
 znocTTVlSEh6VP5vmmxfrfpbYUcNHoLXBc5evQr22AEvRNvP99K0BLLRNWNpbjRP04FO
 KtsJr6w8y1f5lulhPJHKVq4gKNbM2V6ZTZju3PdNeNNDS+4eY//n7uwcd+U0EYs73xGj 9w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nxxkqrhp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:43:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATEh1Lf019694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:43:01 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATEh0Dj008861;
        Thu, 29 Nov 2018 14:43:00 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:43:00 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 44D276A00FB; Thu, 29 Nov 2018 09:42:56 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:42:56 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 08/28] sched/smt: Make sched_smt_present track topology
Message-ID: <20181129144256.GI32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.246110444@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185004.246110444@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:36PM +0100, Thomas Gleixner wrote:
> Currently the 'sched_smt_present' static key is enabled when at CPU bringup
> SMT topology is observed, but it is never disabled. However there is demand
> to also disable the key when the topology changes such that there is no SMT
> present anymore.
> 
> Implement this by making the key count the number of cores that have SMT
> enabled.
> 
> In particular, the SMT topology bits are set before interrrupts are enabled
> and similarly, are cleared after interrupts are disabled for the last time
> and the CPU dies.

I see that the number you used is '2', but I thought that there are some
CPUs out there (Knights Landing?) that could have four threads?

Would it be better to have a generic function that would provide the
amount of threads the platform does expose - and use that instead
of a constant value? 

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  kernel/sched/core.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5738,15 +5738,10 @@ int sched_cpu_activate(unsigned int cpu)
>  
>  #ifdef CONFIG_SCHED_SMT
>  	/*
> -	 * The sched_smt_present static key needs to be evaluated on every
> -	 * hotplug event because at boot time SMT might be disabled when
> -	 * the number of booted CPUs is limited.
> -	 *
> -	 * If then later a sibling gets hotplugged, then the key would stay
> -	 * off and SMT scheduling would never be functional.
> +	 * When going up, increment the number of cores with SMT present.
>  	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) > 1)
> -		static_branch_enable_cpuslocked(&sched_smt_present);
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +		static_branch_inc_cpuslocked(&sched_smt_present);
>  #endif
>  	set_cpu_active(cpu, true);
>  
> @@ -5790,6 +5785,14 @@ int sched_cpu_deactivate(unsigned int cp
>  	 */
>  	synchronize_rcu_mult(call_rcu, call_rcu_sched);
>  
> +#ifdef CONFIG_SCHED_SMT
> +	/*
> +	 * When going down, decrement the number of cores with SMT present.
> +	 */
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +		static_branch_dec_cpuslocked(&sched_smt_present);
> +#endif
> +
>  	if (!sched_smp_initialized)
>  		return 0;
>  
> 
> 

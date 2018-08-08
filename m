Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61147C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7821771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HxZZEL/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE7821771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeHHSOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:14:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeHHSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:14:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w78FiNXM029617;
        Wed, 8 Aug 2018 15:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jYq931jxEV+oItabJ/AA4jJJ3LI5ZmXRU/t5AB7FXgM=;
 b=HxZZEL/nbdd778wNcTrU+a1ZkdLQsa3LBdq+T8j0VFWgcAn8MZaPqeoO+9GYt48Meycc
 B/wN7oBGNOYFD0nSVdgG+vx/v4VP0+qJqJWeI+nUL4i9qTO6BKBKPJuI+L9o+q0tcq6a
 NIaEDlVK0sWjQOLq8gx0R+lesVOy06pfh4vPzzgB/Yh7LsucLkHfhI3wK61LmZukztGY
 kRj+e6FUfowc7UIsrSZaLmCvaqs3hksJXh6emAsE1WICLB4wOmS5a+g0OU07ubMiLz+G
 XO/9YyFYmA1VfBkkb7JGVhjNZVEFL0OgiMvd9jBkQ9YfWnuxQUM9rScseDkTNwGkUrcL +g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2kn43nxdbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 15:53:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w78FrvIq026806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 15:53:57 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w78FrvrN015915;
        Wed, 8 Aug 2018 15:53:57 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 08:53:56 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id A33156A00F6; Wed,  8 Aug 2018 11:53:55 -0400 (EDT)
Date:   Wed, 8 Aug 2018 11:53:55 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, Fred Jacobs <fjacobs@vmware.com>,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH] x86/spectre: Expand test for vulnerability to empty RSB
 exploits
Message-ID: <20180808155355.GA9635@char.us.oracle.com>
References: <20180807222535.143193-1-jmattson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807222535.143193-1-jmattson@google.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 03:25:35PM -0700, Jim Mattson wrote:
> Skylake-era Intel CPUs are vulnerable to exploits of empty RSB
> conditions. On hardware, platform vulnerability can be determined
> simply by checking the processor's DisplayModel/DisplayFamily
> signature.  However, when running in a VM, the operating system should
> also query IA32_ARCH_CAPABILITIES.RSBA[bit 2], a synthetic bit that
> can be set by a hypervisor to indicate that the VM might run on a
> vulnerable physical processor, regardless of the
> DisplayModel/DisplayFamily reported by CPUID.
> 
> Note that IA32_ARCH_CAPABILITIES.RSBA[bit 2] is always clear on
> hardware, so the DisplayModel/DisplayFamily check is still required.
> 
> For all of the details, see the Intel white paper, "Retpoline: A
> Branch Target Injection Mitigation" (document number 337131-001),
> section 5.3: Virtual Machine CPU Identification.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you as it saves me from doing this :-)
> ---
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/kernel/cpu/bugs.c       | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 68b2c3150de1..f37ec58c4e04 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -70,6 +70,7 @@
>  #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
>  #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
>  #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
> +#define ARCH_CAP_RSBA			(1 << 2)   /* Vulnerable to empty RSB */
>  #define ARCH_CAP_SSB_NO			(1 << 4)   /*
>  						    * Not susceptible to Speculative Store Bypass
>  						    * attack, so no Speculative Store Bypass
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 5c0ea39311fe..b6fe335746a4 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -330,6 +330,18 @@ static bool __init is_skylake_era(void)
>  	return false;
>  }
>  
> +/* Check for vulnerability to exploits of empty RSB conditions */
> +static bool __init is_vulnerable_to_empty_rsb(void)
> +{
> +	u64 ia32_cap = 0;
> +
> +	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
> +		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
> +
> +	return (ia32_cap & ARCH_CAP_RSBA) || is_skylake_era();
> +}
> +
> +
>  static void __init spectre_v2_select_mitigation(void)
>  {
>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> @@ -402,7 +414,7 @@ static void __init spectre_v2_select_mitigation(void)
>  	 * switch is required.
>  	 */
>  	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
> -	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
> +	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_vulnerable_to_empty_rsb()) {
>  		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
>  		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
>  	}
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 

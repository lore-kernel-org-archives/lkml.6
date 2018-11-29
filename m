Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342BAC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52C020673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0ZhGS47d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52C020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbeK3BsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57438 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbeK3BsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATEYE6a077723;
        Thu, 29 Nov 2018 14:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6C5BQDHCe8J1kMwqFRz4RD4rFxM9vqC2cOlO1D5qSIE=;
 b=0ZhGS47dIqjxhIpmcuYsHdF6AnCXxSP1Vruu0lMReltPg3iPOuHRxyPKxSZ2Ba1jJgx7
 d6DM+whgE/iIK44BeJxiiIod5ArgGnPPIZykp9lzF0UULUwPPh4yo7r7Nu39L3qWVTnT
 bsaKN+H4M5usG3IJRwqlaJ94peCHwoPOqvYL4mlOhPr3XeclKctUXE3KikdAhL7TpV78
 /tBSFgoRmf/K7y/1NXZx1sbQh5/L43Tu0VtwD9CWTqvZEGzpVl3UNfABFGjCdtb9pgJN
 qGtt/MjeflYz6rQJp1oet7pkiqp5+IIcTHJirPZ5djEp4dnTIkuiwxyeFFhm8KYWC41B WA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2ugkbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:41:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wATEf8SC018889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 14:41:08 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATEf8Ad030698;
        Thu, 29 Nov 2018 14:41:08 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 06:41:08 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 20F186A00FB; Thu, 29 Nov 2018 09:41:04 -0500 (EST)
Date:   Thu, 29 Nov 2018 09:41:04 -0500
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
Subject: Re: [patch V2 07/28] x86/speculation: Reorganize speculation control
 MSRs update
Message-ID: <20181129144104.GH32259@char.us.oracle.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.151077005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125185004.151077005@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 07:33:35PM +0100, Thomas Gleixner wrote:
> The logic to detect whether there's a change in the previous and next
> task's flag relevant to update speculation control MSRs are spread out
> across multiple functions.
> 
> Consolidate all checks needed for updating speculation control MSRs into
> the new __speculation_ctrl_update() helper function.
> 
> This makes it easy to pick the right speculation control MSR and the bits
> in the MSR that needs updating based on TIF flags changes.
> 
> Originally-by: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

.. and I also have two tiny comments below - feel free to
incorporate or not them in.
> 
> ---
>  arch/x86/kernel/process.c |   42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -397,25 +397,48 @@ static __always_inline void amd_set_ssb_
>  
>  static __always_inline void spec_ctrl_update_msr(unsigned long tifn)
>  {
> -	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
> +	u64 msr = x86_spec_ctrl_base;
> +
> +	/*
> +	 * If X86_FEATURE_SSBD is not set, the SSBD bit is not to be
> +	 * touched.
> +	 */

I had a bit of hard time parsing that. Could it perhaps be changed to:

"If X86_FEATURE_SSBD is off (not set), we MUST leave the SSBD bit alone"
> +	if (static_cpu_has(X86_FEATURE_SSBD))
> +		msr |= ssbd_tif_to_spec_ctrl(tifn);
>  
>  	wrmsrl(MSR_IA32_SPEC_CTRL, msr);
>  }
>  
> -static __always_inline void __speculation_ctrl_update(unsigned long tifn)
> +/*
> + * Update the MSRs managing speculation control, during context switch.
> + *
> + * tifp: Previous task's thread flags
> + * tifn: Next task's thread flags
> + */
> +static __always_inline void __speculation_ctrl_update(unsigned long tifp,
> +						      unsigned long tifn)
>  {
> -	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> -		amd_set_ssb_virt_state(tifn);
> -	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> -		amd_set_core_ssb_state(tifn);
> -	else
> +	bool updmsr = false;
> +
> +	/* If TIF_SSBD is different, select the proper mitigation method */
> +	if ((tifp ^ tifn) & _TIF_SSBD) {
> +		if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
> +			amd_set_ssb_virt_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +			amd_set_core_ssb_state(tifn);
> +		else if (static_cpu_has(X86_FEATURE_SSBD))
> +			updmsr  = true;
                              ^
Nothing really big, but you have an extra space here.
> +	}
> +
> +	if (updmsr)
>  		spec_ctrl_update_msr(tifn);
>  }
>  
>  void speculation_ctrl_update(unsigned long tif)
>  {
> +	/* Forced update. Make sure all relevant TIF flags are different */
>  	preempt_disable();
> -	__speculation_ctrl_update(tif);
> +	__speculation_ctrl_update(~tif, tif);
>  	preempt_enable();
>  }
>  
> @@ -451,8 +474,7 @@ void __switch_to_xtra(struct task_struct
>  	if ((tifp ^ tifn) & _TIF_NOCPUID)
>  		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
>  
> -	if ((tifp ^ tifn) & _TIF_SSBD)
> -		__speculation_ctrl_update(tifn);
> +	__speculation_ctrl_update(tifp, tifn);
>  }
>  
>  /*
> 
> 

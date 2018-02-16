Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbeBPSoM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:44:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:30488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753572AbeBPSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:44:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="204886406"
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <c77b3da9-136d-9988-119f-e94c86fd34a3@linux.intel.com>
Date: Fri, 16 Feb 2018 10:44:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2018 11:19 AM, tip-bot for David Woodhouse wrote:
		\
>  })
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 300cc15..788c4da 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -162,17 +162,36 @@ static inline void vmexit_fill_RSB(void)
>  #endif
>  }
>  
> +#define alternative_msr_write(_msr, _val, _feature)		\
> +	asm volatile(ALTERNATIVE("",				\
> +				 "movl %[msr], %%ecx\n\t"	\
> +				 "movl %[val], %%eax\n\t"	\
> +				 "movl $0, %%edx\n\t"		\
> +				 "wrmsr",			\
> +				 _feature)			\
> +		     : : [msr] "i" (_msr), [val] "i" (_val)	\
> +		     : "eax", "ecx", "edx", "memory")
> +

I encountered hang on a machine but not others when using the above
macro.  It is probably an alignment thing with ALTERNATIVE as the problem went
away after I made the change below:

Tim

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8f2ff74..0f65bd2 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -148,6 +148,7 @@ extern char __indirect_thunk_end[];
 
 #define alternative_msr_write(_msr, _val, _feature)            \
        asm volatile(ALTERNATIVE("",                            \
+                               ".align 16\n\t"                \
                                "movl %[msr], %%ecx\n\t"       \
                                "movl %[val], %%eax\n\t"       \
                                "movl $0, %%edx\n\t"           \

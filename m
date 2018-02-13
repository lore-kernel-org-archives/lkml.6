Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x226zcSFB0x7+rd0DMWY7KIcB6QwJ0t8CFKmTGsfy1HVo3xvTtRrgVDaQ+HPd3uaZHMQ02Wa3
ARC-Seal: i=1; a=rsa-sha256; t=1518514915; cv=none;
        d=google.com; s=arc-20160816;
        b=JV820T6x9eBoNMX8zIuwut7sxUhTvpq3yXEPKivhixKRYhxeMwXI6otZNy8yLBLXHQ
         83eZwnCh0+I8aImC2vNR/K1MH485qynokrlYptCKqlurBwNij2Gvw8dChPLBpRteBNcB
         TymVHLnXAlXB4VxC4UJtP5SZdeAWYu2ARS9LRThJn+9b2CMEyNuYTyAADJ2ZlcQEZHOB
         Z3dxm35nLoVJxBWEf/9sBaadU/TMjI6W0Q0nBnNKy8jfkTZoOUMcDQNUarwK1+t0WtXC
         90TG8Cb+46HU1vvIIbBDHkxbMwYVDovOBXCmvMoUK22XUPSLGacRB7sFgjtVtxNl53co
         4QkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=HAk7Syye/VxG3AJGBuDqaUUMo3+TAibTd/6EfVAprxo=;
        b=fXokdhvkV7pG0pLIlu6fwJIxnQoEN7R6zdqQH1PwbdKKkkSblPuCWJcSHtvYBRaKkN
         H7h2aIxR0r58PFV28CWPHXHdCiwHF/B9MFDVtLTDsQziC8DJQBBbzdvXhaVwqquANxNg
         iYqk3qy4YVMOkpgdIq4vMP835pFzmKJpxr3tNS+8r7ywy2ZDZPIZBWR/agkpCGKdYJBq
         8y6+vYqf/8QK/IazHKEaGcyWB7dpiu1eyoB5C0E5xfWIUffAZSyrzIhRh5w1tD+CAghA
         bjo/bbp9nsmjbn7uMxGtE8qhYA8QNg/UiRU6F+Zrum/5QNBLA8l7bZ5LpJkbA9arcgJk
         orvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=cUsG/kry;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=cUsG/kry;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 13 Feb 2018 10:41:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
	bp@alien8.de, tglx@linutronix.de, arjan@linux.intel.com,
	mingo@kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org,
	hpa@zytor.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com,
	dwmw@amazon.co.uk, luto@kernel.org, jpoimboe@redhat.com
Cc: linux-tip-commits@vger.kernel.org,
	Joe Konno <joe.konno@linux.intel.com>
Subject: Re: [tip:x86/pti] Revert "x86/speculation: Simplify
 indirect_branch_prediction_barrier()"
Message-ID: <20180213094132.GF25201@hirez.programming.kicks-ass.net>
References: <1518305967-31356-3-git-send-email-dwmw@amazon.co.uk>
 <tip-f208820a321f9b23d77d7eed89945d862d62a3ed@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-f208820a321f9b23d77d7eed89945d862d62a3ed@git.kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160265203742206?=
X-GMAIL-MSGID: =?utf-8?q?1592278296701340198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Tue, Feb 13, 2018 at 12:58:21AM -0800, tip-bot for David Woodhouse wrote:

> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -164,10 +164,15 @@ static inline void vmexit_fill_RSB(void)
>  
>  static inline void indirect_branch_prediction_barrier(void)
>  {
> +	asm volatile(ALTERNATIVE("",
> +				 "movl %[msr], %%ecx\n\t"
> +				 "movl %[val], %%eax\n\t"
> +				 "movl $0, %%edx\n\t"
> +				 "wrmsr",
> +				 X86_FEATURE_USE_IBPB)
> +		     : : [msr] "i" (MSR_IA32_PRED_CMD),
> +			 [val] "i" (PRED_CMD_IBPB)
> +		     : "eax", "ecx", "edx", "memory");
>  }

Joe Konno pointed out that we now need the below line too, because we're
using MSR_IA32_PRED_CMD in this header.

With the existing code that's not a problem per-se, but my objtool
retpoline annotation things did do stumble over this.

Do we want to fold it into the objtool annotation patch or have it
separate?

---
 arch/x86/include/asm/nospec-branch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 300cc159b4a0..76b058533e47 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -6,6 +6,7 @@
 #include <asm/alternative.h>
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
+#include <asm/msr-index.h>
 
 #ifdef __ASSEMBLY__
 

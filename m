Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDJUAc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:00:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:56213 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbeDJUAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:00:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="190420761"
Subject: Re: [PATCH] x86: fix pgprotval_t format string
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <20180410084424.2935759-1-arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <5f6f0b92-9774-2dc8-c28b-4a9e3a9a211d@linux.intel.com>
Date: Tue, 10 Apr 2018 13:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410084424.2935759-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 01:43 AM, Arnd Bergmann wrote:
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -533,11 +533,11 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
>  	/* mmdebug.h can not be included here because of dependencies */
>  #ifdef CONFIG_DEBUG_VM
>  	WARN_ONCE(pgprot_val(pgprot) != massaged_val,
> -		  "attempted to set unsupported pgprot: %016lx "
> -		  "bits: %016lx supported: %016lx\n",
> -		  pgprot_val(pgprot),
> -		  pgprot_val(pgprot) ^ massaged_val,
> -		  __supported_pte_mask);
> +		  "attempted to set unsupported pgprot: %016llx "
> +		  "bits: %016llx supported: %016llx\n",
> +		  (u64)pgprot_val(pgprot),
> +		  (u64)pgprot_val(pgprot) ^ massaged_val,
> +		  (u64)__supported_pte_mask);
>  #endif

Whoops, I just sent a similar patch.  I just used 'unsigned long long'
instead of u64.  I'm fine with this as well, and don't prefer one over
the other, so:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

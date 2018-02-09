Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeBIXaG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:30:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:51091 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbeBIXaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:30:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,486,1511856000";
   d="scan'208";a="17351286"
Subject: Re: [tip:x86/pti] x86/pti: Make sure the user/kernel PTEs match
To: bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        mroos@linux.ee, hpa@zytor.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, linux-tip-commits@vger.kernel.org
References: <alpine.DEB.2.20.1801031407180.1957@nanos>
 <tip-52994c256df36fda9a715697431cba9daecb6b11@git.kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c1ab0e86-e7ed-6950-2b84-e6ebaa6d6db8@intel.com>
Date: Fri, 9 Feb 2018 15:30:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <tip-52994c256df36fda9a715697431cba9daecb6b11@git.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2018 08:22 AM, tip-bot for Thomas Gleixner wrote:
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -367,7 +367,8 @@ static void __init pti_setup_espfix64(void)
>  static void __init pti_clone_entry_text(void)
>  {
>  	pti_clone_pmds((unsigned long) __entry_text_start,
> -			(unsigned long) __irqentry_text_end, _PAGE_RW);
> +			(unsigned long) __irqentry_text_end,
> +		       _PAGE_RW | _PAGE_GLOBAL);
>  }

We appear to have lost all of our global bits between this and the
cpu_entry_area itself.  To make K8 happy, shouldn't we just *set*
_PAGE_GLOBAL universally instead of clearing it universally?

Also, don't we want _PAGE_GLOBAL in the cpu_entry_area.c pte setting?  I
think I had this for all the shared user/kernel areas near the end of
the KAISER era, but we appear to have totally nuked it for PTI.

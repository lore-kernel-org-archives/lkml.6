Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039F1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C7721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C7721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJDUVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbeJDUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 161F5C0467C0;
        Thu,  4 Oct 2018 13:27:54 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-44.brq.redhat.com [10.40.200.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 279AD66082;
        Thu,  4 Oct 2018 13:27:42 +0000 (UTC)
Date:   Thu, 4 Oct 2018 15:28:11 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v4 6/9] x86/cet/ibt: Add arch_prctl functions for IBT
Message-ID: <20181004132811.GJ32759@asgard.redhat.com>
References: <20180921150553.21016-1-yu-cheng.yu@intel.com>
 <20180921150553.21016-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150553.21016-7-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 04 Oct 2018 13:27:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:05:50AM -0700, Yu-cheng Yu wrote:
> Update ARCH_CET_STATUS and ARCH_CET_DISABLE to include Indirect
> Branch Tracking features.
> 
> Introduce:
> 
> arch_prctl(ARCH_CET_LEGACY_BITMAP, unsigned long *addr)
>     Enable the Indirect Branch Tracking legacy code bitmap.
> 
>     The parameter 'addr' is a pointer to a user buffer.
>     On returning to the caller, the kernel fills the following:
> 
>     *addr = IBT bitmap base address
>     *(addr + 1) = IBT bitmap size

Again, some structure with a size field would be better from
UAPI/extensibility standpoint.

One additional point: "size" in the structure from kernel should have
structure size expected by kernel, and at least providing there "0" from
user space shouldn't lead to failure (in fact, it is possible to provide
structure size back to userspace even if buffer is too small, along
with error).

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/uapi/asm/prctl.h |  1 +
>  arch/x86/kernel/cet_prctl.c       | 38 ++++++++++++++++++++++++++++++-
>  arch/x86/kernel/process.c         |  1 +
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 3aec1088e01d..31d2465f9caf 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -18,5 +18,6 @@
>  #define ARCH_CET_DISABLE	0x3002
>  #define ARCH_CET_LOCK		0x3003
>  #define ARCH_CET_ALLOC_SHSTK	0x3004
> +#define ARCH_CET_LEGACY_BITMAP	0x3005

It would probably be nice to have mention of an architecture in these
definitions ("ARCH_X86_CET_"...), but it's likely too late.

>  
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
> index c4b7c19f5040..df47b5ebc3f4 100644
> --- a/arch/x86/kernel/cet_prctl.c
> +++ b/arch/x86/kernel/cet_prctl.c
> @@ -20,6 +20,8 @@ static int handle_get_status(unsigned long arg2)
>  
>  	if (current->thread.cet.shstk_enabled)
>  		features |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
> +	if (current->thread.cet.ibt_enabled)
> +		features |= GNU_PROPERTY_X86_FEATURE_1_IBT;
>  
>  	shstk_base = current->thread.cet.shstk_base;
>  	shstk_size = current->thread.cet.shstk_size;
> @@ -49,9 +51,35 @@ static int handle_alloc_shstk(unsigned long arg2)
>  	return 0;
>  }
>  
> +static int handle_bitmap(unsigned long arg2)
> +{
> +	unsigned long addr, size;
> +
> +	if (current->thread.cet.ibt_enabled) {
> +		int err;
> +
> +		err  = cet_setup_ibt_bitmap();
> +		if (err)
> +			return err;
> +
> +		addr = current->thread.cet.ibt_bitmap_addr;
> +		size = current->thread.cet.ibt_bitmap_size;
> +	} else {
> +		addr = 0;
> +		size = 0;
> +	}
> +
> +	if (put_user(addr, (unsigned long __user *)arg2) ||
> +	    put_user(size, (unsigned long __user *)arg2 + 1))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int prctl_cet(int option, unsigned long arg2)
>  {
> -	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) &&
> +	    !cpu_feature_enabled(X86_FEATURE_IBT))

This check is repeated many times, it is probably worth defining
something like cpu_x86_cet_enabled() or something like that.
Besides, early introduction of the macro would allow avoiding all these
changes over the code in IBT patches, only macro definition has
to be changed that way.

> @@ -73,6 +103,12 @@ int prctl_cet(int option, unsigned long arg2)
>  	case ARCH_CET_ALLOC_SHSTK:
>  		return handle_alloc_shstk(arg2);
>  
> +	/*
> +	 * Allocate legacy bitmap and return address & size to user.
> +	 */
> +	case ARCH_CET_LEGACY_BITMAP:
> +		return handle_bitmap(arg2);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ac0ea9c7e89f..aea15a9b6a3e 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -797,6 +797,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
>  	case ARCH_CET_DISABLE:
>  	case ARCH_CET_LOCK:
>  	case ARCH_CET_ALLOC_SHSTK:
> +	case ARCH_CET_LEGACY_BITMAP:
>  		return prctl_cet(option, cpuid_enabled);
>  	}

I wonder, whether this duplication is really needed for CET-related
arch_prctl commands, why not just call them from do_arch_prctl_common?

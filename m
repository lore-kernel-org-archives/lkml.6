Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F89C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57CC213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57CC213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJDCqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeJDCqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C52EB307D857;
        Wed,  3 Oct 2018 19:56:48 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F19B300166E;
        Wed,  3 Oct 2018 19:56:36 +0000 (UTC)
Date:   Wed, 3 Oct 2018 21:57:06 +0200
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
Subject: Re: [RFC PATCH v4 3/9] x86/cet/ibt: Add IBT legacy code bitmap
 allocation function
Message-ID: <20181003195702.GF32759@asgard.redhat.com>
References: <20180921150553.21016-1-yu-cheng.yu@intel.com>
 <20180921150553.21016-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150553.21016-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 03 Oct 2018 19:56:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:05:47AM -0700, Yu-cheng Yu wrote:
> Indirect branch tracking provides an optional legacy code bitmap
> that indicates locations of non-IBT compatible code.  When set,
> each bit in the bitmap represents a page in the linear address is
> legacy code.
> 
> We allocate the bitmap only when the application requests it.
> Most applications do not need the bitmap.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/kernel/cet.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 6adfe795d692..a65d9745af08 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -314,3 +314,48 @@ void cet_disable_ibt(void)
>  	wrmsrl(MSR_IA32_U_CET, r);
>  	current->thread.cet.ibt_enabled = 0;
>  }
> +
> +int cet_setup_ibt_bitmap(void)
> +{
> +	u64 r;
> +	unsigned long bitmap;
> +	unsigned long size;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_IBT))
> +		return -EOPNOTSUPP;
> +
> +	if (!current->thread.cet.ibt_bitmap_addr) {
> +		/*
> +		 * Calculate size and put in thread header.
> +		 * may_expand_vm() needs this information.
> +		 */
> +		size = TASK_SIZE / PAGE_SIZE / BITS_PER_BYTE;

TASK_SIZE_MAX is likely needed here, as an application can easily switch
between long an 32-bit protected mode.  And then the case of a CPU that
doesn't support 5LPT.

> +		current->thread.cet.ibt_bitmap_size = size;
> +		bitmap = do_mmap_locked(0, size, PROT_READ | PROT_WRITE,
> +					MAP_ANONYMOUS | MAP_PRIVATE,
> +					VM_DONTDUMP);
> +
> +		if (bitmap >= TASK_SIZE) {

Shouldn't bitmap be unmapped here?

> +			current->thread.cet.ibt_bitmap_size = 0;
> +			return -ENOMEM;
> +		}
> +
> +		current->thread.cet.ibt_bitmap_addr = bitmap;
> +	}
> +
> +	/*
> +	 * Lower bits of MSR_IA32_CET_LEG_IW_EN are for IBT
> +	 * settings.  Clear lower bits even bitmap is already
> +	 * page-aligned.
> +	 */
> +	bitmap = current->thread.cet.ibt_bitmap_addr;
> +	bitmap &= PAGE_MASK;

In a hypothetical situation of bitmap & PAGE_MASK < bitmap that would lead
to bitmap pointing to unmapped memory. A check that bitmap is sane would
probably be better.

> +
> +	/*
> +	 * Turn on IBT legacy bitmap.
> +	 */
> +	rdmsrl(MSR_IA32_U_CET, r);
> +	r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> +	wrmsrl(MSR_IA32_U_CET, r);
> +	return 0;
> +}
> -- 
> 2.17.1
> 

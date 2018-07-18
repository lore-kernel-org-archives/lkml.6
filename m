Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E24ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346882075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346882075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeGRWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:25:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:3000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeGRWZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:25:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 14:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="73913393"
Received: from ray.jf.intel.com (HELO [10.7.201.15]) ([10.7.201.15])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2018 14:45:42 -0700
Subject: Re: [RFC PATCH v2 16/27] mm: Modify can_follow_write_pte/pmd for
 shadow stack
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-17-yu-cheng.yu@intel.com>
 <de510df6-7ea9-edc6-9c49-2f80f16472b4@linux.intel.com>
 <1531328731.15351.3.camel@intel.com>
 <45a85b01-e005-8cb6-af96-b23ce9b5fca7@linux.intel.com>
 <1531868610.3541.21.camel@intel.com>
 <fa9db8c5-41c8-05e9-ad8d-dc6aaf11cb04@linux.intel.com>
 <1531944882.10738.1.camel@intel.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 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
 z5cecg==
Message-ID: <3f158401-f0b6-7bf7-48ab-2958354b28ad@linux.intel.com>
Date:   Wed, 18 Jul 2018 14:45:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531944882.10738.1.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 01:14 PM, Yu-cheng Yu wrote:
> On Tue, 2018-07-17 at 16:15 -0700, Dave Hansen wrote:
>> On 07/17/2018 04:03 PM, Yu-cheng Yu wrote:
>>>
>>> We need to find a way to differentiate "someone can write to this PTE"
>>> from "the write bit is set in this PTE".
>> Please think about this:
>>
>> 	Should pte_write() tell us whether PTE.W=1, or should it tell us
>> 	that *something* can write to the PTE, which would include
>> 	PTE.W=0/D=1?
> 
> 
> Is it better now?
> 
> 
> Subject: [PATCH] mm: Modify can_follow_write_pte/pmd for shadow stack
> 
> can_follow_write_pte/pmd look for the (RO & DIRTY) PTE/PMD to
> verify a non-sharing RO page still exists after a broken COW.
> 
> However, a shadow stack PTE is always RO & DIRTY; it can be:
> 
>   RO & DIRTY_HW - is_shstk_pte(pte) is true; or
>   RO & DIRTY_SW - the page is being shared.
> 
> Update these functions to check a non-sharing shadow stack page
> still exists after the COW.
> 
> Also rename can_follow_write_pte/pmd() to can_follow_write() to
> make their meaning clear; i.e. "Can we write to the page?", not
> "Is the PTE writable?"
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  mm/gup.c         | 38 ++++++++++++++++++++++++++++++++++----
>  mm/huge_memory.c | 19 ++++++++++++++-----
>  2 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index fc5f98069f4e..316967996232 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -63,11 +63,41 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>  /*
>   * FOLL_FORCE can write to even unwritable pte's, but only
>   * after we've gone through a COW cycle and they are dirty.
> + *
> + * Background:
> + *
> + * When we force-write to a read-only page, the page fault
> + * handler copies the page and sets the new page's PTE to
> + * RO & DIRTY.  This routine tells
> + *
> + *     "Can we write to the page?"
> + *
> + * by checking:
> + *
> + *     (1) The page has been copied, i.e. FOLL_COW is set;
> + *     (2) The copy still exists and its PTE is RO & DIRTY.
> + *
> + * However, a shadow stack PTE is always RO & DIRTY; it can
> + * be:
> + *
> + *     RO & DIRTY_HW: when is_shstk_pte(pte) is true; or
> + *     RO & DIRTY_SW: when the page is being shared.
> + *
> + * To test a shadow stack's non-sharing page still exists,
> + * we verify that the new page's PTE is_shstk_pte(pte).

The content is getting there, but we need it next to the code, please.

>   */
> -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> +static inline bool can_follow_write(pte_t pte, unsigned int flags,
> +				    struct vm_area_struct *vma)
>  {
> -	return pte_write(pte) ||
> -		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> +	if (!is_shstk_mapping(vma->vm_flags)) {
> +		if (pte_write(pte))
> +			return true;

Let me see if I can say this another way.

The bigger issue is that these patches change the semantics of
pte_write().  Before these patches, it meant that you *MUST* have this
bit set to write to the page controlled by the PTE.  Now, it means: you
can write if this bit is set *OR* the shadowstack bit combination is set.

That's the fundamental problem.  We need some code in the kernel that
logically represents the concept of "is this PTE a shadowstack PTE or a
PTE with the write bit set", and we will call that pte_write(), or maybe
pte_writable().

You *have* to somehow rectify this situation.  We can absolutely no
leave pte_write() in its current, ambiguous state where it has no real
meaning or where it is used to mean _both_ things depending on context.

> +		return ((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
> +			pte_dirty(pte));
> +	} else {
> +		return ((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
> +			is_shstk_pte(pte));
> +	}
>  }

Ok, it's rewrite time I guess.

Yu-cheng, you may not know all the history, but this code is actually
the source of the "Dirty COW" security issue.  We need to be very, very
careful with it, and super-explicit about all the logic.  This is the
time to blow up the comments and walk folks through exactly what we
expect to happen.

Anybody think I'm being too verbose?  Is there a reason not to just go
whole-hog on this sucker?

static inline bool can_follow_write(pte_t pte, unsigned int flags,
				    struct vm_area_struct *vma)
{
	/*
	 * FOLL_FORCE can "write" to hardware read-only PTEs, but
	 * has to do a COW operation first.  Do not allow the
	 * hardware protection override unless we see FOLL_FORCE
	 * *and* the COW has been performed by the fault code.
	 */
	bool gup_cow_ok = (flags & FOLL_FORCE) &&
			  (flags & FOLL_COW);

	/*
	 * FOLL_COW flags tell us whether the page fault code did a COW
	 * operation but not whether the PTE we are dealing with here
	 * was COW'd.  It could have been zapped and refaulted since the
	 * COW operation.
	 */
	bool pte_cow_ok;

	/* We have two COW pte "formats" */
	if (!is_shstk_mapping(vma->vm_flags)) {
		if (pte_write(pte)) {
			/* Any hardware-writable PTE is writable here */
			pte_cow_ok = true;
		} else {
			/* Is the COW-set dirty bit still there? */
			pte_cow_ok = pte_dirty(pte));
		}
	} else {
		/* Shadow stack PTEs are always hardware-writable */

		/*
		 * Shadow stack pages do copy-on-access, so any present
		 * shadow stack page has had a COW-equivalent performed.
		 */
		pte_cow_ok = is_shstk_pte(pte));
	}

	return gup_cow_ok && pte_cow_ok;
}

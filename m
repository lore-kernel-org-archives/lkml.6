Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeBIEry (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 23:47:54 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50875 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbeBIErw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 23:47:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04421;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0SxvBcog_1518151655;
Subject: Re: [PATCH] mm: thp: fix potential clearing to referenced flag in
 page_idle_clear_pte_refs_one()
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1517875596-76350-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180208143926.5484e8fd75a56ff35b778bcc@linux-foundation.org>
 <20180209043325.l6b6hwgeomqldeb6@node.shutemov.name>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a19c08ad-ce34-3a9f-0c7c-6ca912660456@linux.alibaba.com>
Date: Thu, 8 Feb 2018 20:47:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180209043325.l6b6hwgeomqldeb6@node.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/18 8:33 PM, Kirill A. Shutemov wrote:
> On Thu, Feb 08, 2018 at 02:39:26PM -0800, Andrew Morton wrote:
>> On Tue,  6 Feb 2018 08:06:36 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>>> For PTE-mapped THP, the compound THP has not been split to normal 4K
>>> pages yet, the whole THP is considered referenced if any one of sub
>>> page is referenced.
>>>
>>> When walking PTE-mapped THP by pvmw, all relevant PTEs will be checked
>>> to retrieve referenced bit. But, the current code just returns the
>>> result of the last PTE. If the last PTE has not referenced, the
>>> referenced flag will be cleared.
>>>
>>> So, here just break pvmw walk once referenced PTE is found if the page
>>> is a part of THP.
>>>
>>> ...
>>>
>>> --- a/mm/page_idle.c
>>> +++ b/mm/page_idle.c
>>> @@ -67,6 +67,14 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
>>>   		if (pvmw.pte) {
>>>   			referenced = ptep_clear_young_notify(vma, addr,
>>>   					pvmw.pte);
>>> +			/*
>>> +			 * For PTE-mapped THP, one sub page is referenced,
>>> +			 * the whole THP is referenced.
>>> +			 */
>>> +			if (referenced && PageTransCompound(pvmw.page)) {
>>> +				page_vma_mapped_walk_done(&pvmw);
>>> +				break;
>>> +			}
>> This means that the function will no longer clear the referenced bits
>> in all the ptes.  What effect does this have and should we document
>> this in some fashion?
> Yeah, the patch is wrong. We need to get all ptes for THP cleared.
>
> What about something like this instead (untested):

Thanks, Kirill. It looks correct. All ptes should be cleared.

I'm going to prepare v2 patch.

Regards,
Yang

>
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index 0a49374e6931..6876522c9dce 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -65,10 +65,10 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
>          while (page_vma_mapped_walk(&pvmw)) {
>                  addr = pvmw.address;
>                  if (pvmw.pte) {
> -                       referenced = ptep_clear_young_notify(vma, addr,
> +                       referenced |= ptep_clear_young_notify(vma, addr,
>                                          pvmw.pte);
>                  } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -                       referenced = pmdp_clear_young_notify(vma, addr,
> +                       referenced |= pmdp_clear_young_notify(vma, addr,
>                                          pvmw.pmd);
>                  } else {
>                          /* unexpected pmd-mapped page? */

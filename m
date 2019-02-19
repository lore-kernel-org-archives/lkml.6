Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15889C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64642147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfBSSLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:11:42 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57812 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfBSSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:11:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TKb7nk._1550599893;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TKb7nk._1550599893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Feb 2019 02:11:35 +0800
Subject: Re: [PATCH mmotm] mm: ksm: do not block on page lock when searching
 stable tree fix
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ktkhai@virtuozzo.com, jhubbard@nvidia.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <alpine.LSU.2.11.1902182122280.6914@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b3df95be-be74-ec5d-5944-2491cff3e6f3@linux.alibaba.com>
Date:   Tue, 19 Feb 2019 10:11:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1902182122280.6914@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/19 9:26 PM, Hugh Dickins wrote:
> I hit the kernel BUG at mm/ksm.c:809! quite easily under KSM swapping
> load.  That's the BUG_ON(age > 1) in remove_rmap_item_from_tree().
>
> There is a comment above it, but explaining in more detail: KSM saves
> effort by not fully maintaining the unstable tree like a proper RB
> tree throughout, but at the start of each pass forgetting the old tree
> and rebuilding anew from scratch. But that means that whenever it looks
> like we need to remove an item from the unstable tree, we have to check
> whether it has already been linked into the new tree this time around
> (hence rb_erase needed), or it's just a free-floating leftover from the
> previous tree.
>
> "age" 0 or 1 says which: but if it's more than 1, then something has
> gone wrong: cmp_and_merge_page() was forgetting to remove the item
> in the new EBUSY case.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Fix to fold into
> mm-ksm-do-not-block-on-page-lock-when-searching-stable-tree.patch

Thanks for catching this. The fix looks good to me.

>
> I like that patch better now it has the mods suggested by John Hubbard;
> but what I'd still really prefer to do is to make the patch unnecessary,
> by reworking that window of KSM page migration so that there's just no
> need for stable_tree_search() to take page lock.  We would all prefer
> that.  However, each time I've gone to do so, it's turned out to need
> more care than I expected, and I run out of time.  So, let's go with
> what we have, and one day I might perhaps get back to it.

I agree it needs extra scrutiny to make the code lockless.

Regards,
Yang

>
>   mm/ksm.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> --- mmotm/mm/ksm.c	2019-02-14 15:16:13.000000000 -0800
> +++ linux/mm/ksm.c	2019-02-18 20:36:44.707310427 -0800
> @@ -2082,10 +2082,6 @@ static void cmp_and_merge_page(struct pa
>   
>   	/* We first start with searching the page inside the stable tree */
>   	kpage = stable_tree_search(page);
> -
> -	if (PTR_ERR(kpage) == -EBUSY)
> -		return;
> -
>   	if (kpage == page && rmap_item->head == stable_node) {
>   		put_page(kpage);
>   		return;
> @@ -2094,6 +2090,9 @@ static void cmp_and_merge_page(struct pa
>   	remove_rmap_item_from_tree(rmap_item);
>   
>   	if (kpage) {
> +		if (PTR_ERR(kpage) == -EBUSY)
> +			return;
> +
>   		err = try_to_merge_with_ksm_page(rmap_item, page, kpage);
>   		if (!err) {
>   			/*


Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54982C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C687218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfBAO6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:58:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbfBAO6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:58:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3D74AC90;
        Fri,  1 Feb 2019 14:58:20 +0000 (UTC)
Subject: Re: [PATCH 11/22] mm, compaction: Use free lists to quickly locate a
 migration target
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-12-mgorman@techsingularity.net>
 <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
 <20190201145139.GI9565@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <cb0bae2e-8628-1378-68a1-9da02a94652e@suse.cz>
Date:   Fri, 1 Feb 2019 15:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201145139.GI9565@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 3:51 PM, Mel Gorman wrote:
> On Thu, Jan 31, 2019 at 03:52:10PM +0100, Vlastimil Babka wrote:
>>> -/* Reorder the free list to reduce repeated future searches */
>>> +/*
>>> + * Used when scanning for a suitable migration target which scans freelists
>>> + * in reverse. Reorders the list such as the unscanned pages are scanned
>>> + * first on the next iteration of the free scanner
>>> + */
>>> +static void
>>> +move_freelist_head(struct list_head *freelist, struct page *freepage)
>>> +{
>>> +	LIST_HEAD(sublist);
>>> +
>>> +	if (!list_is_last(freelist, &freepage->lru)) {
>>
>> Shouldn't there be list_is_first() for symmetry?
>>
> 
> I don't think it would help. We're reverse traversing the list when this is
> called. If it's the last entry, it's moving just one page before breaking
> off the search and a shuffle has minimal impact. If it's the first page
> then list_cut_before moves the entire list to sublist before splicing it
> back so it's a pointless operation.

Yeah I thought the goal was to avoid the pointless operation, which is
why it was previously added as "if (!list_is_last())" in
move_freelist_head(). So in move_freelist_head() it would have to be as
"if (!list_is_first())" to achieve the same effect. Agree that it's
marginal but if that's so then I would just remove the checks completely
(from both functions) instead of having it subtly wrong in one of them?


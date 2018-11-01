Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29E5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A64D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KXotOIBB";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KXotOIBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A64D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeKBBqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:46:37 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:37476 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbeKBBqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:46:37 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id E4E7E217B8;
        Thu,  1 Nov 2018 19:42:48 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id T67TOIIm2D-gmJ08BLL;
        Thu, 01 Nov 2018 19:42:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541090568; bh=YVL0wNhm183CPBMkOkWDUMzg3i/b7r+e/fbYfJJgCSY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=KXotOIBBhJ/VbsApO2DbkTESccazSoaxFIEGnzUEAooU41jQAJROidEJn4fkgW9jw
         gItiKnoa5n+PZRj8bMvYQZSED5JPkH1x+FvhERHWHPJoc9cwJAoFYul3wsQHMCSJT4
         n5iu4LChE79wUDUrEL3Vd6zyYiHetnJjEJYllVrE=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id N03wlRWIqe-gmJiJwvg;
        Thu, 01 Nov 2018 19:42:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541090568; bh=YVL0wNhm183CPBMkOkWDUMzg3i/b7r+e/fbYfJJgCSY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=KXotOIBBhJ/VbsApO2DbkTESccazSoaxFIEGnzUEAooU41jQAJROidEJn4fkgW9jw
         gItiKnoa5n+PZRj8bMvYQZSED5JPkH1x+FvhERHWHPJoc9cwJAoFYul3wsQHMCSJT4
         n5iu4LChE79wUDUrEL3Vd6zyYiHetnJjEJYllVrE=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <154106356066.887821.4649178319705436373.stgit@buzz>
 <154106695670.898059.5301435081426064314.stgit@buzz>
 <20181101102405.GE23921@dhcp22.suse.cz>
 <cd2a55be-17f1-5da9-1154-8e291fe958cd@yandex-team.ru>
 <20181101125543.GH23921@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ae51e16b-459c-7d59-6277-b1a197dbf5ff@yandex-team.ru>
Date:   Thu, 1 Nov 2018 19:42:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181101125543.GH23921@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.2018 15:55, Michal Hocko wrote:
> On Thu 01-11-18 13:48:17, Konstantin Khlebnikov wrote:
>>
>>
>> On 01.11.2018 13:24, Michal Hocko wrote:
>>> On Thu 01-11-18 13:09:16, Konstantin Khlebnikov wrote:
>>>> Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.
>>>
>>> I would go on and say that allocations with sizes too large can actually
>>> trigger a warning (once you have posted in the previous version outside
>>> of the changelog area) because that might be interesting to people -
>>> there are deployments to panic on warning and then a warning is much
>>> more important.
>>
>> It seems that warning isn't completely valid.
>>
>>
>> __alloc_pages_slowpath() handles this more gracefully:
>>
>> 	/*
>> 	 * In the slowpath, we sanity check order to avoid ever trying to
>> 	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
>> 	 * be using allocators in order of preference for an area that is
>> 	 * too large.
>> 	 */
>> 	if (order >= MAX_ORDER) {
>> 		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
>> 		return NULL;
>> 	}
>>
>>
>> Fast path is ready for order >= MAX_ORDER
>>
>>
>> Problem is in node_reclaim() which is called earlier than __alloc_pages_slowpath()
>> from surprising place - get_page_from_freelist()
>>
>>
>> Probably node_reclaim() simply needs something like this:
>>
>> 	if (order >= MAX_ORDER)
>> 		return NODE_RECLAIM_NOSCAN;
> 
> Maybe but the point is that triggering this warning is possible. Even if
> the warning is bogus it doesn't really make much sense to even try
> kmalloc if the size is not supported by the allocator.
> 

But __GFP_NOWARN allocation (like in this case) should just fail silently
without warnings regardless of reason because caller can deal with that.

Without __GFP_NOWARN allocator should print standard warning.

Caller anyway must handle NULL\ENOMEM result - this error path
should be used for handling impossible sizes too.
Of course it could check size first, just as optimization.

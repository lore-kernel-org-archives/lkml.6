Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6822081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="O3ZyKGX8";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="O3ZyKGX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6822081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbeKFBj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:39:59 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:50805 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387420AbeKFBj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:39:59 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 69F1F216E2;
        Mon,  5 Nov 2018 19:19:30 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id iK420DPDxh-JU7uh9xa;
        Mon, 05 Nov 2018 19:19:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541434770; bh=TQfSXO8U+en1MDQ+z294/nZpBAKBPQ2+kGBzjSr7hoQ=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=O3ZyKGX8DJU+sFawhwSUxVmuFJXasXq7q3zZ4lKzhZ8EwIi152GagFO7KD/SSZnC+
         Q47dVmMVf6wiThuevALGpAscIDGCyT8a081v4CFi5WZJATlkbjaXa4BzybQ9Wq8Vy5
         hvE4T9E284xmJqBQQ8gHae8AEi8gcrYNe1kQlhIo=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b010:d006::1:3])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id g1HZpLDe3V-JUo0B7fx;
        Mon, 05 Nov 2018 19:19:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541434770; bh=TQfSXO8U+en1MDQ+z294/nZpBAKBPQ2+kGBzjSr7hoQ=;
        h=Subject:To:References:From:Message-ID:Date:In-Reply-To;
        b=O3ZyKGX8DJU+sFawhwSUxVmuFJXasXq7q3zZ4lKzhZ8EwIi152GagFO7KD/SSZnC+
         Q47dVmMVf6wiThuevALGpAscIDGCyT8a081v4CFi5WZJATlkbjaXa4BzybQ9Wq8Vy5
         hvE4T9E284xmJqBQQ8gHae8AEi8gcrYNe1kQlhIo=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
References: <154106356066.887821.4649178319705436373.stgit@buzz>
 <154106695670.898059.5301435081426064314.stgit@buzz>
 <80074d2a-2f8d-a9db-892b-105c0ad7cd47@suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d033db53-129d-c031-db78-ba7f9fed5bf4@yandex-team.ru>
Date:   Mon, 5 Nov 2018 19:19:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <80074d2a-2f8d-a9db-892b-105c0ad7cd47@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.11.2018 16:03, Vlastimil Babka wrote:
> On 11/1/18 11:09 AM, Konstantin Khlebnikov wrote:
>> Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Makes sense regardless of warnings stuff.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But it must be moved below the GFP_KERNEL check!

But kmalloc cannot handle it regardless of GFP.

Ok maybe write something like this

if (size > KMALLOC_MAX_SIZE) {
	if (WARN_ON_ONCE((flags & GFP_KERNEL) != GFP_KERNEL)
		return NULL;
	goto do_vmalloc;
}

or fix that uncertainty right in vmalloc

For now comment in vmalloc declares

  *	Any use of gfp flags outside of GFP_KERNEL should be consulted
  *	with mm people.

=)

> 
>> ---
>>   mm/util.c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 8bf08b5b5760..f5f04fa22814 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -392,6 +392,9 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>>   	gfp_t kmalloc_flags = flags;
>>   	void *ret;
>>   
>> +	if (size > KMALLOC_MAX_SIZE)
>> +		goto fallback;
>> +
>>   	/*
>>   	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
>>   	 * so the given set of flags has to be compatible.
>> @@ -422,6 +425,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>>   	if (ret || size <= PAGE_SIZE)
>>   		return ret;
>>   
>> +fallback:
>>   	return __vmalloc_node_flags_caller(size, node, flags,
>>   			__builtin_return_address(0));
>>   }
>>
> 

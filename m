Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED4EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ADC21738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfAIKIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:08:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729603AbfAIKIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:08:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C169AEEB;
        Wed,  9 Jan 2019 10:08:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Jan 2019 11:08:32 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/vmalloc: Make vmalloc_32_user() align base kernel
 virtual address to SHMLBA
In-Reply-To: <20190108113603.ea664e55869346bcb30c1433@linux-foundation.org>
References: <20190108110944.23591-1-rpenyaev@suse.de>
 <20190108113603.ea664e55869346bcb30c1433@linux-foundation.org>
Message-ID: <c70e01ab1525e4b6778554209bb6edc1@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 20:36, Andrew Morton wrote:
> On Tue,  8 Jan 2019 12:09:44 +0100 Roman Penyaev <rpenyaev@suse.de> 
> wrote:
> 
>> This patch repeats the original one from David S. Miller:
>> 
>>   2dca6999eed5 ("mm, perf_event: Make vmalloc_user() align base kernel 
>> virtual address to SHMLBA")
>> 
>> but for missed vmalloc_32_user() case, which also requires correct
>> alignment of virtual address on kernel side to avoid D-caches
>> aliases.  A bit of copy-paste from original patch to recover in
>> memory of what is all about:
>> 
>>   When a vmalloc'd area is mmap'd into userspace, some kind of
>>   co-ordination is necessary for this to work on platforms with cpu
>>   D-caches which can have aliases.
>> 
>>   Otherwise kernel side writes won't be seen properly in userspace
>>   and vice versa.
>> 
>>   If the kernel side mapping and the user side one have the same
>>   alignment, modulo SHMLBA, this can work as long as VM_SHARED is
>>   shared of VMA and for all current users this is true.  VM_SHARED
>>   will force SHMLBA alignment of the user side mmap on platforms with
>>   D-cache aliasing matters.
> 
> What are the user-visible runtime effects of this change?

In simple words: proper alignment avoids possible difference in data,
seen by different virtual mapings: userspace and kernel in our case.
I.e. userspace reads cache line A, kernel writes to cache line B.
Both cache lines correspond to the same physical memory (thus aliases).

So this should fix data corruption for archs with vivt and vipt caches,
e.g. armv6.  Personally I've never worked with this archs, I just 
spotted
the strange difference in code: for one case we do alignment, for 
another
- not.  I have a strong feeling that David simply missed 
vmalloc_32_user()
case.

> 
> Is a -stable backport needed?

No, I do not think so.  The only one user of vmalloc_32_user() is 
virtual
frame buffer device drivers/video/fbdev/vfb.c, which has in the 
description
"The main use of this frame buffer device is testing and debugging the 
frame
buffer subsystem. Do NOT enable it for normal systems!".

And it seems to me that this vfb.c does not need 32bit addressable pages
(vmalloc_32_user() case), because it is virtual device and should not 
care
about things like dma32 zones, etc.  Probably is better to clean the 
code
and switch vfb.c from vmalloc_32_user() to vmalloc_user() case and wipe 
out
vmalloc_32_user() from vmalloc.c completely.  But I'm not very much sure
that this is worth to do, that's so minor, so we can leave it as is.

--
Roman





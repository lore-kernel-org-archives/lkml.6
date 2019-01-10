Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55509C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F503206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAJKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:08:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:36270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfAJKIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:08:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 908DFACD1;
        Thu, 10 Jan 2019 10:08:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 11:08:52 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/15] mm/vmalloc: introduce new vrealloc() call and
 its subsidiary reach analog
In-Reply-To: <20190109165009.GM6310@bombadil.infradead.org>
References: <20190109164025.24554-1-rpenyaev@suse.de>
 <20190109164025.24554-4-rpenyaev@suse.de>
 <20190109165009.GM6310@bombadil.infradead.org>
Message-ID: <f9ee08f81b3c114b015643e1fca5b7a9@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-09 17:50, Matthew Wilcox wrote:
> On Wed, Jan 09, 2019 at 05:40:13PM +0100, Roman Penyaev wrote:
>> Basically vrealloc() repeats glibc realloc() with only one big 
>> difference:
>> old area is not freed, i.e. caller is responsible for calling vfree() 
>> in
>> case of successfull reallocation.
> 
> Ouch.  Don't call it the same thing when you're providing such 
> different
> semantics.  I agree with you that the new semantics are useful ones,
> I just want it called something else.  Maybe vcopy()?  vclone()?

vclone(). I like vclone().  But Linus does not like this reallocation
under the hood for epoll (where this vrealloc() should have been used),
so seems that won't be needed at all.

> 
>> + *	Do not forget to call vfree() passing old address.  But careful,
>> + *	calling vfree() from interrupt will cause vfree_deferred() call,
>> + *	which in its turn uses freed address as a temporal pointer for a
> 
> "temporary", not temporal.

Ha! Now I got the difference.  Thanks, Mathew :)

> 
>> + *	llist element, i.e. memory will be corrupted.

--
Roman


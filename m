Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C8F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeHaBxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:53:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeHaBxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0714B8163C40;
        Thu, 30 Aug 2018 21:48:52 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C140B2027056;
        Thu, 30 Aug 2018 21:48:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180829075129.GU10223@dhcp22.suse.cz>
 <374c2c5c-cc9b-af03-a800-32f2cf8a3055@redhat.com>
 <20180830072056.GC2656@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9b5c3e96-9dcc-e601-9d15-116aef4bdbfb@redhat.com>
Date:   Thu, 30 Aug 2018 17:48:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180830072056.GC2656@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 21:48:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 21:48:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 03:20 AM, Michal Hocko wrote:
> On Wed 29-08-18 15:58:52, Waiman Long wrote:
>> On 08/29/2018 03:51 AM, Michal Hocko wrote:
>>> On Tue 28-08-18 13:19:40, Waiman Long wrote:
>>>> For negative dentries that are accessed once and never used again, they
>>>> should be removed first before other dentries when shrinker is running.
>>>> This is done by putting negative dentries at the head of the LRU list
>>>> instead at the tail.
>>>>
>>>> A new DCACHE_NEW_NEGATIVE flag is now added to a negative dentry when it
>>>> is initially created. When such a dentry is added to the LRU, it will be
>>>> added to the head so that it will be the first to go when a shrinker is
>>>> running if it is never accessed again (DCACHE_REFERENCED bit not set).
>>>> The flag is cleared after the LRU list addition.
>>> Placing object to the head of the LRU list can be really tricky as Dave
>>> pointed out. I am not familiar with the dentry cache reclaim so my
>>> comparison below might not apply. Let me try anyway.
>>>
>>> Negative dentries sound very similar to MADV_FREE pages from the reclaim
>>> POV. They are primary candidate for reclaim, yet you want to preserve
>>> aging to other easily reclaimable objects (including other MADV_FREE
>>> pages). What we do for those pages is to move them from the anonymous
>>> LRU list to the inactive file LRU list. Now you obviously do not have
>>> anon/file LRUs but something similar to active/inactive LRU lists might
>>> be a reasonably good match. Have easily reclaimable dentries on the
>>> inactive list including negative dentries. If negative entries are
>>> heavily used then they can promote to the active list because there is
>>> no reason to reclaim them soon.
>>>
>>> Just my 2c
>> As mentioned in my reply to Dave, I did considered using a 2 LRU list
>> solution. However, that will add more complexity to the dcache LRU
>> management code than my current approach and probably more potential for
>> slowdown.
> I completely agree with Dave here. This is not easy but trying to sneak
> in something that works for an _artificial_ workload is simply a no go.
> So if it takes to come with a more complex solution to cover more
> general workloads then be it. Someone has to bite a bullet and explore
> that direction. It won't be a simple project but well, if negative
> dentries really matter then it is worth making the reclaim design robust
> and comprehensible rather than adhoc and unpredictable.

OK, I will need to spend more time to think about a better way of doing
that.

Cheers,
Longman


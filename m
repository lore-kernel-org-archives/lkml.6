Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA1CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5379820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5379820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeGRTTB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:19:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeGRTTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:19:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25331402315B;
        Wed, 18 Jul 2018 18:39:50 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36A28111E406;
        Wed, 18 Jul 2018 18:39:48 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
References: <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
 <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard> <20180716090901.GG17280@dhcp22.suse.cz>
 <20180716124115.GA7072@bombadil.infradead.org>
 <20180716164032.94e13f765c5f33c6022eca38@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d37af7a4-b9a9-0928-eed0-10ab818d08c0@redhat.com>
Date:   Wed, 18 Jul 2018 14:39:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180716164032.94e13f765c5f33c6022eca38@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 18 Jul 2018 18:39:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 18 Jul 2018 18:39:50 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 07:40 PM, Andrew Morton wrote:
> On Mon, 16 Jul 2018 05:41:15 -0700 Matthew Wilcox <willy@infradead.org> wrote:
>
>> On Mon, Jul 16, 2018 at 11:09:01AM +0200, Michal Hocko wrote:
>>> On Fri 13-07-18 10:36:14, Dave Chinner wrote:
>>> [...]
>>>> By limiting the number of negative dentries in this case, internal
>>>> slab fragmentation is reduced such that reclaim cost never gets out
>>>> of control. While it appears to "fix" the symptoms, it doesn't
>>>> address the underlying problem. It is a partial solution at best but
>>>> at worst it's another opaque knob that nobody knows how or when to
>>>> tune.
>>> Would it help to put all the negative dentries into its own slab cache?
>> Maybe the dcache should be more sensitive to its own needs.  In __d_alloc,
>> it could check whether there are a high proportion of negative dentries
>> and start recycling some existing negative dentries.
> Well, yes.
>
> The proposed patchset adds all this background reclaiming.  Problem is
> a) that background reclaiming sometimes can't keep up so a synchronous
> direct-reclaim was added on top and b) reclaiming dentries in the
> background will cause non-dentry-allocating tasks to suffer because of
> activity from the dentry-allocating tasks, which is inappropriate.

I have taken out the background reclaiming in the latest v7 patch for
the concern people have on duplicating the reclaim effort. We can always
add it back on later on if we want to.

> I expect a better design is something like
>
> __d_alloc()
> {
> 	...
> 	while (too many dentries)
> 		call the dcache shrinker
> 	...
> }
>
> and that's it.  This way we have a hard upper limit and only the tasks
> which are creating dentries suffer the cost.

Yes, that is certainly one way of doing it.

Cheers,
Longman


Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C652075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C652075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeGRQ4F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:56:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731325AbeGRQ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:56:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50B6A401EF07;
        Wed, 18 Jul 2018 16:17:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55C382026D69;
        Wed, 18 Jul 2018 16:17:24 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin,C)" <wangkai86@huawei.com>
References: <1531330947.3260.13.camel@HansenPartnership.com>
 <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
 <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
 <1531411494.18255.6.camel@HansenPartnership.com>
 <20180712164932.GA3475@bombadil.infradead.org>
 <1531416080.18255.8.camel@HansenPartnership.com>
 <CA+55aFzfQz7c8pcMfLDaRNReNF2HaKJGoWpgB6caQjNAyjg-hA@mail.gmail.com>
 <1531425435.18255.17.camel@HansenPartnership.com>
 <20180713003614.GW2234@dastard> <20180716090901.GG17280@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <caf309f5-2844-6546-e545-6ae56ad7d022@redhat.com>
Date:   Wed, 18 Jul 2018 12:17:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180716090901.GG17280@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 16:17:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 16:17:25 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 05:09 AM, Michal Hocko wrote:
> On Fri 13-07-18 10:36:14, Dave Chinner wrote:
> [...]
>> By limiting the number of negative dentries in this case, internal
>> slab fragmentation is reduced such that reclaim cost never gets out
>> of control. While it appears to "fix" the symptoms, it doesn't
>> address the underlying problem. It is a partial solution at best but
>> at worst it's another opaque knob that nobody knows how or when to
>> tune.
> Would it help to put all the negative dentries into its own slab cache?
>
>> Very few microbenchmarks expose this internal slab fragmentation
>> problem because they either don't run long enough, don't create
>> memory pressure, or don't have access patterns that mix long and
>> short term slab objects together in a way that causes slab
>> fragmentation. Run some cold cache directory traversals (git
>> status?) at the same time you are creating negative dentries so you
>> create pinned partial pages in the slab cache and see how the
>> behaviour changes....
> Agreed! Slab fragmentation is a real problem we are seeing for quite
> some time. We should try to address it rather than paper over it with
> weird knobs.

I am aware that you don't like the limit knob that control how many
negative dentries are allowed as a percentage of total system memory. I
got comments in the past about doing some kind of auto-tuning. How about
consolidating the 2 knobs that I currently have in the patchset into a
single one with 3 possible values, like:

0 - no limiting
1 - set soft limit to "a constant + 4 x max # of positive dentries" and
warn if exceeded
2 - same limit but kill excess negative dentries after use.

Does that kind of knob make more sense to you?

Cheers,
Longman



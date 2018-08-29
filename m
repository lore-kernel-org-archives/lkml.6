Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B27C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0811220647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0811220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeH3ACB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:02:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbeH3ACB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 323C640676C0;
        Wed, 29 Aug 2018 20:03:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88DF52166B41;
        Wed, 29 Aug 2018 20:03:32 +0000 (UTC)
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
To:     paulmck@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180828160150.9a45ee293c92708edb511eab@linux-foundation.org>
 <20180829175405.GA17337@linux.vnet.ibm.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9d5a85f6-29fc-b33e-f0c5-d2b65d0f70de@redhat.com>
Date:   Wed, 29 Aug 2018 16:03:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180829175405.GA17337@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 20:03:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 29 Aug 2018 20:03:33 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 01:54 PM, Paul E. McKenney wrote:
> On Tue, Aug 28, 2018 at 04:01:50PM -0700, Andrew Morton wrote:
>> Another pet peeve ;)
>>
>> On Tue, 28 Aug 2018 13:19:40 -0400 Waiman Long <longman@redhat.com> wrote:
>>
>>>  /**
>>> + * list_lru_add_head: add an element to the lru list's head
>>> + * @list_lru: the lru pointer
>>> + * @item: the item to be added.
>>> + *
>>> + * This is similar to list_lru_add(). The only difference is the location
>>> + * where the new item will be added. The list_lru_add() function will add
>> People often use the term "the foo() function".  I don't know why -
>> just say "foo()"!
> For whatever it is worth...
>
> I tend to use "The foo() function ..." instead of "foo() ..." in order
> to properly capitalize the first word of the sentence.  So I might say
> "The call_rcu() function enqueues an RCU callback." rather than something
> like "call_rcu() enqueues an RCU callback."  Or I might use some other
> trick to keep "call_rcu()" from being the first word of the sentence.
> But if the end of the previous sentence introduced call_rcu(), you
> usually want the next sentence's first use of "call_rcu()" to be very
> early in the sentence, because otherwise the flow will seem choppy.
>
> And no, I have no idea what I would do if I were writing in German,
> where nouns are capitalized, given that function names tend to be used
> as nouns.  Probably I would get yelled at a lot for capitalizing my
> function names.  ;-)
>
> 							Thanx, Paul
>
Yes, doing proper capitalization of the first letter of a sentence is
the main reason I used "The foo() function" in a sentence.

Cheers,
Longman


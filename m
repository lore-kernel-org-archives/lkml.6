Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CE72084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfAVKcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:32:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:41135 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAVKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:32:38 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0MAWajS024510;
        Tue, 22 Jan 2019 19:32:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 22 Jan 2019 19:32:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0MAWZBB024496
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 22 Jan 2019 19:32:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in __do_page_fault
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000f7a28e057653dc6e@google.com>
 <20180920141058.4ed467594761e073606eafe2@linux-foundation.org>
 <CAHRSSEzX5HOUEQ6DgEF76OLGrwS1isWMdtvneBLOEEnwoMxVrA@mail.gmail.com>
 <CAEXW_YSot+3AMQ=jmDRowmqoOmQmujp9r8Dh18KJJN1EDmyHOw@mail.gmail.com>
 <20180921162110.e22d09a9e281d194db3c8359@linux-foundation.org>
 <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
 <CACT4Y+ZTjCGd9XYUCUoqv+AqXrPwX4OqWMC0jFgjNxZRFkNYXw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c56d4d0b-8ecc-059d-69cb-4f3e91f9410c@i-love.sakura.ne.jp>
Date:   Tue, 22 Jan 2019 19:32:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZTjCGd9XYUCUoqv+AqXrPwX4OqWMC0jFgjNxZRFkNYXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/22 19:12, Dmitry Vyukov wrote:
> On Tue, Jan 22, 2019 at 11:02 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2018/09/22 8:21, Andrew Morton wrote:
>>> On Thu, 20 Sep 2018 19:33:15 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>>> On Thu, Sep 20, 2018 at 5:12 PM Todd Kjos <tkjos@google.com> wrote:
>>>>>
>>>>> +Joel Fernandes
>>>>>
>>>>> On Thu, Sep 20, 2018 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>>
>>>>>>
>>>>>> Thanks.  Let's cc the ashmem folks.
>>>>>>
>>>>
>>>> This should be fixed by https://patchwork.kernel.org/patch/10572477/
>>>>
>>>> It has Neil Brown's Reviewed-by but looks like didn't yet appear in
>>>> anyone's tree, could Greg take this patch?
>>>
>>> All is well.  That went into mainline yesterday, with a cc:stable.
>>>
>>
>> This problem was not fixed at all.
> 
> There are at least 2 other open deadlocks involving ashmem:

Yes, they involve ashmem_shrink_scan() => {shmem|vfs}_fallocate() sequence.
This approach tries to eliminate this sequence.

> 
> https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
> https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e
> 
> Does this fix any of these too?

I need checks from ashmem folks whether this approach is possible/correct.
But you can ask syzbot to test this patch before ashmem folks respond.

Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C85DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3695C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfAOQFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:05:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:51022 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfAOQFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:05:17 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gjRDF-00047o-WF; Tue, 15 Jan 2019 19:05:14 +0300
Subject: Re: [PATCH 1/2] fuse: Fix race in fuse_writepage_in_flight()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <154322517208.18737.3297786654135648324.stgit@localhost.localdomain>
 <00b1782a-5c5c-5bc8-7ea9-4f8450679fa1@virtuozzo.com>
 <CAJfpeguokUoCPEnK7Q_Rp9cmyBCMfm51=7TmbbS-QiEy2BxxAQ@mail.gmail.com>
 <a45d54a3-b275-9c95-3c9d-a19566e447dc@virtuozzo.com>
 <CAJfpegvOgA+Wd3vTRqYQP7p_SJ11YCffquP_R=WRHwqYD4b=Ng@mail.gmail.com>
 <b198f480-9ce7-9663-40b1-193a05846c95@virtuozzo.com>
 <CAJfpegvVq3z0CDYb4M4QSCko9Ckw6DOizeHBp=J==Muqn21Yhw@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <66761b4e-dcdb-1a73-ceca-0eebebaaa289@virtuozzo.com>
Date:   Tue, 15 Jan 2019 19:05:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegvVq3z0CDYb4M4QSCko9Ckw6DOizeHBp=J==Muqn21Yhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.2019 19:03, Miklos Szeredi wrote:
> On Tue, Jan 15, 2019 at 4:55 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 15.01.2019 18:37, Miklos Szeredi wrote:
>>> On Thu, Jan 10, 2019 at 12:03 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>
>>>> On 10.01.2019 14:00, Miklos Szeredi wrote:
>>>>> On Thu, Jan 10, 2019 at 11:48 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>>
>>>>>> Hi, Miklos,
>>>>>>
>>>>>> any comments about this?
>>>>>
>>>>> Is there a reproducer?  ISTR that fsx-linux with mmaps enabled was
>>>>> good for stressing the writeback_cache code.
>>>>
>>>> There is no a reproducer, since I found that by eyes during preparation of another patchset.
>>>
>>> That's good.  It would even better to have a reproducer, but it
>>> doesn't look easy...
>>>
>>> Completely redid this and reordered the patchset so this change is
>>> made before the locking changes actually introduce the bug.
>>
>> Hm, I meant that I found this during preparation of the patchset,
>> but not that fi->lock patchset introduces the bug. I don't think
>> the patchset is involved:
>>
>> 1)before we had race, because different locks fc->lock and fiq->waitq.lock
>> are taken in fuse_dev_read() and fuse_writepage_in_flight();
>> 2)after we have the same race, and the locks are fi->lock and fiq->waitq.lock.
> 
> Ah, so the race was introduced earlier, when fiq->waitq.lock was split
> out from fc->lock.

Yeah, and there was another performer, not me :)

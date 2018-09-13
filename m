Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8151C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeIMSxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:53:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:21689 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeIMSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:33 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8DDhi8f036138;
        Thu, 13 Sep 2018 22:43:44 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 13 Sep 2018 22:43:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8DDhcid036077
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 13 Sep 2018 22:43:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in blkdev_reread_part
To:     Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
 <20171105201834.GA8126@zzz.localdomain>
 <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
 <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
 <CACT4Y+Y3M2kB0YWhwD04NkL1-iNHPuDfDDf9BLoPD3GZ6Gg-Yw@mail.gmail.com>
 <201805021930.CBE82399.QFHtOOJFMVFOSL@I-love.SAKURA.ne.jp>
 <CACT4Y+ZaYFt70NrPaib7KFmLe1xQciMnEzWpUDzP6vQJmyctoA@mail.gmail.com>
 <CACT4Y+YVf_68vmx8f570NS3SQiKDeJTuEgEOGjQzwVT4hMDbUw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c6b184f4-5487-b7ba-a332-1437180e7705@i-love.sakura.ne.jp>
Date:   Thu, 13 Sep 2018 22:43:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YVf_68vmx8f570NS3SQiKDeJTuEgEOGjQzwVT4hMDbUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/13 21:58, Dmitry Vyukov wrote:
> On Wed, May 2, 2018 at 1:23 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, May 2, 2018 at 12:30 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> Dmitry Vyukov wrote:
>>>>> syzbot is reporting various bugs which involve /dev/loopX.
>>>>> Two of them
>>>>>
>>>>>   INFO: rcu detected stall in lo_ioctl
>>>>>   https://syzkaller.appspot.com/bug?id=7b49fb610af9cca78c24e9f796f2e8b0d5573997
>>>>>
>>>>>   general protection fault in lo_ioctl (2)
>>>>>   https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
>>>>
>>>> /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
>>>>
>>>> Now there is a repro for this one. I've pushed it to kernel mailing lists:
>>>>
>>>> https://groups.google.com/d/msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ
>>>
>>> OK, thanks. But among loop related reports, this will be a dup of
>>> "INFO: rcu detected stall in blkdev_ioctl" which already has C reproducer.
>>> Should we merge them?
>>
>> Yes, sure, I will take care of it.
> 
> 1. I forgot to take care of it.
> 
> 2. "INFO: rcu detected stall in blkdev_ioctl" was fixed 3 months ago:
> https://syzkaller.appspot.com/bug?id=1f7b710f4110f225aed1f4263ec2b98b8dbd472e
> 
> but this bug still happens up until now:
> https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> 
> So this is a different bug.

I'm not sure what you are talking about.
RCU stall and lockdep warning are obviously different bugs.

Regarding lockdep warning on loop module, we are still waiting for Jens to
come up a better alternative than
http://lkml.kernel.org/r/1527297408-4428-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .
Since no alternative was proposed, I think we should start testing my patch.


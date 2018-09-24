Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C993C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5FD20883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5FD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeIXTHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:07:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49569 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbeIXTHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:07:31 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8OD5OBu058976;
        Mon, 24 Sep 2018 22:05:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 24 Sep 2018 22:05:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8OD5KRp058821
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 24 Sep 2018 22:05:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block/loop: Serialize ioctl operations.
To:     Jan Kara <jack@suse.cz>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        syzbot 
        <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
References: <1537009136-4839-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1af79300-cb04-36e3-a650-168a5942161f@i-love.sakura.ne.jp>
 <20180923220300.GA12589@ming.t460p>
 <ba535251-c206-6242-3e6d-a4ed825c8114@i-love.sakura.ne.jp>
 <20180924123108.GD28775@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c51b5ce0-befb-5b7f-1aab-588d0f14d7b8@i-love.sakura.ne.jp>
Date:   Mon, 24 Sep 2018 22:05:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924123108.GD28775@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/24 21:31, Jan Kara wrote:
> On Mon 24-09-18 19:29:10, Tetsuo Handa wrote:
>> On 2018/09/24 7:03, Ming Lei wrote:
>>> On Sat, Sep 22, 2018 at 09:39:02PM +0900, Tetsuo Handa wrote:
>>>> Hello, Ming Lei.
>>>>
>>>> I'd like to hear your comment on this patch regarding the ordering of
>>>> stopping kernel thread.
>>>>
>>>>   > In order to enforce this strategy, this patch inversed
>>>>   > loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
>>>>   > I don't know whether it breaks something, but I don't have testcases.
>>>>
>>>> Until 3.19, kthread_stop(lo->lo_thread) was called before
>>>> ioctl_by_bdev(bdev, BLKRRPART, 0) is called.
>>>> During 4.0 to 4.3, the loop module was using "kloopd" workqueue.
>>>> But since 4.4, loop_reread_partitions(lo, bdev) is called before
>>>> loop_unprepare_queue(lo) is called. And this patch is trying to change to
>>>> call loop_unprepare_queue() before loop_reread_partitions() is called.
>>>> Is there some reason we need to preserve current ordering?
>>>
>>> IMO, both the two orders are fine, and what matters is that 'lo->lo_state'
>>> is updated before loop_reread_partitions(), then any IO from loop_reread_partitions
>>> will be failed, so it shouldn't be a big deal wrt. the order between
>>> loop_reread_partitions() and loop_unprepare_queue().
>>
>> OK. Thank you. Here is v4 patch (only changelog was updated).
>> Andrew, can we test this patch in the -mm tree?
>>
>> From 2278250ac8c5b912f7eb7af55e36ed40e2f7116b Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Mon, 24 Sep 2018 18:58:37 +0900
>> Subject: [PATCH v4] block/loop: Serialize ioctl operations.
>>
>> syzbot is reporting NULL pointer dereference [1] which is caused by
>> race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
>> ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
>> loop devices without holding corresponding locks.
>>
>> syzbot is also reporting circular locking dependency between bdev->bd_mutex
>> and lo->lo_ctl_mutex [2] which is caused by calling blkdev_reread_part()
>> with lock held.
> 
> Thanks for looking into the loop crashes Tetsuo. I was looking into the
> loop code and trying to understand how your patch fixes them but I've
> failed. Can you please elaborate a bit on how exactly LOOP_CLR_FD and
> LOOP_SET_FD race to hit NULL pointer dereference? I don't really see the
> code traversing other loop devices as you mention in your changelog so I'm
> probably missing something. Thanks.
> 
> 								Honza
> 

That is explained in a discussion for [1] at
https://groups.google.com/forum/#!msg/syzkaller-bugs/c8KUcTAzTvA/3o_7g6-tAwAJ .
In the current code, the location of dangerous traversal is in loop_validate_file().

Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C773FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEFA2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbeL1NfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 08:35:15 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:46182 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbeL1NfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 08:35:15 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBSDYH3M067251;
        Fri, 28 Dec 2018 22:34:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Fri, 28 Dec 2018 22:34:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBSDYHF2067245
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 28 Dec 2018 22:34:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
 <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
 <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e8a23623-feaf-7730-5492-b329cb0daa21@i-love.sakura.ne.jp>
Date:   Fri, 28 Dec 2018 22:34:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20180806100928.x7anab3c3y5q4ssa@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/06 19:09, Jan Kara wrote:
> On Tue 31-07-18 00:07:22, Tetsuo Handa wrote:
>> On 2018/07/21 5:06, Andrew Morton wrote:
>>> On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>
>>>>>
>>>>> This report is stalling after mount() completed and process used remap_file_pages().
>>>>> I think that we might need to use debug printk(). But I don't know what to examine.
>>>>>
>>>>
>>>> Andrew, can you pick up this debug printk() patch?
>>>> I guess we can get the result within one week.
>>>
>>> Sure, let's toss it in -next for a while.
>>>
>>>> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
>>>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>> Date: Fri, 20 Jul 2018 19:29:06 +0900
>>>> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
>>>>
>>>> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
>>>> __getblk_gfp() line in the backtrace. Since there is a comment block that
>>>> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
>>>> attempt from grow_dev_page() is failing, let's start from checking whether
>>>> syzbot is hitting that case. This change will be removed after the bug is
>>>> fixed.
>>>
>>> I'm not sure that grow_dev_page() is hanging.  It has often been
>>> suspected, but always is proven innocent.  Lets see.
>>
>> syzbot reproduced this problem ( https://syzkaller.appspot.com/text?tag=CrashLog&x=11f2fc44400000 ) .
>> It says that grow_dev_page() is returning 1 but __find_get_block() is failing forever. Any idea?
> 
> Looks like some kind of a race where device block size gets changed while
> getblk() runs (and creates buffers for underlying page). I don't have time
> to nail it down at this moment can have a look into it later unless someone
> beats me to it.

I feel that the frequency of hitting this problem was decreased
by merging loop module's ioctl() serialization patches. But this
problem is still there, and syzbot got a new line in
https://syzkaller.appspot.com/text?tag=CrashLog&x=177f889f400000 .

  [  615.881781] __loop_clr_fd: partition scan of loop5 failed (rc=-22)
  [  619.059920] syz-executor4(2193): getblk(): executed=cd bh_count=0 bh_state=29
  [  622.069808] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
  [  625.080013] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0
  [  628.089900] syz-executor4(2193): getblk(): executed=9 bh_count=0 bh_state=0

I guess that loop module is somehow related to this problem.

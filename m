Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B1DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E920893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7E920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeG3Qnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:43:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26850 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3Qnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:43:53 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6UF7RWt092649;
        Tue, 31 Jul 2018 00:07:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 31 Jul 2018 00:07:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6UF7Qbx092642
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 31 Jul 2018 00:07:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in generic_file_write_iter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jack@suse.cz, jlayton@redhat.com, linux-kernel@vger.kernel.org,
        mawilcox@microsoft.com, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000009ce88d05714242a8@google.com>
 <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
 <9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp>
 <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a2df1f24-f649-f5d8-0b2d-66d45b6cb61f@i-love.sakura.ne.jp>
Date:   Tue, 31 Jul 2018 00:07:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720130602.f3d6dc4c943558875a36cb52@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/21 5:06, Andrew Morton wrote:
> On Fri, 20 Jul 2018 19:36:23 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> 
>>>
>>> This report is stalling after mount() completed and process used remap_file_pages().
>>> I think that we might need to use debug printk(). But I don't know what to examine.
>>>
>>
>> Andrew, can you pick up this debug printk() patch?
>> I guess we can get the result within one week.
> 
> Sure, let's toss it in -next for a while.
> 
>> >From 8f55e00b21fefffbc6abd9085ac503c52a302464 Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Fri, 20 Jul 2018 19:29:06 +0900
>> Subject: [PATCH] fs/buffer.c: add debug print for __getblk_gfp() stall problem
>>
>> Among syzbot's unresolved hung task reports, 18 out of 65 reports contain
>> __getblk_gfp() line in the backtrace. Since there is a comment block that
>> says that __getblk_gfp() will lock up the machine if try_to_free_buffers()
>> attempt from grow_dev_page() is failing, let's start from checking whether
>> syzbot is hitting that case. This change will be removed after the bug is
>> fixed.
> 
> I'm not sure that grow_dev_page() is hanging.  It has often been
> suspected, but always is proven innocent.  Lets see.

syzbot reproduced this problem ( https://syzkaller.appspot.com/text?tag=CrashLog&x=11f2fc44400000 ) .
It says that grow_dev_page() is returning 1 but __find_get_block() is failing forever. Any idea?


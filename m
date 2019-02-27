Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7301D20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfB0KVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:21:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60791 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0KVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:21:43 -0500
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1RALYGS026023;
        Wed, 27 Feb 2019 19:21:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Wed, 27 Feb 2019 19:21:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1RALT3v025979
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 27 Feb 2019 19:21:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kay Sievers <kay@vrfy.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
References: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190220150753.GB17103@kroah.com>
 <CAKdAkRSjZB5MJ=vPwDTUouTTYF5Gu1d7iWjzdOzd+w5HJ=1CFQ@mail.gmail.com>
 <bd8cc4bb-4c58-dbad-a012-3193a41dc0ca@i-love.sakura.ne.jp>
 <20190221110923.GA23579@kroah.com>
 <63257aa5-d99d-89bf-ef1d-abd20b3a07fb@i-love.sakura.ne.jp>
Message-ID: <853954ab-b457-6e65-0c17-4693c899cf37@i-love.sakura.ne.jp>
Date:   Wed, 27 Feb 2019 19:21:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <63257aa5-d99d-89bf-ef1d-abd20b3a07fb@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/21 21:31, Tetsuo Handa wrote:
> On 2019/02/21 20:09, Greg Kroah-Hartman wrote:
>>>> This is the correct fix (in spirit, we may argue about whether it is
>>>> valid to call the flag "state_add_uevent_sent" now or we should or
>>>> collapse both it and "state_add_uevent_sent" into
>>>> "need_send_remove_uevent"). Other subsystems are in their own right to
>>>> not expect to get uvent callbacks past the point of calling
>>>> device_del() as they are tearing down parts of the device environment
>>>> (even though the device structure may stay in memory for a while).
>>>>
>>>> Thanks.
>>>
>>> Which subsystems benefit from commit 0f4dafc0563c6c49 ("Kobject: auto-cleanup
>>> on final unref") ? If there is no such subsystem, it will be better to remove
>>> state_add_uevent_sent and state_remove_uevent_sent logic.
>>
>> You are asking me about a patch from 2007.  I have no idea, try removing
>> it and see what happens :)
> 
> Waiting for response from Kay Sievers who wrote that patch. ;-)
> 

No response from Kay Sievers...

Well, can we apply this patch for now because making sure that
"state_remove_uevent_sent won't be attempted twice" should be safer for
stable kernels than "removing the state_{add,remove}_uevent_sent logic" ?

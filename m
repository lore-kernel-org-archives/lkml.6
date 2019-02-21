Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B70AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8062085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBUMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:31:18 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:46604 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBUMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:31:18 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1LCV7L7080533;
        Thu, 21 Feb 2019 21:31:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Thu, 21 Feb 2019 21:31:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1LCV2xT080400
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 21 Feb 2019 21:31:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <63257aa5-d99d-89bf-ef1d-abd20b3a07fb@i-love.sakura.ne.jp>
Date:   Thu, 21 Feb 2019 21:31:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190221110923.GA23579@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/21 20:09, Greg Kroah-Hartman wrote:
> On Thu, Feb 21, 2019 at 07:40:20PM +0900, Tetsuo Handa wrote:
>> On 2019/02/21 4:52, Dmitry Torokhov wrote:
>>> On Wed, Feb 20, 2019 at 7:07 AM Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>> But I would argue that this is not ok, as the remove uevent did NOT get
>>>> sent, and you are saying it did.
>>>
>>> "It is the thought that counts" here. The code was added to catch
>>> cases where nobody even attempted to send "remove" uevents. It does
>>> not guarantee that an event will ultimately be sent (we are at the
>>> point of no return as far as the rest of the kernel is concerned,
>>> there are no repeats or do-overs).
>>>
>>>>
>>>> What memory is being used-after-free here when we fail to properly send
>>>> a uevent?  Shouldn't we fix up that problem correctly?
>>
>> It is explained at https://lkml.kernel.org/r/20190219185558.GA210481@dtor-ws .
> 
> I agree with Dmitry here, it's not the input layer's job to do this.
> 
> But that didn't answer my question, what object is getting reused here?

"struct input_dev"->{name,phys} fields are accessed after they are kfree()d,
for uinput_destroy_device() sometimes kfree()s dev->{name,phys} at
uinput_destroy_device() before dev_uevent() is triggered by dropping the
refcount to 0. syzbot is hitting this bug from cdev_put() path when closing
a character file which drops the refcount to 0.

Therefore, I thought that we must not assume that kobject_uevent() won't be
called after uinput_destroy_device() called kfree(). And I wrote a patch
that explicitly sets "struct input_dev"->{name,phys} to NULL so that
input_dev_uevent() won't crash, for the timing of triggering last
input_put_device() is uncontrollable. But Dmitry Torokhov pointed out that
we should fix kobject side because input subsystem is not expecting that
kobject_uevent() is called after uinput_destroy_device().

> The input device is now dead at that point in time, no one else can
> touch it, but you are saying someone did, right?   Who is that someone?
> 
>>> This is the correct fix (in spirit, we may argue about whether it is
>>> valid to call the flag "state_add_uevent_sent" now or we should or
>>> collapse both it and "state_add_uevent_sent" into
>>> "need_send_remove_uevent"). Other subsystems are in their own right to
>>> not expect to get uvent callbacks past the point of calling
>>> device_del() as they are tearing down parts of the device environment
>>> (even though the device structure may stay in memory for a while).
>>>
>>> Thanks.
>>
>> Which subsystems benefit from commit 0f4dafc0563c6c49 ("Kobject: auto-cleanup
>> on final unref") ? If there is no such subsystem, it will be better to remove
>> state_add_uevent_sent and state_remove_uevent_sent logic.
> 
> You are asking me about a patch from 2007.  I have no idea, try removing
> it and see what happens :)

Waiting for response from Kay Sievers who wrote that patch. ;-)


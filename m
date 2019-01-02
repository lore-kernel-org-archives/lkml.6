Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC1218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 09:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfABJ74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 04:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbfABJ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 04:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70CE12D7EF;
        Wed,  2 Jan 2019 09:59:55 +0000 (UTC)
Received: from alatyr.usersys.redhat.com (unknown [10.43.17.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1535D9CC;
        Wed,  2 Jan 2019 09:59:54 +0000 (UTC)
Subject: Re: [PATCH v2] kobject: add kernel/uevent_features sysfs file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, msekleta@redhat.com
References: <20181207114607.26981-1-prajnoha@redhat.com>
 <20181207120123.GB15336@kroah.com>
 <e0072bf2-c89e-df9c-8764-7505a71ab36e@redhat.com>
 <20181219092441.GB7356@kroah.com>
From:   Peter Rajnoha <prajnoha@redhat.com>
Message-ID: <c0025f62-8b69-de02-ea62-b756a1ffc961@redhat.com>
Date:   Wed, 2 Jan 2019 10:59:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181219092441.GB7356@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 02 Jan 2019 09:59:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 10:24 AM, Greg KH wrote:
> On Fri, Dec 07, 2018 at 01:28:52PM +0100, Peter Rajnoha wrote:
>> On 12/7/18 1:01 PM, Greg KH wrote:
>>> On Fri, Dec 07, 2018 at 12:46:07PM +0100, Peter Rajnoha wrote:
>>>> This patch adds /sys/kernel/uevent_features file which currently lists
>>>> 'synthargs' string to denote that the kernel is able to recognize the
>>>> extended synthetic uevent arguments. Userspace can easily check for
>>>> the feature then.
>>>
>>> So this is just to try to have userspace detect what type of feature the
>>> kernel has?  Why can't you just go off of the other sysfs file itself?
>>> You shouldn't need a "this is a feature list" for the kernel, otherwise
>>> we would be on a huge slippery slope trying to document everything.
>>>
>>> Who is going to use this thing?  And what else would go into it?
>>>
>>> Isn't there some other way you can detect this from userspace (like
>>> writing to the file and it fails?)
>>>
>>
>> Yes, it's for userspace to be sure that uevent interface has certain
>> features available that it can use.
> 
> That is nice, but no, that is not how we export to userspace what
> "features" a specific kernel has, sorry.
> 

I've already seen existing "features" files already in /sys:

  /sys/kernel/cgroup/features
  /sys/fs/ext4/features
  /sys/kernel/debug/sched_features	
  ...

(Though the one under "debug" is a bit different type of coffee, I have
to admit.)

>> For now, it's just that "synthetic uevent arguments" that is the
>> extension of the original uevent interface. That applies to both input
>> (writing to /sys/.../uevent file) and output (related extra variables
>> that appear in generated uevents).
>>
>> The obvious user of this is going to be systemd/udev that will add extra
>> variables to identify various synthetic uevents it produces (coming as
>> result of the WATCH udev rule, coming from the udevadm trigger call and
>> other specific uses where it needs to generate synthetic uevents). Other
>> users I know of involve storage handling tools which need to generate
>> these synthetic uevents whenever a change happens and it needs to
>> synchronize with udevd processing (e.g. waiting on refresh to get
>> reflected in udev database).
>>
>> I understand that there is an argument that we can just use kernel
>> version check, but this is not acceptable for all unfortunately (see
>> also https://github.com/systemd/systemd/pull/7294#issuecomment-343491015).
> 
> Kernel version checks are horrible as well, I know.
> 
>> The issue with checking the return code after writing to /sys/.../uevent
>> is that it doesn't work with older kernel releases because there, it
>> always returned success, no matter if the input string was correct or
>> not or whether the arguments were recognized (unfortunately, this was
>> like that from beginning, it seems). Even though, I've fixed this return
>> code with df44b479 recently, but still, there are possible older
>> releases out there... And still, there might be new variables introduced
>> in the future that don't necessarily need to be direct result of writing
>> to /sys/.../uevent file.
> 
> We do not add things to the kernel for "maybe sometime in the future
> something else might be added", sorry.  We deal with what we have now.
> 
> And right now the kernel is fine, it is userspace that is having a
> problem with this.  Why can't you just try to trigger an event from
> userspace and if it does not come back, then you know that kernel does
> not have that feature?

Because in that case, there's an issue arising of how much should we
wait for the uevent to appear back in userspace after triggering it.
There's no right timeout.

Of course, we wouldn't need to think about all of this if the "write" to
the "uevent" file properly returned error code, but unfortunately it
didn't and that was the bug that was sitting there from day one, it
seems (...fixed now, but still there are those older kernel versions out
there).

-- 
Peter

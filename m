Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B85DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557E320863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548948007;
	bh=2F71SOsPq5ysea7mkVOHK06VKcHb1nQ49g/MhmFoBXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zgAsgGqDgpnK5UoW1yprF2rBxqVnLN42/eEWqKp9E10lPbisAF0JaDfb8oDbMMZz1
	 GoOI3/eONK5fNxdXYg9SqxX72wtE7s62mhDjJlJ1+v4ChFFvYKlYKpfCHG7sYxQNyw
	 iNS9lv48iEi12oNytUqah+4rBfV35yhe00HhbDyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfAaPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfAaPUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:20:01 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B0720863;
        Thu, 31 Jan 2019 15:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548948000;
        bh=2F71SOsPq5ysea7mkVOHK06VKcHb1nQ49g/MhmFoBXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHKo7edCQyXIYyf+zjTbG5kokZg1IcQ55IcDFLtb6TPV+xDYJYW737lzLo/Ed0Qwy
         wX6db5SCMESjtIYy0GhqvOJZliGmswFJZmSYVgZ6hSuCqHvURn5R+WLz+LgoQeg6zS
         fxMUWO2vJSH78QyhVKReL2XX+/tkXKa+01aTqw6Y=
Date:   Thu, 31 Jan 2019 10:19:58 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kimbrownkd <kimbrownkd@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add mutex lock to channel show
 functions
Message-ID: <20190131151958.GT3973@sasha-vm>
References: <20190122020759.GA4054@ubu-Virtual-Machine>
 <PU1P153MB0169EB8CFC0A69407A8AE2C2BF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190122064246.GA28613@ubu-Virtual-Machine>
 <PU1P153MB01696D28CDDC098307EBD5AFBF980@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190128195845.GA3723@ubu-Virtual-Machine>
 <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB01699B96311157EA9DF515E6BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 07:20:28PM +0000, Dexuan Cui wrote:
>> From: Kimberly Brown <kimbrownkd@gmail.com>
>> > ...
>> > But as you pointed, at least for sub-channels, channel->ringbuffer_page
>> > can indeed disappear in vmbus_close() -> ... -> vmbus_free_ring(), and
>> > the "attribute->show()" could crash when the race happens.
>> > Adding channel_mutex here seems to be able to fix the race for
>> > sub-channels, as the same channel_mutex is used in
>> vmbus_disconnect_ring().
>> >
>> > For a primary channel, vmbus_close() -> vmbus_free_ring() can still
>> > free channel->ringbuffer_page without notifying the "attribute->show()".
>> > We may also need to acquire/release the channel_mutex in vmbus_close()?
>> >
>> > > Actually, there should be checks that "chan" is not null and that
>> > > "chan->state" is CHANNEL_OPENED_STATE within the locked section. I'll
>> > > need to fix that.
>> > I suppose "chan" can not be NULL here (see the above).
>> >
>> > Checking "chan->state" may not help to completely fix the race, because
>> > there is no locking/synchronization code in
>> > vmbus_close_internal() when we test and change "channel->state".
>> >
>>
>> The calls to vmbus_close_internal() for the subchannels and the primary
>> channel are protected with channel_mutex in vmbus_disconnect_ring().
>> This prevents "channel->state" from changing while "attribute->show()" is
>> running.
>Ah, I think you're right.
>
>> > I guess we may need to check if channel->ringbuffer_page is NULL in
>> > the "attribute->show()".
>> >
>>
>> For the primary channel, vmbus_free_ring() is called after the
>> return from vmbus_disconnect_ring(). Therefore, the primary channel's
>> state is changed before "channel->ringbuffer_page" is set to NULL.
>> Checking the channel state should be sufficient to prevent the ring
>> buffers from being freed while "attribute->show()" is running. The
>> ring buffers can't be freed until the channel's state is changed, and
>> the channel state change is protected by the mutex.
>I think you're right (I noticed in a previous mail you mentioned you would
>improve your patch to check "chan->state" with the mutax held).
>
>> I think checking that "channel->ringbuffer_page" is not NULL would
>> also work, but, as you stated, we would need to aquire/release
>> channel_mutex in vmbus_close().
>Then it looks unnecessary to check "channel->ringbuffer_page".
>
>> > PS, to prove that a race condition does exist and can really cause a panic or
>> > something, I usually add some msleep() delays in different paths so that I
>> > can reproduce the crash every time I take a special action, e.g. when I read
>> > the sysfs files of a NIC, I try to remove hv_netvsc driver. This way, I can prove
>> > a patch can indeed help, at least it can fix the crash which would happen
>> > without the patch. :-)
>> >
>>
>> Thanks! I was able to free the ring buffers while "attribute->show()"
>> was running, which caused a null pointer dereference bug. As expected,
>> the mutex lock fixed it.
>Awesome!

I've queued this one for hyper-fixes, thanks all!

--
Thanks,
Sasha

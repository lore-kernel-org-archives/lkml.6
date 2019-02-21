Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CC520855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550747369;
	bh=T/Fxq8JgLMzaZZcyu2NVvfvL8uNg5uJesod3goZj3Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yMklzEOmqMi1B6OupM2LYcddbIpGWZV988bwOBx6p5xLmvs4H7ffTb332JxwPiIY1
	 PXbnFiHsnYf8ncoBcLCyoWF+GjIM1hCUeZKIE7ZH5pn9PHWzlhcY2QwDZzSZJEl3Nv
	 OZsBZminJGTSj/2ieEMp5XBTOyJmsXCTs+ibP70k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfBULJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfBULJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:09:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DC020855;
        Thu, 21 Feb 2019 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550747367;
        bh=T/Fxq8JgLMzaZZcyu2NVvfvL8uNg5uJesod3goZj3Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTNy4J4YCgC21ciK0yd7A2IT4RRzndr1UJUMtAMJW9GGLZ/E4sjLiMmFcNrqXX/vk
         7ZH+0/+RI6LwgRmnjtI6cE+0pd/lNqT56fTODLx7WkgPUHktBBuTJJMO5SbCqxgkvp
         fhTMuRco2QyoOW11sH392R0ONI9R3EXu2Bb+kNGM=
Date:   Thu, 21 Feb 2019 12:09:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kobject: Don't trigger kobject_uevent(KOBJ_REMOVE) twice.
Message-ID: <20190221110923.GA23579@kroah.com>
References: <1550669914-10704-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190220150753.GB17103@kroah.com>
 <CAKdAkRSjZB5MJ=vPwDTUouTTYF5Gu1d7iWjzdOzd+w5HJ=1CFQ@mail.gmail.com>
 <bd8cc4bb-4c58-dbad-a012-3193a41dc0ca@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8cc4bb-4c58-dbad-a012-3193a41dc0ca@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 07:40:20PM +0900, Tetsuo Handa wrote:
> On 2019/02/21 4:52, Dmitry Torokhov wrote:
> > On Wed, Feb 20, 2019 at 7:07 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> But I would argue that this is not ok, as the remove uevent did NOT get
> >> sent, and you are saying it did.
> > 
> > "It is the thought that counts" here. The code was added to catch
> > cases where nobody even attempted to send "remove" uevents. It does
> > not guarantee that an event will ultimately be sent (we are at the
> > point of no return as far as the rest of the kernel is concerned,
> > there are no repeats or do-overs).
> > 
> >>
> >> What memory is being used-after-free here when we fail to properly send
> >> a uevent?  Shouldn't we fix up that problem correctly?
> 
> It is explained at https://lkml.kernel.org/r/20190219185558.GA210481@dtor-ws .

I agree with Dmitry here, it's not the input layer's job to do this.

But that didn't answer my question, what object is getting reused here?
The input device is now dead at that point in time, no one else can
touch it, but you are saying someone did, right?   Who is that someone?

> > This is the correct fix (in spirit, we may argue about whether it is
> > valid to call the flag "state_add_uevent_sent" now or we should or
> > collapse both it and "state_add_uevent_sent" into
> > "need_send_remove_uevent"). Other subsystems are in their own right to
> > not expect to get uvent callbacks past the point of calling
> > device_del() as they are tearing down parts of the device environment
> > (even though the device structure may stay in memory for a while).
> > 
> > Thanks.
> 
> Which subsystems benefit from commit 0f4dafc0563c6c49 ("Kobject: auto-cleanup
> on final unref") ? If there is no such subsystem, it will be better to remove
> state_add_uevent_sent and state_remove_uevent_sent logic.

You are asking me about a patch from 2007.  I have no idea, try removing
it and see what happens :)

greg k-h

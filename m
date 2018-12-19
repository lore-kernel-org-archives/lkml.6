Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA33C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0C2217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545211486;
	bh=aZiGdUsqPPZFA+9/mYQ/0U7DQlUklJjwDK968EIY0Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lZeXjTI3L55HPV0O3W2fn9HaHGc0nL7X15AT3JmrbtsDfvHW0kYNPkgLIRk0k9bnw
	 PIIjiD9DY/jK9FC82Ot8Hn+hrkhpQhdhTB3fe6AwhkiwJ37co5OsDWnCLDquIZhVCf
	 9I3ibOQ6mgNxN9iPwmMRkQH+BvfjOLUvrR+HbvGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeLSJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbeLSJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:24:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8732217D9;
        Wed, 19 Dec 2018 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545211484;
        bh=aZiGdUsqPPZFA+9/mYQ/0U7DQlUklJjwDK968EIY0Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Bg0SYm0U6poxwDkoqtvJ6Z+D7pc4NRDSXdSh3H1q4/632Cw532F9oPzwNe231Rhe
         aB+1wC6Mf6Cup72GepbYYWDlHcDEi2ivDAJFKrJBvGO5hiUkp5OUzpiHbgQFd95+sH
         DH+gzjogiDKIet6sLlXuOp3s9QTUNvCAcHlHWz8A=
Date:   Wed, 19 Dec 2018 10:24:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rajnoha <prajnoha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, msekleta@redhat.com
Subject: Re: [PATCH v2] kobject: add kernel/uevent_features sysfs file
Message-ID: <20181219092441.GB7356@kroah.com>
References: <20181207114607.26981-1-prajnoha@redhat.com>
 <20181207120123.GB15336@kroah.com>
 <e0072bf2-c89e-df9c-8764-7505a71ab36e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0072bf2-c89e-df9c-8764-7505a71ab36e@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:28:52PM +0100, Peter Rajnoha wrote:
> On 12/7/18 1:01 PM, Greg KH wrote:
> > On Fri, Dec 07, 2018 at 12:46:07PM +0100, Peter Rajnoha wrote:
> >> This patch adds /sys/kernel/uevent_features file which currently lists
> >> 'synthargs' string to denote that the kernel is able to recognize the
> >> extended synthetic uevent arguments. Userspace can easily check for
> >> the feature then.
> > 
> > So this is just to try to have userspace detect what type of feature the
> > kernel has?  Why can't you just go off of the other sysfs file itself?
> > You shouldn't need a "this is a feature list" for the kernel, otherwise
> > we would be on a huge slippery slope trying to document everything.
> > 
> > Who is going to use this thing?  And what else would go into it?
> > 
> > Isn't there some other way you can detect this from userspace (like
> > writing to the file and it fails?)
> > 
> 
> Yes, it's for userspace to be sure that uevent interface has certain
> features available that it can use.

That is nice, but no, that is not how we export to userspace what
"features" a specific kernel has, sorry.

> For now, it's just that "synthetic uevent arguments" that is the
> extension of the original uevent interface. That applies to both input
> (writing to /sys/.../uevent file) and output (related extra variables
> that appear in generated uevents).
> 
> The obvious user of this is going to be systemd/udev that will add extra
> variables to identify various synthetic uevents it produces (coming as
> result of the WATCH udev rule, coming from the udevadm trigger call and
> other specific uses where it needs to generate synthetic uevents). Other
> users I know of involve storage handling tools which need to generate
> these synthetic uevents whenever a change happens and it needs to
> synchronize with udevd processing (e.g. waiting on refresh to get
> reflected in udev database).
> 
> I understand that there is an argument that we can just use kernel
> version check, but this is not acceptable for all unfortunately (see
> also https://github.com/systemd/systemd/pull/7294#issuecomment-343491015).

Kernel version checks are horrible as well, I know.

> The issue with checking the return code after writing to /sys/.../uevent
> is that it doesn't work with older kernel releases because there, it
> always returned success, no matter if the input string was correct or
> not or whether the arguments were recognized (unfortunately, this was
> like that from beginning, it seems). Even though, I've fixed this return
> code with df44b479 recently, but still, there are possible older
> releases out there... And still, there might be new variables introduced
> in the future that don't necessarily need to be direct result of writing
> to /sys/.../uevent file.

We do not add things to the kernel for "maybe sometime in the future
something else might be added", sorry.  We deal with what we have now.

And right now the kernel is fine, it is userspace that is having a
problem with this.  Why can't you just try to trigger an event from
userspace and if it does not come back, then you know that kernel does
not have that feature?

thanks,
greg k-h

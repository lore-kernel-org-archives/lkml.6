Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C67C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB3920989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544040110;
	bh=NagzmOYbcSserz4ybU0d3orW/TZcWbUDcPfyZoNlHc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GnaaSHXCxhrmVKRIVIhgw23yGMc+H5qfRs0Ew9TEQtXQBp7U6zcZ5ZYHVN/dDns7w
	 F/NmMzmxZ0lsSGidaBHlok+xzOJdCDrFbkUna1uhMAHnS11IoDWz7tdV4vhfhUWJCZ
	 imKDK7aThbMNP9F6IEFZ1T5q/SgTpkTBRU7YPW/E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB3920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeLEUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:01:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLEUBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:01:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2BF20850;
        Wed,  5 Dec 2018 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544040108;
        bh=NagzmOYbcSserz4ybU0d3orW/TZcWbUDcPfyZoNlHc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq6rDRYHDg7QyWBwy0fu7AcBB5+lHl7lrgurPSxD1T3bt2RdA3Ezb54mCGAfmXKVW
         sO9qad1V1yxbFfD2SqbtVk5nKzJHhEATOrydnYWDdBhyZXHKEIh3/8VA87YuhukCNS
         xWhTzlY7dOSkzUJ5RL+Ymer35ctwsjS5vHejFf6o=
Date:   Wed, 5 Dec 2018 21:01:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kilobyte@angband.pl,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, arve@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: implement binderfs
Message-ID: <20181205200145.GA25230@kroah.com>
References: <20181204131239.15158-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204131239.15158-1-christian@brauner.io>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 02:12:39PM +0100, Christian Brauner wrote:
> As discussed at Linux Plumbers Conference 2018 in Vancouver [1] this is the
> implementation of binderfs. If you want to skip reading and just see how it
> works, please go to [2].

First off, thanks for doing this so quickly.  I think the overall idea
and implementation is great, I just have some minor issues with the user
api:

> /* binder-control */
> Each new binderfs instance comes with a binder-control device. No other
> devices will be present at first. The binder-control device can be used to
> dynamically allocate binder devices. All requests operate on the binderfs
> mount the binder-control device resides in:
> - BINDER_CTL_ADD
>   Allocate a new binder device.
> Assuming a new instance of binderfs has been mounted at /dev/binderfs via
> mount -t binderfs binderfs /dev/binderfs. Then a request to create a new
> binder device can be made via:
> 
> struct binderfs_device device = {0};
> int fd = open("/dev/binderfs/binder-control", O_RDWR);
> ioctl(fd, BINDER_CTL_ADD, &device);
> 
> The struct binderfs_device will be used to return the major and minor
> number, as well as the index used as the new name for the device.
> Binderfs devices can simply be removed via unlink().

I think you should provide a name in the BINDER_CTL_ADD command.  That
way you can easily emulate the existing binder queues, and it saves you
a create/rename sequence that you will be forced to do otherwise.  Why
not do it just in a single command?

That way also you don't need to care about the major/minor number at
all.  Userspace should never need to worry about that, use a name,
that's the best thing.  Also, it allows you to drop the use of the idr,
making the kernel code simpler overall.

> /* Implementation details */
> - When binderfs is registered as a new filesystem it will dynamically
>   allocate a new major number. The allocated major number will be returned
>   in struct binderfs_device when a new binder device is allocated.

Why does userspace care about major/minor numbers at all?  You should
just be able to deal with the binder "names", that's all that userspace
uses normally as you are not calling mknod() yourself.

>   Minor numbers that have been given out are tracked in a global idr struct
>   that is capped at BINDERFS_MAX_MINOR. The minor number tracker is
>   protected by a global mutex. This is the only point of contention between
>   binderfs mounts.

I doubt this will be any real contention given that setting up / tearing
down binder mounts is going to be rare, right?  Well, hopefully, who
knows with some container systems...

> - The naming scheme for binder devices is binder%d. Each binderfs mount
>   starts numbering of new binder devices at 0 up to n. The indeces used in
>   constructing the name are tracked in a struct idr that is per-binderfs
>   super block.

Again, let userspace pick the name, as you will have to rename it anyway
to get userspace to work properly with it.

I'll stop repeating myself now :)

thanks,

greg k-h

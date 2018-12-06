Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2867520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544105049;
	bh=SGerwtpmtZiO+5sxx3VaYA63hAK1V/lMic2Vc1uwm8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oPCwcP4q7LugqYmGKrKP+I15a9D9gwUkhNqyy4EQsYL7tYLc+NL5tHeBjvcChLQ11
	 tvg8st+n2xC457hSecFlKoDBIm4fhO3SBs9/dyU2BD6yG1RQRmFQisYGiwmofj3rjx
	 q1qDWF6xhXAJZluyLDKZfAxGZ1CDBQVqeQE+24cQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2867520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeLFOEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLFOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:04:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444D220672;
        Thu,  6 Dec 2018 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544105045;
        bh=SGerwtpmtZiO+5sxx3VaYA63hAK1V/lMic2Vc1uwm8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhI4TJH2TFtX2UQM1OtG+YPWxesoMGaV8oI8V3+lQn01v3eldlFK8vxQfDdAzXKF1
         nT0qRtEwEBwR21zvE8j+wcQTrc4kN5WCjI5uT6ilo7WeedbLKWMDhPt+FoEvcVjTYq
         TVGmfKWzAltlM4G0Oj9G/fPJ56QnRJXVwHJKkRII=
Date:   Thu, 6 Dec 2018 15:04:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kilobyte@angband.pl,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, arve@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: implement binderfs
Message-ID: <20181206140403.GA18947@kroah.com>
References: <20181204131239.15158-1-christian@brauner.io>
 <20181205200145.GA25230@kroah.com>
 <20181205214203.cwcvsqe6ndu4e3vv@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205214203.cwcvsqe6ndu4e3vv@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:42:06PM +0100, Christian Brauner wrote:
> On Wed, Dec 05, 2018 at 09:01:45PM +0100, Greg KH wrote:
> > > /* binder-control */
> > > Each new binderfs instance comes with a binder-control device. No other
> > > devices will be present at first. The binder-control device can be used to
> > > dynamically allocate binder devices. All requests operate on the binderfs
> > > mount the binder-control device resides in:
> > > - BINDER_CTL_ADD
> > >   Allocate a new binder device.
> > > Assuming a new instance of binderfs has been mounted at /dev/binderfs via
> > > mount -t binderfs binderfs /dev/binderfs. Then a request to create a new
> > > binder device can be made via:
> > > 
> > > struct binderfs_device device = {0};
> > > int fd = open("/dev/binderfs/binder-control", O_RDWR);
> > > ioctl(fd, BINDER_CTL_ADD, &device);
> > > 
> > > The struct binderfs_device will be used to return the major and minor
> > > number, as well as the index used as the new name for the device.
> > > Binderfs devices can simply be removed via unlink().
> > 
> > I think you should provide a name in the BINDER_CTL_ADD command.  That
> > way you can easily emulate the existing binder queues, and it saves you
> > a create/rename sequence that you will be forced to do otherwise.  Why
> > not do it just in a single command?
> 
> Sounds reasonable. How do you feel about capping the name length at 255
> bytes aka the standard Linux file name length (e.g. xfs, ext4 etc.)?
> 
> #define BINDERFS_NAME_MAX 255
> 
> struct binderfs_device {
>         char name[BINDERFS_NAME_MAX + 1];

__u8 is the proper type to cross the user/kernel boundry :)

> 	__u32 major;
> 	__u32 minor;
> }

Yes, limiting it to 255 is fine with me.

> > That way also you don't need to care about the major/minor number at
> > all.  Userspace should never need to worry about that, use a name,
> > that's the best thing.  Also, it allows you to drop the use of the idr,
> > making the kernel code simpler overall.
> > 
> > > /* Implementation details */
> > > - When binderfs is registered as a new filesystem it will dynamically
> > >   allocate a new major number. The allocated major number will be returned
> > >   in struct binderfs_device when a new binder device is allocated.
> > 
> > Why does userspace care about major/minor numbers at all?  You should
> 
> Userspace cares for the sake of the devices cgroup which operates on
> device numnbers to restrict access to devices. Since binderfs doesn't
> have a static major number returning that information is helpful.

Ugh, ok, that makes sense.  If we really want to make the kernel
interface simpler, drop the major/minor and then have userspace do the
stat(2) to see what the major/minor number they care about is.

But yeah, keeping it here makes everyone's life simpler, the kernel
already knows this, and it's trivial to pass it back to userspace this
way.

Care to make this change and resend?

thanks,

greg k-h

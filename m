Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE39C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA87120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="B4Z/BKtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLFRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:45:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38022 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:45:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so524609pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=srbY72BCLNHKHGQVyFqh+bvKL9qqucUtCQ8Y5nQN3ZY=;
        b=B4Z/BKtR29QaJhT+mjEBwZZVAcuGeRPlet0sGcmvG9pQZdKBaLNZKUBZrSSnJxkyME
         JIW6rkBe+3/W4P+Gr3YmErm/Mjq4g7NuTP3a+q9w8H1OI7TPFsX243a2AqVgb15MNChg
         C1tRhlB2MxBzJ05ZS3BND2brFP05bIpbHbcvnoXP5SwZJxre3h0hz5iGzBFBdewm7aQb
         t2zD6vXy2I2JNE+h+U9mURy1Y7E9fnozrkBikOY8sFkJFZJDcviT66nkaeK7KqWtf1Aw
         d50Kw+EGEqelVe3PWARLj5Cz0kDqlNpJRbp84WjE2HHRpGR8NTQ3TkvHeLnO4gpa5Kx2
         Vetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srbY72BCLNHKHGQVyFqh+bvKL9qqucUtCQ8Y5nQN3ZY=;
        b=chyzc5BAeZjkufMAhrlkSIKIXaYlKa5zccFepRyXQKN6h8ZrOVt2C9EzaW0b2ag+h8
         entLltOJhN4BoyPAN8KZ6erQwVSARkm/rKIoqlQOvybXV3e8VITykk6ep7DVAD73Zs9O
         1ZPjV9G53TXjZrlHH6QAmYKY4jtyf+eq6ayeDiqvHLdjsjp6uzxwLR9M6jPAURI1lrbJ
         kDhsfozghpeAtMuaFGxIOFMgKsU3gKsHGrcBMXi2rySxMtno5+hmDQs3xjewWp8BZNaZ
         BOLQTo0rhSDD6vjlidfBfO9TAq6GpeogSolMNxaU3xQVWnCgA5P+WNEuxYl7sIKER9H6
         RTtw==
X-Gm-Message-State: AA+aEWYYLwPo4KAleazuz35WqOCbw2Su1DViG7itlrfrgBwufOGkVIVn
        K/8Lk+vRpxmRHnz0+tarPTlf0w==
X-Google-Smtp-Source: AFSGD/UitTHcdPH9JEz8pP0M+XL8F+EFNwe1gBbo8LJjeWiJG2E4WNw2ztNNvxnZpjADtanxSeM2fA==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr30579998pfn.205.1544118354263;
        Thu, 06 Dec 2018 09:45:54 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id k24sm1213535pfj.13.2018.12.06.09.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:45:53 -0800 (PST)
Date:   Thu, 6 Dec 2018 18:45:46 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kilobyte@angband.pl,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, arve@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: implement binderfs
Message-ID: <20181206174544.d43vwuq7fnwpd7ti@brauner.io>
References: <20181204131239.15158-1-christian@brauner.io>
 <20181205200145.GA25230@kroah.com>
 <20181205214203.cwcvsqe6ndu4e3vv@brauner.io>
 <20181206140403.GA18947@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206140403.GA18947@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:04:03PM +0100, Greg KH wrote:
> On Wed, Dec 05, 2018 at 10:42:06PM +0100, Christian Brauner wrote:
> > On Wed, Dec 05, 2018 at 09:01:45PM +0100, Greg KH wrote:
> > > > /* binder-control */
> > > > Each new binderfs instance comes with a binder-control device. No other
> > > > devices will be present at first. The binder-control device can be used to
> > > > dynamically allocate binder devices. All requests operate on the binderfs
> > > > mount the binder-control device resides in:
> > > > - BINDER_CTL_ADD
> > > >   Allocate a new binder device.
> > > > Assuming a new instance of binderfs has been mounted at /dev/binderfs via
> > > > mount -t binderfs binderfs /dev/binderfs. Then a request to create a new
> > > > binder device can be made via:
> > > > 
> > > > struct binderfs_device device = {0};
> > > > int fd = open("/dev/binderfs/binder-control", O_RDWR);
> > > > ioctl(fd, BINDER_CTL_ADD, &device);
> > > > 
> > > > The struct binderfs_device will be used to return the major and minor
> > > > number, as well as the index used as the new name for the device.
> > > > Binderfs devices can simply be removed via unlink().
> > > 
> > > I think you should provide a name in the BINDER_CTL_ADD command.  That
> > > way you can easily emulate the existing binder queues, and it saves you
> > > a create/rename sequence that you will be forced to do otherwise.  Why
> > > not do it just in a single command?
> > 
> > Sounds reasonable. How do you feel about capping the name length at 255
> > bytes aka the standard Linux file name length (e.g. xfs, ext4 etc.)?
> > 
> > #define BINDERFS_NAME_MAX 255
> > 
> > struct binderfs_device {
> >         char name[BINDERFS_NAME_MAX + 1];
> 
> __u8 is the proper type to cross the user/kernel boundry :)

Will switch. :)

> 
> > 	__u32 major;
> > 	__u32 minor;
> > }
> 
> Yes, limiting it to 255 is fine with me.

Perfect!

> 
> > > That way also you don't need to care about the major/minor number at
> > > all.  Userspace should never need to worry about that, use a name,
> > > that's the best thing.  Also, it allows you to drop the use of the idr,
> > > making the kernel code simpler overall.
> > > 
> > > > /* Implementation details */
> > > > - When binderfs is registered as a new filesystem it will dynamically
> > > >   allocate a new major number. The allocated major number will be returned
> > > >   in struct binderfs_device when a new binder device is allocated.
> > > 
> > > Why does userspace care about major/minor numbers at all?  You should
> > 
> > Userspace cares for the sake of the devices cgroup which operates on
> > device numnbers to restrict access to devices. Since binderfs doesn't
> > have a static major number returning that information is helpful.
> 
> Ugh, ok, that makes sense.  If we really want to make the kernel
> interface simpler, drop the major/minor and then have userspace do the
> stat(2) to see what the major/minor number they care about is.
> 
> But yeah, keeping it here makes everyone's life simpler, the kernel
> already knows this, and it's trivial to pass it back to userspace this
> way.
> 
> Care to make this change and resend?

For sure. I have a long-haul flight for ~15h so by the time I land I
have a new version I can send out. :)

Thanks!
Christian

Return-Path: <mst@redhat.com>
X-Google-Smtp-Source: AG47ELtINrxDXyuWyjlba9Sy60jJfhRR7cmTEiBhR9Er0inT84VFWDm7JDDFJlB2knJ8daTnLj5L
ARC-Seal: i=1; a=rsa-sha256; t=1521118505; cv=none;
        d=google.com; s=arc-20160816;
        b=xokYDhwnWe8cP16o/VrgA5QMZX6UeOPlwz7AhUeNn9lYrL6vxNBLHbyJOuaeNJPBet
         brpno4eLlBFXIsZw17TgQxlJtTk/kXFGZnI1eDpbnx6OMoad0Fn9Mfbnc50g5dLnX3Yx
         O/4eq/TyMlkm5KbZwjou2dfUwMFc754NM0gmvbsV5YqvT4Rmcx4SUtuwz+EnAW3qlxG8
         6XOFmWtS2tC7nDmLxaELgfblLJxmiQR5sWeIFQMikpeRK+gUJSk9B9prSHNvPI1FX0DM
         IAX4QOS/wGydiWcf/qfZjEF5am7Nn48g2gAbPSMmEU0B2fdZD9ROY6P8iGu6F/pY50sx
         aeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=MGF9sAMB2F2PGK8httUFAdokn759ItZZg8SxEDhrODg=;
        b=W9+Ks01PbFuaILRbLewp1tz91NfEEaANFwzCzDZuEIcfQMeG0MhxdqLWYUQDcsgg5N
         BUS16dBhXlQn+KcdzS/HI8ggM5dE78C0dyTIdQpo45r7Yr60QDs6X+WCcpVg4IcEqDBQ
         FDRk0VIiPaZFHJ/yH8f10npOjrtMdeJgnVj5Ptw1Jw1wrmqXbi0bZ8dAPPQ5a1AudBcs
         TYW76JOCWWLzeXwRosCFRpFmnkX577B7eFiAJTtL0MckW31kYSoVnzmeM463RjjyU05h
         NM3W0KWad9hAuiLWrpBl5x+mMK+yxUL/LjYNId8CDo/jjCTl5RJyd26TDek0VCGV59nb
         Em9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 14:55:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gal Hammer <ghammer@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Or Idgar <idgar@virtualoco.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Or Idgar <oidgar@redhat.com>, Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver
 implementation
Message-ID: <20180315145338-mutt-send-email-mst@kernel.org>
References: <20180301142215.11812-1-idgar@virtualoco.com>
 <20180313190617-mutt-send-email-mst@kernel.org>
 <20180314182536.GA14504@kroah.com>
 <20180314211704-mutt-send-email-mst@kernel.org>
 <CAA2ifQy4nP3-KdHGpho3ayQb_kfCX2GJx0kPmMotoTr3X+b1Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA2ifQy4nP3-KdHGpho3ayQb_kfCX2GJx0kPmMotoTr3X+b1Bw@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593745507285614890?=
X-GMAIL-MSGID: =?utf-8?q?1595008357517830628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:57:05AM +0200, Gal Hammer wrote:
> On Wed, Mar 14, 2018 at 9:25 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Mar 14, 2018 at 07:25:36PM +0100, Greg KH wrote:
> >> On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
> >> > I think it's a good idea to use sysfs for this. However,
> >> > there are a couple of missing interfaces here:
> >> >
> >> > 1. Userspace needs a way to know when this value changes.
> >> >    I see no change notifications here and that does not seem right.
> >>
> >> How can these change?
> >
> > It's a hardware register. It changes when hardware feels like it :)
> > In particular, it changes whenever VM is migrated or snapshotted.
> 
> This value doesn't change when a VM is migrated. It is unlikely that
> this value will be changed so frequently that a direct access to the
> memory is required. Even in QEMU, the current implementation was
> merged without an option to change the generation id on-the-fly. One
> must run a new instance in order to set a new value, which means that
> no application will be running during that time.


The point is still that it changes without an application
or the kernel doing anything.

> >> > 2. Userspace needs to be able to read these without
> >> >    system calls.
> >>
> >> Ick, what?  Why not?
> >>
> >> > Pls add mmap support to the raw format.
> >>
> >> For a single integer?  Why do you need mmap for this?  What is so
> >> "performant" that needs to touch a sysfs file?
> >> >    (Phys address is not guaranteed to be page-aligned so you will
> >> >     probably want an offset attribute for that as well).
> >>
> >> Ick ick ick, that's why it's good to just stick with a sysfs file.
> 
> I agree with Greg here. The user is able to read the value, and then
> wait for a notification if she cares about changes.

OK.  Patch has to implement notifications for this to work though.
That's missing.

> >> Have you tested just how long this takes to see if the open/read/close
> >> is really the bottleneck, or if the io on reading the value is the
> >> bottleneck?
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Well an application needs to check this value basically after
> > every database transaction. So I'm pretty sure it's a performance
> > sensitive path. But yes, I didn't profile any apps since they
> > are yet to be written to use this interface.
> > I'm fine deferring point 2 for now.
> >
> > --
> > MST
> 
> Thanks,
> 
>     Gal.

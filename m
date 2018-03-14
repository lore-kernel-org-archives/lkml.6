Return-Path: <mst@redhat.com>
X-Google-Smtp-Source: AG47ELv13Nzo1e74JXk+aS7K8LeUFSsIFOgDKgJysNt/wEv1lagomwsIOCjnVaCUCIM3+zaN/MPZ
ARC-Seal: i=1; a=rsa-sha256; t=1521055520; cv=none;
        d=google.com; s=arc-20160816;
        b=OC/EX/hQYgbjesJW/NgYohXPfj4bNPC+b3w0YWkliV3sGmbCsDDjOIXk0D+sEWrr6E
         vNKpsyg8vbTUZztqxy8DKiQIyF6swUGowEgo1XqKstuD/KPvENQW2B9nBrOjPLxuMXE5
         8f/5/AfceEsS/o+jQ4DBeikfvmTbXWrOIOZtHF5IDBw/l0jCUKhHRNwbQqkHQbgJ6kU9
         eIZ28wtZh0vfCd4b88/7S14Ix1hUCtsqBMuMMU8u5Uw/GvrDdDdsODbuPhvTkek04TPo
         JdEKTemjM7ExYJmAWKij3764SQAYAx1L91RgHTFBnElhQoJDCH2sT3jObqj3cK8ohoJD
         /pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=Zqbrv/eOPzB+8WA5ovjMMBUzg2Q52Q0FQfTK3ZRLDm8=;
        b=DMmQXJXxFZXFQH9EzXStv9EswptNQRIzQWxsgvPV1zY0SzgTxR2vU9Smp/77XG0yyz
         VgsPalFAgam/qWYvfY0JRvqhocFOhxo8z23iFJQEZGdyPCiuJxzB1A9lw9sOM4cN6eL5
         heexTDk5DSIWHbMvAuYKNp5HXQv90l2wpPhZGlZYJ1mmDn87w0n4LM5+Ap+UjDrWMXWE
         kF7BNd71rA5ZaO0Q+XFGw7lSQKUw1/5suTWL4cnQCVXjVfz6a7ET7JJ1J6Dwqb0P3sp+
         t4Ydz/foyMLacQ2HkLI9EDsPJvU4tsOoc2FIGrORltYIfapaUHYnga9pUK9BBBYyxv9v
         gPiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 14 Mar 2018 21:25:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, oidgar@redhat.com, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver
 implementation
Message-ID: <20180314211704-mutt-send-email-mst@kernel.org>
References: <20180301142215.11812-1-idgar@virtualoco.com>
 <20180313190617-mutt-send-email-mst@kernel.org>
 <20180314182536.GA14504@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314182536.GA14504@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593745507285614890?=
X-GMAIL-MSGID: =?utf-8?q?1594942313312240990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 07:25:36PM +0100, Greg KH wrote:
> On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
> > I think it's a good idea to use sysfs for this. However,
> > there are a couple of missing interfaces here:
> > 
> > 1. Userspace needs a way to know when this value changes.
> >    I see no change notifications here and that does not seem right.
> 
> How can these change?

It's a hardware register. It changes when hardware feels like it :)
In particular, it changes whenever VM is migrated or snapshotted.

> > 2. Userspace needs to be able to read these without
> >    system calls.
> 
> Ick, what?  Why not?
>
> > Pls add mmap support to the raw format.
> 
> For a single integer?  Why do you need mmap for this?  What is so
> "performant" that needs to touch a sysfs file?
> >    (Phys address is not guaranteed to be page-aligned so you will
> >     probably want an offset attribute for that as well).
> 
> Ick ick ick, that's why it's good to just stick with a sysfs file.
> 
> Have you tested just how long this takes to see if the open/read/close
> is really the bottleneck, or if the io on reading the value is the
> bottleneck?
> 
> thanks,
> 
> greg k-h

Well an application needs to check this value basically after
every database transaction. So I'm pretty sure it's a performance
sensitive path. But yes, I didn't profile any apps since they
are yet to be written to use this interface.
I'm fine deferring point 2 for now.

-- 
MST

Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1AA20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="KkkSYMj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1AA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeLEVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:42:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34489 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEVmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:42:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so9630945pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDA9IS9KuEbvp5VG+ipNOhTx0wcWjrEBq6HsEjF2Obg=;
        b=KkkSYMj/PuWMKaDJWWDcZSIzU94s5KReSCgynKrEr6fnHjAnJwixiAs0uAgINtZBvm
         o/L8lHZBnIi6QFT3s28pHp8nM7eThiQe6fMSYMZ2UP43W2AAPhZDA9sVm5WUvcYztXhT
         Nlb3rYl+2IayOd3DL9gdAXDAvZFjtFb7dhpzvlSw1R3VNdDWCYXDtheI23Atl0iKU5ds
         QqmmJnwmQMqTxpCSNNGyCvs3lJCtHI35BmokXrpuOpdAzHo0zLSU/EOpTHY0WN+tXNR5
         z3gqw5CLXncSlPlKixTwND6z080e9p5qHiQ1qubsDKu6Zs4aiqD/6pGPPx3HnfeYiOYU
         VsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDA9IS9KuEbvp5VG+ipNOhTx0wcWjrEBq6HsEjF2Obg=;
        b=XvCfsw6CrbdAfzm/qTH2OxJ2Ww0NsDXLlAOk7R/dXSMcpg8EnVhS9tFvNTRQT8p74l
         FforrS7pRHWuFlOtaUvpgvOgpNjGhalwgqhFd52UaQOxOFAdWphaosVRCym46i7HBWGj
         iaAawmroUev+tyipOXSJZSPw+079kNDYHyHQxGRfRz+ZaX0enefeey7DUJuWoxanf9Gt
         0xOkEqnxez3DHwnfgh9Uinly7TlIYJVb9gVp1rZKL157I/6SHzDpysHrNLC4Y69624Sr
         5Devcr73FnsDGJ4H5H27gPZvw59XSMTPe/Kp60gjR35WCmFexGAmrk7kuLODKzvGqhcm
         1soQ==
X-Gm-Message-State: AA+aEWZz0VTuhpLXFSVS6oLO4FL3a5fdFk29BGH8ADo0BgLE21reQzeU
        Mgc2WVLobnC+es/hYGFE+Rl9ug==
X-Google-Smtp-Source: AFSGD/Xt71J3h3o7MT1d5ocNchRDNpVPXcyRFoXInYDEkv2nX20fv2rBBxL9Bd1B9s20hDfkLLwWVg==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr21622832pgv.31.1544046135551;
        Wed, 05 Dec 2018 13:42:15 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id t3sm20881167pgv.31.2018.12.05.13.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:42:14 -0800 (PST)
Date:   Wed, 5 Dec 2018 22:42:06 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, kilobyte@angband.pl,
        darrick.wong@oracle.com, chouryzhou@tencent.com,
        david@fromorbit.com, arve@android.com, joel@joelfernandes.org,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binder: implement binderfs
Message-ID: <20181205214203.cwcvsqe6ndu4e3vv@brauner.io>
References: <20181204131239.15158-1-christian@brauner.io>
 <20181205200145.GA25230@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205200145.GA25230@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:01:45PM +0100, Greg KH wrote:
> On Tue, Dec 04, 2018 at 02:12:39PM +0100, Christian Brauner wrote:
> > As discussed at Linux Plumbers Conference 2018 in Vancouver [1] this is the
> > implementation of binderfs. If you want to skip reading and just see how it
> > works, please go to [2].
> 
> First off, thanks for doing this so quickly.  I think the overall idea
> and implementation is great, I just have some minor issues with the user
> api:

Thanks! :)

> 
> > /* binder-control */
> > Each new binderfs instance comes with a binder-control device. No other
> > devices will be present at first. The binder-control device can be used to
> > dynamically allocate binder devices. All requests operate on the binderfs
> > mount the binder-control device resides in:
> > - BINDER_CTL_ADD
> >   Allocate a new binder device.
> > Assuming a new instance of binderfs has been mounted at /dev/binderfs via
> > mount -t binderfs binderfs /dev/binderfs. Then a request to create a new
> > binder device can be made via:
> > 
> > struct binderfs_device device = {0};
> > int fd = open("/dev/binderfs/binder-control", O_RDWR);
> > ioctl(fd, BINDER_CTL_ADD, &device);
> > 
> > The struct binderfs_device will be used to return the major and minor
> > number, as well as the index used as the new name for the device.
> > Binderfs devices can simply be removed via unlink().
> 
> I think you should provide a name in the BINDER_CTL_ADD command.  That
> way you can easily emulate the existing binder queues, and it saves you
> a create/rename sequence that you will be forced to do otherwise.  Why
> not do it just in a single command?

Sounds reasonable. How do you feel about capping the name length at 255
bytes aka the standard Linux file name length (e.g. xfs, ext4 etc.)?

#define BINDERFS_NAME_MAX 255

struct binderfs_device {
        char name[BINDERFS_NAME_MAX + 1];
	__u32 major;
	__u32 minor;
}

> 
> That way also you don't need to care about the major/minor number at
> all.  Userspace should never need to worry about that, use a name,
> that's the best thing.  Also, it allows you to drop the use of the idr,
> making the kernel code simpler overall.
> 
> > /* Implementation details */
> > - When binderfs is registered as a new filesystem it will dynamically
> >   allocate a new major number. The allocated major number will be returned
> >   in struct binderfs_device when a new binder device is allocated.
> 
> Why does userspace care about major/minor numbers at all?  You should

Userspace cares for the sake of the devices cgroup which operates on
device numnbers to restrict access to devices. Since binderfs doesn't
have a static major number returning that information is helpful.
One example is a managining process sharing a binderfs mounts between
multiple ipc+mount namespaces via bind-mounts to avoid having separate
binderfs mounts. If the managing process only wants to grant access to binder0
and no other device for a given ipc+mnt namespace combination then it
can use the devices cgroup but for that it needs to know the major and
minor number.

> just be able to deal with the binder "names", that's all that userspace
> uses normally as you are not calling mknod() yourself.
> 
> >   Minor numbers that have been given out are tracked in a global idr struct
> >   that is capped at BINDERFS_MAX_MINOR. The minor number tracker is
> >   protected by a global mutex. This is the only point of contention between
> >   binderfs mounts.
> 
> I doubt this will be any real contention given that setting up / tearing
> down binder mounts is going to be rare, right?  Well, hopefully, who
> knows with some container systems...

Yeah, it's very unlikely. Device allocation is a rare event that is
basically done once for most interesting use-cases. If one cares so much
about performance bind-mounts + device cgroup restrictions are possible
solution to this problem.

> 
> > - The naming scheme for binder devices is binder%d. Each binderfs mount
> >   starts numbering of new binder devices at 0 up to n. The indeces used in
> >   constructing the name are tracked in a struct idr that is per-binderfs
> >   super block.
> 
> Again, let userspace pick the name, as you will have to rename it anyway
> to get userspace to work properly with it.
> 
> I'll stop repeating myself now :)

Thanks for the feedback! :)

Christian

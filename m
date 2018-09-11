Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C434206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C434206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeILB2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:28:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45082 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:28:09 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so29684506qtb.12;
        Tue, 11 Sep 2018 13:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgeeq6W8xAt+ZmUnHosLhoVGkPL4xjBuBswxTdHIBY8=;
        b=KqQqO7jpfruuchi/HFOn6mqhc8rbX4Am3/qgxpjoh7esL5SoPpHyWMn43NXbAV4OUs
         BAF3graa89PRiqy5JYPrvqphSiQNxgLDz5pKh6pSA6ceYPGF2WPQjqtFOvdAKDizUJBJ
         UsV+KeIO0mue4Cq6qUO7ctJnXpn4ZF2q+64GLGn7N+aeBoqLbNncrn5BpjvvW44YlcvL
         A28TU947vHmREi5IS1pdvKpvnlC64dkXEa24JkxSEMRJ7dOhy2ZUbmmoNIEqzZantl/V
         X8pIyQqW+++GElmfaDxCiU3gK0P/8wZGCqP8TD7WgAg5jbRMqwwAwpJ35Mr/s8Blr+zb
         xvFA==
X-Gm-Message-State: APzg51AUn4DT7b2LxjZ+q8b8Us6+Wu6dNGi/NAHL4opEKW4OCwDiatJg
        WOYhC7MBMBVRe8AaPPCcC8NBk34uzWvvU3Dygog=
X-Google-Smtp-Source: ANB0VdZ8TSPLR3XG0LA9QrpV3t2AkO1JQG9H3KsumXMxZ4oNflfE9CRqVTehgHSP30lFHIY3S8EyCPy0vklyJOfHDPo=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr21918669qtr.9.1536697630765;
 Tue, 11 Sep 2018 13:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180908142837.2819693-1-arnd@arndb.de> <20180908142837.2819693-6-arnd@arndb.de>
 <20180909041114.GD19965@ZenIV.linux.org.uk>
In-Reply-To: <20180909041114.GD19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Sep 2018 22:26:54 +0200
Message-ID: <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Sep 08, 2018 at 04:28:12PM +0200, Arnd Bergmann wrote:
> > These are all handled by the random driver, so instead of listing
> > each ioctl, we can just use the same function to deal with both
> > native and compat commands.
>
> Umm...  I don't think it's right -
>
> >       .unlocked_ioctl = random_ioctl,
> > +     .compat_ioctl = random_ioctl,
>
>
> ->compat_ioctl() gets called in
>                         error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
> so you do *NOT* get compat_ptr() for those - they have to do it on their
> own.  It's not hard to provide a proper compat_ioctl() instance for that
> one, but this is not it.  What you need in drivers/char/random.c part of
> that one is something like

Looping in some s390 folks.

As you suggested in another reply, I had a look at what other drivers
do the same thing and have only pointer arguments. I created a
patch to move them all over to using a new helper function that
adds the compat_ptr(), and arrived at

 drivers/android/binder.c                    | 2 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c | 2 +-
 drivers/dma-buf/dma-buf.c                   | 4 +---
 drivers/dma-buf/sw_sync.c                   | 2 +-
 drivers/dma-buf/sync_file.c                 | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    | 2 +-
 drivers/hid/hidraw.c                        | 4 +---
 drivers/iio/industrialio-core.c             | 2 +-
 drivers/infiniband/core/uverbs_main.c       | 4 ++--
 drivers/media/rc/lirc_dev.c                 | 4 +---
 drivers/mfd/cros_ec_dev.c                   | 4 +---
 drivers/misc/vmw_vmci/vmci_host.c           | 2 +-
 drivers/nvdimm/bus.c                        | 4 ++--
 drivers/nvme/host/core.c                    | 6 +++---
 drivers/pci/switch/switchtec.c              | 2 +-
 drivers/platform/x86/wmi.c                  | 2 +-
 drivers/rpmsg/rpmsg_char.c                  | 4 ++--
 drivers/s390/char/sclp_ctl.c                | 8 ++------
 drivers/s390/char/vmcp.c                    | 2 ++----
 drivers/s390/cio/chsc_sch.c                 | 8 ++------
 drivers/sbus/char/display7seg.c             | 2 +-
 drivers/sbus/char/envctrl.c                 | 4 +---
 drivers/scsi/3w-xxxx.c                      | 4 +---
 drivers/scsi/cxlflash/main.c                | 2 +-
 drivers/scsi/esas2r/esas2r_main.c           | 2 +-
 drivers/scsi/pmcraid.c                      | 4 +---
 drivers/staging/android/ion/ion.c           | 4 +---
 drivers/staging/vme/devices/vme_user.c      | 2 +-
 drivers/tee/tee_core.c                      | 2 +-
 drivers/usb/class/cdc-wdm.c                 | 2 +-
 drivers/usb/class/usbtmc.c                  | 4 +---
 drivers/video/fbdev/ps3fb.c                 | 2 +-
 drivers/video/fbdev/sis/sis_main.c          | 4 +---
 drivers/virt/fsl_hypervisor.c               | 2 +-
 fs/btrfs/super.c                            | 2 +-
 fs/ceph/dir.c                               | 2 +-
 fs/ceph/file.c                              | 2 +-
 fs/fuse/dev.c                               | 2 +-
 fs/notify/fanotify/fanotify_user.c          | 2 +-
 fs/userfaultfd.c                            | 2 +-
 net/rfkill/core.c                           | 2 +-
 41 files changed, 48 insertions(+), 76 deletions(-)

Out of those, there are only a few that may get used on s390,
in particular at most infiniband/uverbs, nvme, nvdimm,
btrfs, ceph, fuse, fanotify and userfaultfd.
[Note: there are three s390 drivers in the list, which use
a different method: they check in_compat_syscall() from
a shared handler to decide whether to do compat_ptr().

According to my memory from when I last worked on this,
the compat_ptr() is mainly a safeguard for legacy binaries
that got created with ancient C compilers (or compilers for
something other than C)  and might leave the high bit set
in a pointer, but modern C compilers (gcc-3+) won't ever
do that.

You are probably right about /dev/random, which could be
used in lots of weird code, but I wonder to what degree we
need to worry about it for the rest.

       Arnd

Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B871EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809582245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zbWgoaZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809582245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKOJGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeKOJGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:06:05 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034F22175B;
        Wed, 14 Nov 2018 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542236449;
        bh=W6DilLECtZEl/TpM4Ttb1OuYfumoT3IxKllr6rl6zjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbWgoaZJFJNvya5f5GR/gpTNCw7MDEEszw8zlaSLvMApEVNzfViXTJrHGbaIEvVlX
         mGMyWzfFXPkTT8luMMfhZmW3BYA717pvzeo35hIekOqLC1neJK97MwFIqTU+o2LLKB
         KwOStlt7YWGvLBDypiwpqxqgbEt1R+HDFBKFJimQ=
Date:   Wed, 14 Nov 2018 15:00:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Torokhov <dtor@google.com>
Cc:     jannh@google.com, dh.herrmann@googlemail.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
Message-ID: <20181114230046.GC87768@gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org>
 <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Nov 14, 2018 at 02:28:56PM -0800, 'Dmitry Torokhov' via syzkaller-bugs wrote:
> On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > When a UHID_CREATE command is written to the uhid char device, a
> > > copy_from_user() is done from a user pointer embedded in the command.
> > > When the address limit is KERNEL_DS, e.g. as is the case during
> > > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > > information can be leaked from a setuid binary that is tricked to write
> > > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> > >
> > > No other commands in uhid_char_write() are affected by this bug and
> > > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > > UHID_CREATE only rather than to uhid_char_write() entirely.
> > >
> > > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > > helpers fault on kernel addresses"), allowing this bug to be found.
> > >
> > > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > > Cc: <stable@vger.kernel.org> # v3.6+
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> >
> > > ---
> > >  drivers/hid/uhid.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > index 3c55073136064..051639c09f728 100644
> > > --- a/drivers/hid/uhid.c
> > > +++ b/drivers/hid/uhid.c
> > > @@ -12,6 +12,7 @@
> > >
> > >  #include <linux/atomic.h>
> > >  #include <linux/compat.h>
> > > +#include <linux/cred.h>
> > >  #include <linux/device.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/hid.h>
> > > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> > >
> > >         switch (uhid->input_buf.type) {
> > >         case UHID_CREATE:
> > > +               /*
> > > +                * 'struct uhid_create_req' contains a __user pointer which is
> > > +                * copied from, so it's unsafe to allow this with elevated
> > > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > > +                */
> 
> uhid is a privileged interface so we would go from root to less
> privileged (if at all). If non-privileged process can open uhid it can
> construct virtual keyboard and inject whatever keystrokes it wants.
> 
> Also, instead of disallowing access, can we ensure that we switch back
> to USER_DS before trying to load data from the user pointer?
> 

Actually uhid doesn't have any capability checks, so it's up to userspace to
assign permissions to the device node.  I think it's best not to make
assumptions about how the interface will be used and to be consistent with how
other ->write() methods in the kernel handle the misfeature where a __user
pointer in the write() or read() payload is dereferenced.  Temporarily switching
to USER_DS would only avoid one of the two problems.

Do you think the proposed restrictions would actually break anything?

- Eric

> > > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > > +                                   task_tgid_vnr(current), current->comm);
> > > +                       ret = -EACCES;
> > > +                       goto unlock;
> > > +               }
> > >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> > >                 break;
> > >         case UHID_CREATE2:
> > > --

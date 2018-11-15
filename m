Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A031C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34020223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34020223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeKOSVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:21:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35659 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeKOSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:21:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so30525783qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Y/YYCQ5YtJXszyF1A2o32FlHv2Tk3YOK5ss2MF05vs=;
        b=pOU7/exFS62I+rrKuC4BID8NKv3DFEonRAwZY+/6TAv9juMt+YN0CJFpDdMyjQIzBz
         ZEP3wqSyu6RV657TreKWk8DhEN+THF1CrV4EsUpqLpqZUQy3cOrhVqKl2Y0fk7R9G2hd
         zI/bS4lkAJwoA7Qae7gl6JSBQjFFhzelWqMEHFZZPx7OL9olgSFFpVV/ANIldc1SPzJT
         n3fZNnLUPNKGUFXepMOEkFOdv1i6FL0FDqvwmxMttY+DABz1sDIAK8dzyJZUaslFhHov
         WYGQaVznVMtRq25gSmbVcYWfieNCxKHQXpJkjDGTB8W1m6Csc2QdacPbRfj2LPbszTFu
         k+aA==
X-Gm-Message-State: AGRZ1gLB+S8emkfWFmYAoFGM2MCGJzdAqthR4CJPFLrMRSpcxm2RZ6v3
        6rcA56t5pxVR4Zg2Fjva+8RESETj0AgVemZ1qCbHDg==
X-Google-Smtp-Source: AJdET5c8AS0UBtkbwIQE2Ucsif9RwD23dWufctAVpxWRDHrMTYIXmf4KWTKVNKh4IuuT3QKxIM/5GHVueB47PcEDlVQ=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr5022460qkf.194.1542269674041;
 Thu, 15 Nov 2018 00:14:34 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
 <20181114230046.GC87768@gmail.com> <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com>
In-Reply-To: <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 15 Nov 2018 09:14:22 +0100
Message-ID: <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     Dmitry Torokhov <dtor@google.com>
Cc:     ebiggers@kernel.org, jannh@google.com, dh.herrmann@googlemail.com,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, dvyukov@google.com,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        "3.8+" <stable@vger.kernel.org>, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:20 AM Dmitry Torokhov <dtor@google.com> wrote:
>
> On Wed, Nov 14, 2018 at 3:00 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Hi Dmitry,
> >
> > On Wed, Nov 14, 2018 at 02:28:56PM -0800, 'Dmitry Torokhov' via syzkaller-bugs wrote:
> > > On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > > >
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > >
> > > > > When a UHID_CREATE command is written to the uhid char device, a
> > > > > copy_from_user() is done from a user pointer embedded in the command.
> > > > > When the address limit is KERNEL_DS, e.g. as is the case during
> > > > > sys_sendfile(), this can read from kernel memory.  Alternatively,
> > > > > information can be leaked from a setuid binary that is tricked to write
> > > > > to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
> > > > >
> > > > > No other commands in uhid_char_write() are affected by this bug and
> > > > > UHID_CREATE is marked as "obsolete", so apply the restriction to
> > > > > UHID_CREATE only rather than to uhid_char_write() entirely.
> > > > >
> > > > > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > > > > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > > > > helpers fault on kernel addresses"), allowing this bug to be found.
> > > > >
> > > > > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> > > > > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > > > > Cc: <stable@vger.kernel.org> # v3.6+
> > > > > Cc: Jann Horn <jannh@google.com>
> > > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > >
> > > > Reviewed-by: Jann Horn <jannh@google.com>
> > > >
> > > > > ---
> > > > >  drivers/hid/uhid.c | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > > > > index 3c55073136064..051639c09f728 100644
> > > > > --- a/drivers/hid/uhid.c
> > > > > +++ b/drivers/hid/uhid.c
> > > > > @@ -12,6 +12,7 @@
> > > > >
> > > > >  #include <linux/atomic.h>
> > > > >  #include <linux/compat.h>
> > > > > +#include <linux/cred.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/fs.h>
> > > > >  #include <linux/hid.h>
> > > > > @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> > > > >
> > > > >         switch (uhid->input_buf.type) {
> > > > >         case UHID_CREATE:
> > > > > +               /*
> > > > > +                * 'struct uhid_create_req' contains a __user pointer which is
> > > > > +                * copied from, so it's unsafe to allow this with elevated
> > > > > +                * privileges (e.g. from a setuid binary) or via kernel_write().
> > > > > +                */
> > >
> > > uhid is a privileged interface so we would go from root to less
> > > privileged (if at all). If non-privileged process can open uhid it can
> > > construct virtual keyboard and inject whatever keystrokes it wants.
> > >
> > > Also, instead of disallowing access, can we ensure that we switch back
> > > to USER_DS before trying to load data from the user pointer?
> > >
> >
> > Actually uhid doesn't have any capability checks, so it's up to userspace to
> > assign permissions to the device node.
>
> Yes. There are quite a few such instances where kernel does not bother
> implementing superfluous checks and instead relies on userspace to
> provide sane environment. IIRC nobody in the kernel enforces root
> filesystem not be accessible to ordinary users, it is done with
> generic permission checks.
>
> > I think it's best not to make
> > assumptions about how the interface will be used and to be consistent with how
> > other ->write() methods in the kernel handle the misfeature where a __user
> > pointer in the write() or read() payload is dereferenced.
>
> I can see that you might want to check credentials, etc, if interface
> can be accessed by unprivileged process, however is it a big no no for
> uhid/userio/uinput devices.

Yep, any sane distribution would restrict the permissions of
uhid/userio/uinput to only be accessed by root. If that ever changes,
there is already an issue with the system and it was compromised
either by a terribly dizzy sysadmin.

>
> > Temporarily switching
> > to USER_DS would only avoid one of the two problems.
>
> So because of the above there is only one problem. If your system
> opened access to uhid to random processes you have much bigger
> problems than exposing some data from a suid binary. You can spam "rm
> -rf .; rm -rf /" though uhid if there is interactive session
> somewhere.
>
> >
> > Do you think the proposed restrictions would actually break anything?
>
> It would break if someone uses UHID_CREATE with sendpage. I do not
> know if anyone does. If we were certain there are no users we'd simply
> removed UHID_CREATE altogether.

AFAICT, there are 2 users of uhid:
- bluez for BLE devices (using HID over GATT)
- hid-replay for debugging.

There might be a few other users that are making some user space
driver out of opencv, but I wouldn't expect those to be really
widespread.

IIRC, bluez uses UHID_CREATE2 and hid-replay should also (or ought to
be, but this can be easily fixed as I maintain the code and I am the
almost sole user).

Regarding the sendpage fix, doesn't David's patch fixes the issue
already (https://patchwork.kernel.org/patch/10682549/).

I am fine applying whatever patch that fixes the security issues, as
long as it doesn't break bluez nor the hid-replay uses I have for
debugging and regression testing.

Cheers,
Benjamin

>
> >
> > - Eric
> >
> > > > > +               if (file->f_cred != current_cred() || uaccess_kernel()) {
> > > > > +                       pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
> > > > > +                                   task_tgid_vnr(current), current->comm);
> > > > > +                       ret = -EACCES;
> > > > > +                       goto unlock;
> > > > > +               }
> > > > >                 ret = uhid_dev_create(uhid, &uhid->input_buf);
> > > > >                 break;
> > > > >         case UHID_CREATE2:
> > > > > --
>
> Thanks.
>
> --
> Dmitry

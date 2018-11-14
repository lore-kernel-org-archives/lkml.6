Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C824020868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vyD6ubFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C824020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbeKOIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388782AbeKOIci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:38 -0500
Received: from gmail.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13382175B;
        Wed, 14 Nov 2018 21:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542232477;
        bh=GgKyYMrZlbrZnXx2A/eOE1QtMQFOf0REK5vqRqD3XNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vyD6ubFwCqtR8Tfq9aOrb+wjz38bgoiIXmrW1zUtv4zy/V37qmNMCjic+nRaOjPTc
         baRoJ/KJlX3PnkIYn5aYoJhh5xDw4lQeF4+kxvW3LMUXaAyG9uxj/klHV2qOfIO4uZ
         YPZ6+5PNmzDUkcazLGj1EAGmU71dWWfi+uMZFEr8=
Date:   Wed, 14 Nov 2018 13:54:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     dh.herrmann@googlemail.com, Jiri Kosina <jikos@kernel.org>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>, dtor@google.com,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
Message-ID: <20181114215434.GB87768@gmail.com>
References: <20181114171447.GA87768@gmail.com>
 <20181114180217.195917-1-ebiggers@kernel.org>
 <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 07:18:39PM +0100, 'Jann Horn' via syzkaller-bugs wrote:
> +cc Andy
> 
> On Wed, Nov 14, 2018 at 7:03 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > When a UHID_CREATE command is written to the uhid char device, a
> > copy_from_user() is done from a user pointer embedded in the command.
> > When the address limit is KERNEL_DS, e.g. as is the case during
> > sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
> > must not be allowed in this case.
> >
> > For consistency and to make sure all current and future uhid commands
> > are covered, apply the restriction to uhid_char_write() as a whole
> > rather than to UHID_CREATE specifically.
> >
> > Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
> > Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
> > helpers fault on kernel addresses"), allowing this bug to be found.
> >
> > Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
> 
> Wheeeee, it found something! :)
> 
> > Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
> > Cc: <stable@vger.kernel.org> # v3.6+
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  drivers/hid/uhid.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 3c55073136064..e94c5e248b56e 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -705,6 +705,12 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
> >         int ret;
> >         size_t len;
> >
> > +       if (uaccess_kernel()) { /* payload may contain a __user pointer */
> > +               pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
> > +                           __func__, task_tgid_vnr(current), current->comm);
> > +               return -EACCES;
> > +       }
> 
> If this file can conceivably be opened by a process that doesn't have
> root privileges, this check should be something along the lines of
> ib_safe_file_access() or sg_check_file_access().
> 
> Checking for uaccess_kernel() prevents the symptom that syzkaller
> notices - a user being able to cause a kernel memory access -, but it
> doesn't deal with the case where a user opens a file descriptor to
> this device and tricks a more privileged process into writing into it
> (e.g. by passing it to a suid binary as stdout or stderr).
> 

Yep, I'll do that.

> Looking closer, I wonder whether this kind of behavior is limited to
> the UHID_CREATE request, which has a comment on it saying "/*
> Obsolete! Use UHID_CREATE2. */". If we could keep this kind of ugly
> kludge away from the code paths you're supposed to be using, that
> would be nice...
> 

I wanted to be careful, but yes AFAICS it can be limited to UHID_CREATE only,
so I'll do that instead.

- Eric

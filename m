Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0BFC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452AA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452AA2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeJ2RY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:24:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43533 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbeJ2RY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:24:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so8226477qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvD+qhjcC5r6uNHaCROudDcSbU0PDuEp1xBMMjlhqc4=;
        b=Tg+7GA1fwVe5A7HnTR5630e7J6YE7LI0mnw5aTnPeyh2LlKRaGPdV8mw/rD3E4p+e4
         eKJxoMk8mMQUKjR6Tz5KoHsjQMANhMtjkFyyXzfYFVbaYJaAsNipa3QDiLN7QsxuxDM6
         k8ntlHJ6KDdV0492v4bbLUc1LdcDxZ8kt90tjDWtG+qaS0j2tHX4N2tOENIUI8ZXcLKz
         QQcneGZIRjYeqC83328ijaBnc4r486JQWOVAaKIRof8464QTajN2ZCD7oA7pwhuoGt4J
         JxYCrfYPzDmeDnyMKTm12XyNY1ckH+u5WfyvBQQCnafron20EezNTROXxKSMVI4HnURt
         DiFA==
X-Gm-Message-State: AGRZ1gI0Jyf4vB6/iW2H7NYpDxp1ajEAi8N/rLXt9RAs1FCK7f53g2Wq
        r0ZLxnLB4Sxf7JFP9ESPHZEyoI3INoNEFHouGPrtVA==
X-Google-Smtp-Source: AJdET5dgHilzJMxQ42+jZrPlqXsDfgIrBTLRkafOZH+kr72c893azt0oTh/a1Aq5TIuBFySd6/MuyIvcf88/XIuV9zo=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr11814460qtl.343.1540802207715;
 Mon, 29 Oct 2018 01:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
 <8d8e3771-0b33-2489-4e27-d3d63162df11@redhat.com>
In-Reply-To: <8d8e3771-0b33-2489-4e27-d3d63162df11@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Oct 2018 09:36:36 +0100
Message-ID: <CAO-hwJLwihgNOBhzjXkJnoZM9iDSKW2XQPUT2xEzKSEBS_2wEw@mail.gmail.com>
Subject: Re: Oops in current tree in i2c
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, jkosina@suse.cz,
        Julian Sax <jsbc@gmx.de>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 28, 2018 at 11:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Linus,
>
> On 27-10-18 18:08, Linus Torvalds wrote:
> > Julian, Jiri,
> >   On my laptop I'm getting a kernel page fault with the current git
> > tree, and I'm tentatively blaming commit
> >
> >    9ee3e06610fd ("HID: i2c-hid: override HID descriptors for certain devices")
> >
> > but that's simply because it's the only thing that seems to touch this
> > particular area in this merge window.
> >
> > The oops looks like this:
> >
> >    BUG: unable to handle kernel paging request at 000000007a25d598
> >    PGD 0 P4D 0
> >    Oops: 0000 [#1] SMP PTI
> >    CPU: 1 PID: 888 Comm: systemd-udevd Not tainted 4.19.0-07715-g345671ea0f92 #4
> >    Hardware name: Dell Inc. XPS 13 9350/09JHRY, BIOS 1.7.0 01/16/2018
> >    RIP: 0010:strstr+0x19/0x70
> >
> > where the code disassembly (and the register contents) shows that the
> > wild pointer is the first argument to "strstr()", which just has a
> > bogus value that is not a valid kernel pointer (RDI: 000000007a25d598
> > - which is obviously also the address of the page fault)
> >
> > The call trace is:
> >
> >     dmi_matches+0x55/0xc0
> >     dmi_first_match+0x26/0x40
> >     i2c_hid_get_dmi_i2c_hid_desc_override+0x16/0x40 [i2c_hid]
> >     i2c_hid_probe+0x28c/0x760 [i2c_hid]
> >     i2c_device_probe+0x1e7/0x260
> >     really_probe+0xf8/0x3e0
> >     driver_probe_device+0x10f/0x120
> >     bus_for_each_drv+0x66/0xb0
> >     __device_attach+0xd9/0x150
> >     bus_probe_device+0x8a/0xa0
> >     device_add+0x48e/0x660
> >     i2c_new_device+0x162/0x350
> >
> > which is why I suspect that new i2c_hid_get_dmi_hid_report_desc_override() code.
> >
> > I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> > isn't terminated by a NULL entry, and I will test that next.

Thanks for fixing that in master. I should have spotted it while
reviewing the series. My bad.

>
> Yes that likely is the problem. I already had a bug report from one of the
> Manjaro maintainers who was cherry picking this into the Manjaro kernel.
>
> So I ran some tests on a laptop of mine which does use i2c-hid but I
> failed to reproduce the issue, so we both (me and the Manjaro maintainer)
> both assumed something went wrong with the backport.
>
> Both of us seem to have overlooked the missing terminating entry,
> as well as other people involved in the patch.
>
> > What makes me *very* unhappy about this is that if I'm right, I think
> > it means that code was literally not tested at all by anybody who
> > didn't have one of the entries in that list.
>
> That is not true, I've hit one of these unterminated dmi lists
> issues before and it depends on what get put in mem directly
> after the list by the linker, bugs caused by this do not always
> reproduce unfortunately.
>
> And as mentioned I have tested the patch on a machine with an i2c-hid
> touchpad, which is not on the list and I did not hit this problem.

Oh. This explains why I was also sure I tested this on a i2c-hid
laptop without having the oops.

I'll try to setup some automate testing for those also.

Cheers,
Benjamin

>
> Anyways this is fixed now, thank you for catching this.
>
> Regards,
>
> Hans

Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525760918; cv=none;
        d=google.com; s=arc-20160816;
        b=nzSDbvDml6pCTxSTDBEIz7QTiF7hWfLE+FTybL6VRhWoP6i2MsynGuruUj3n+gh3GQ
         p94D+oT1Qa0smIPnEJc3FkOLZ6pQHojiXII1OpHIsLcvGafL1ko24Lm9IJLtG7MikNzs
         p7nacKSV4nt0mew7cqj45YQ4uA6wk67UoDjKc1vaI/xlsx5Vtx024SKheQKxRtVzTbVH
         H+tKC7DSG0GniDkE/rSAW9+mIDxvKnSKCQ8wg00lU9WBonhb2NfbimDizIaartrbR2xM
         Te0xtIeOfox3upUOBTB+RNXgNLycv8ujK1Yl2hcUFTvp2W/uJJ785QGNid342B9V2fXR
         xv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=TaJiNpZ4n2Bw4LZCYU4pHKSya4UNpJJVNTR0XEgwqmc=;
        b=avsK87MEBHsrAeCcMj1l+DGS8s/BDnB/1Tx277A7X54OgrTs9iIZc96+XdZ93HxSSu
         QvnuNQGnOdbtFEIaMEC1wUkickvqUnJ5qSc+UaFS1QrZgP/5uZHKPs+lcOLZ0InquSsj
         dOhcIX/WSIa/CZeSL72+7pszQ38l4yujXMyyMLmIG1l4D85n3EPpeCRrzVD15r8wdw+g
         ROC+dZrmyrwH4bwdUg480+7C7IoGyCtywTay1DHWsh+D8xwMUCrv4ZS6U17N6ITYZi2/
         GU7fRQWNVIxUhL39BCkBJ+BCLDiZZ/wRb/kPewSh4kXichaoR4Yr3svYpTHVCS6/D95Q
         2U+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AC27Ed2r;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AC27Ed2r;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZq9wOikBzaY6kcauv0O6NZg/MQfeVjvL6F6fW4cyPyNF7TpEKYtVRvWiBvgxNt/bC0U8boM+HOs9N41sOs9PQA=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180507144511.GA22694@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com> <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
 <CAMuHMdV_5p0Un3xMC1SMw71xpLAzVH0u4oJCTeGeo7jXS4KZSA@mail.gmail.com> <20180507144511.GA22694@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 08:28:37 +0200
X-Google-Sender-Auth: o49Z92gWKvOh2W1hJjfo1_l75ic
Message-ID: <CAMuHMdUBdm-wQ-swoBCRLJT7-=qaF4oRG-i4Rvc+tctWpWD38Q@mail.gmail.com>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599876280781970947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Mon, May 7, 2018 at 4:45 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 07, 2018 at 02:53:13PM +0200, Geert Uytterhoeven wrote:
>> On Mon, May 7, 2018 at 1:57 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
>> > On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
>> >> > > Why not just have an "bus is registered" flag in your driver
>> >> > > register function that refuses to let drivers register with the
>> >> > > driver core if it isn't set?
>> >> >
>> >> > Perhaps that should happen in the core driver_register() function.
>> >> > BUG_ON is frowned upon, after all. Would that be acceptable?
>> >>
>> >> I don't understand what you mean here, perhaps make a patch to show it?
>> >>
>> >
>> > As an alternative to your suggestion (add flag to avoid the BUG_ON):
>> >
>> > --- a/drivers/base/driver.c
>> > +++ b/drivers/base/driver.c
>> > @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
>> >         int ret;
>> >         struct device_driver *other;
>> >
>> > -       BUG_ON(!drv->bus->p);
>> > +       if (!drv->bus->p) {
>> > +               WARN_ONCE(1, "Cannot register driver with invalid bus\n");
>> > +               return -EPROBE_DEFER;
>> > +       }
>> >
>> >         if ((drv->bus->probe && drv->probe) ||
>> >             (drv->bus->remove && drv->remove) ||
>> >
>> > I'm not actually proposing this change; just responding to your question.
>>
>> The bus_type.p field may be unused by some bus drivers, hence this
>> would prevent their drivers from being registered.
>
> bus_type.p is an internal-to-the-driver-core structure, no bus driver
> should ever be touching it.  This is a catch to see if someone is using
> the driver core incorrectly.

Thanks, I stand corrected.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

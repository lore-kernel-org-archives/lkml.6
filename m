Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeEONl1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:41:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40250 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbeEONlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:41:23 -0400
X-Google-Smtp-Source: AB8JxZpvyuPb43qjpTuWiqCJgscnTZoIvfKCli37tKsuhZKuzLKbnXF8qrshZeJHo4+b0RDTepb68g==
Message-ID: <aa8608844b153359f5e2a7ab876c75eb19969fb7.camel@redhat.com>
Subject: Re: [PATCH v2] platform/x86: asus-wmi: Add keyboard backlight
 toggle support
From: Benjamin Berg <bberg@redhat.com>
To: Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Chiu <chiu@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Date: Tue, 15 May 2018 15:41:18 +0200
In-Reply-To: <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
References: <20180503030438.51150-1-chiu@endlessm.com>
         <CAHp75VfM+1HUi6W986r0iEiuS46TJc8XscO_ce4N-i66EtPLWA@mail.gmail.com>
         <CAD8Lp46edWAR2iVti8gGp+L_yy91ij6AHuJh3iuuTLg8oUq47g@mail.gmail.com>
         <CAD8Lp46-q8=t9RoWxLjZkv=EAJAbRvY37-ibUof+oVfZaOE0Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Daniel,

I had a quick chat with Bastien about this. The conclusion was that
reusing the TOGGLE key may be problematic for gnome-settings-daemon.
And the alternative of a new CYCLE key also has some caveats.

The most straight forward solution is likely to simply handle the
brightness change in the kernel and not report the key to userspace at
all. This should work just fine and at least GNOME will show an on
screen display in response to the brightness change.

Do you think that approach would work well?

Benjamin


On Mon, 2018-05-14 at 18:25 -0600, Daniel Drake wrote:
> Hi Andy,
> 
> On Mon, May 7, 2018 at 8:46 AM, Daniel Drake <drake@endlessm.com>
> wrote:
> > > > Some Asus laptops like UX550GE has hotkey (Fn+F7) for keyboard
> > > > backlight toggle. In this UX550GE, the hotkey incremet the
> > > > level
> > > > of brightness for each keypress from 1 to 3, and then switch it
> > > > off when the brightness has been the max. This commit
> > > > interprets
> > > > the code 0xc7 generated from hotkey to KEY_KBDILLUMUP to
> > > > increment
> > > > the brightness, then pass KEY_KBDILLUMTOGGLE to user space
> > > > after
> > > > the brightness max been reached for switching the led off.
> > > > 
> > > 
> > > Pushed to my review and testing queue, thanks!
> > 
> > We found that GNOME's handling of the toggle key is somewhat
> > imperfect
> > and it will need modifying before we achieve the
> > Up-Up-Up-off-Up-Up-Up-off... cycle that we are looking for.
> > 
> > https://gitlab.gnome.org/GNOME/gnome-settings-daemon/issues/41
> > 
> > In that discussion an alternative perspective was raised:
> > 
> > Is it right for the kernel to modify the key sent to userspace,
> > when
> > it is then relying on the specific userspace action of it changing
> > the
> > brightness to the next expected level? (and this userspace
> > behaviour
> > is not even working right in the GNOME case)
> > 
> > Instead, would it make sense for the kernel to always report TOGGLE
> > in
> > this case, and for GNOME to interpret toggle as simply "cycle
> > through
> > all the available brightness levels"?
> 
> Any comments on this? I am tempted to send a patch to just make this
> key always emit TOGGLE from the kernel given that we have a tentative
> agreement on implementing the brightness cycle within GNOME.
> 
> Daniel
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAlr6434ACgkQq6ZWhpmF
Y3D97A/9Hqi/xvHU5jcgtKQ2AH3pN445whjXrnUPpcN3I6zgeo/2kXHxn+DEFzD/
xsBLRy2hzfvw5HXWsclf8u31TajmP9OOihHTMB+Ng7ZJohIEgwPjIMr/eaHiiLYr
W9aamm/5DJF5cwYXmiQ46+y+Wbc5ZJbu0wSgiMDY2uEhlph/9J3NGRadb6xEWJX+
Rrp2te5lqwIvHKv4tF/HOrXev6R77AdpHy+WYrA1IKdG996kFDAZcLErk5EL/J0U
+p+pkGbul/JHKcwU77L/Sg8daM1GMQfxWKbR9k21Fow27iaJRMn9Vn9s8HEmHJ+5
S8cBIo71EjNHXO2oDaSzI9Ng1q+Zy7XjHtbK8/MmauQ/3n/z3tt8ZkW4/FumdMkm
ZZwmS9OxOTc+G9hc3SLkggRF1ygbaCgsZaynyEiBHSq37V0G9WBL6BaDW9P6jEIV
7aPJN6SEBLqXStBZiwNXn/yr1AC7duhnIvzxYZj/SUdCk18aDS/tGIehGTqTumGV
2jhyHQek2fp7J0AZH8oOnU9rAIdKtPb3vf5DJuCOD2TtB/yMZDJVj1Uc1g565IPs
KcVdMdiqTy7m65BAwjJyrFu04GIi02SBFFEsdKGOkAcuPPWpG+4EnUwGpArwxwYv
SaUnUD4DRvsoyZHeXETsa7ePh9aBZwmNR+AGSoLj8UY+vbh3/dg=
=szZs
-----END PGP SIGNATURE-----

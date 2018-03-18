Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeCRKyh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 06:54:37 -0400
Received: from relay0.mail.gandi.net ([217.70.178.220]:57651 "EHLO
        relay0-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751635AbeCRKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 06:54:33 -0400
X-Originating-IP: 109.112.88.148
Date: Sun, 18 Mar 2018 11:54:22 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 2/4] sh: ecovec24: conditionally register backlight device
Message-ID: <20180318105422.GA3323@w540>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-3-dmitry.torokhov@gmail.com>
 <20180316100748.GH16424@w540>
 <20180316233800.GA32310@dtor-ws>
 <20180317092516.g5p5ybka57abyhex@apu3b>
 <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrian,

On Sat, Mar 17, 2018 at 07:21:17PM +0900, John Paul Adrian Glaubitz wrote:
>
>
> > On Mar 17, 2018, at 6:25 PM, jacopo mondi <jacopo@jmondi.org> wrote:
> >
> > Hi Dmitry,
> >
> >> On Fri, Mar 16, 2018 at 04:38:00PM -0700, Dmitry Torokhov wrote:
> >> Hi Jacopo,
> >>
> >>> On Fri, Mar 16, 2018 at 11:07:48AM +0100, jacopo mondi wrote:
> >>> Hello Dmitry
> >>>
> >>> FYI I am brushing the ecovec board these days as well
> >>> https://www.spinics.net/lists/linux-sh/msg52536.html
> >>>
> >>
> >> What is the ecovec board BTW? Is it some devkit or what? It seems quite
> >> old to me.
> >
> > Yes, it is a SuperH 4 based development board. It is old for sure. I'm
> > also working on removing some stuff the ecovec board file is the only
> > user of...
>
> Umh, but I=E2=80=99m still using the SH7724 Evovec board. Please don=E2=
=80=99t remove support for that.
>
> The SuperH port of the Linux kernel is still maintained.

Sorry if I was not clear here, it is not anyone's intention to remove any
support for any SH board. The media subsystem is working to replace
some components (the legacy camera drivers) a few SH boards (ecovec
included) are the only remaining user of. Nobody is working to remove
support for those boards.

I have access to a few SH boards, if you're planning to collect that
informations in some wiki, I'll list myself there.

Thanks
   j

>
> Adrian
>
> >
> >>> And I have a board to test with but without any display panel, I'm
> >>> afraid.
> >>>
> >>>> On Thu, Mar 15, 2018 at 03:42:00PM -0700, Dmitry Torokhov wrote:
> >>>> Commit fe79f919f47e ("sh: ecovec24: Use gpio-backlight") removed cus=
tom
> >>>> backlight support and switched over to generic gpio-backlight driver=
=2E The
> >>>> comment when we run with DVI states "no backlight", but setting
> >>>> gpio_backlight_data.fbdev to NULL actually makes gpio-backlight to r=
eact to
> >>>> events from any framebuffer device, not ignore them.
> >>>>
> >>>> We want to get rid of platform data in favor of generic device prope=
rties
> >>>> in gpio_backlight driver, so we can not have kernel pointers passed =
around
> >>>> to tie the framebuffer device to backlight. Assuming that the intent=
 of the
> >>>> above referenced commit was to indeed not export backlight when usin=
g DVI,
> >>>> let's switch to conditionally registering backlight device so it is =
not
> >>>> present at all in DVI case.
> >>>>
> >>>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>>> ---
> >>>> arch/sh/boards/mach-ecovec24/setup.c | 24 +++++++++++++++++-------
> >>>> 1 file changed, 17 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/m=
ach-ecovec24/setup.c
> >>>> index 6f929abe0b50f..67633d2d42390 100644
> >>>> --- a/arch/sh/boards/mach-ecovec24/setup.c
> >>>> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> >>>> @@ -368,7 +368,6 @@ static struct platform_device lcdc_device =3D {
> >>>> };
> >>>>
> >>>> static struct gpio_backlight_platform_data gpio_backlight_data =3D {
> >>>> -    .fbdev =3D &lcdc_device.dev,
> >>>>    .gpio =3D GPIO_PTR1,
> >>>>    .def_value =3D 1,
> >>>>    .name =3D "backlight",
> >>>> @@ -987,7 +986,6 @@ static struct platform_device *ecovec_devices[] =
__initdata =3D {
> >>>>    &usb1_common_device,
> >>>>    &usbhs_device,
> >>>>    &lcdc_device,
> >>>> -    &gpio_backlight_device,
> >>>>    &ceu0_device,
> >>>>    &ceu1_device,
> >>>>    &keysc_device,
> >>>> @@ -1077,6 +1075,8 @@ static int __init arch_setup(void)
> >>>> {
> >>>>    struct clk *clk;
> >>>>    bool cn12_enabled =3D false;
> >>>> +    bool use_backlight =3D false;
> >>>> +    int error;
> >>>>
> >>>>    /* register board specific self-refresh code */
> >>>>    sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF |
> >>>> @@ -1193,9 +1193,6 @@ static int __init arch_setup(void)
> >>>>        lcdc_info.ch[0].lcd_modes        =3D ecovec_dvi_modes;
> >>>>        lcdc_info.ch[0].num_modes        =3D ARRAY_SIZE(ecovec_dvi_mo=
des);
> >>>>
> >>>> -        /* No backlight */
> >>>> -        gpio_backlight_data.fbdev =3D NULL;
> >>>> -
> >>>>        gpio_set_value(GPIO_PTA2, 1);
> >>>>        gpio_set_value(GPIO_PTU1, 1);
> >>>>    } else {
> >>>> @@ -1217,6 +1214,8 @@ static int __init arch_setup(void)
> >>>>        /* enable TouchScreen */
> >>>>        i2c_register_board_info(0, &ts_i2c_clients, 1);
> >>>>        irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
> >>>> +
> >>>> +        use_backlight =3D true;
> >>>>    }
> >>>>
> >>>>    /* enable CEU0 */
> >>>> @@ -1431,8 +1430,19 @@ static int __init arch_setup(void)
> >>>>    gpio_set_value(GPIO_PTG4, 1);
> >>>> #endif
> >>>>
> >>>> -    return platform_add_devices(ecovec_devices,
> >>>> -                    ARRAY_SIZE(ecovec_devices));
> >>>> +    error =3D platform_add_devices(ecovec_devices,
> >>>> +                      ARRAY_SIZE(ecovec_devices));
> >>>
> >>> I would invert this.
> >>> Register the backlight first, then all other devices.
> >>
> >> We could do that, but why would that be better?
> >>
> >
> > That if backlight device registration fails we do not register all
> > other devices. But yes that may be a bit too harsh, isn't it?
> >
> >>>
> >>>
> >>>> +    if (error)
> >>>> +        return error;
> >>>> +
> >>>> +    if (use_backlight) {
> >>>> +        error =3D platform_device_add(&gpio_backlight_device);
> >>>> +        if (error)
> >>>> +            pr_warn("%s: failed to register backlight: %d\n",
> >>>> +                error);
> >>>
> >>> Could you use dev_warn here? Also the format is wrong, I assume you
> >>
> >> I would rather not, as the backlight device would be in unknown state
> >> here, and using dev_warn with device that has not been fully registered
> >> does not give any benefits. There is also no ambiguity as there is only
> >> one backlight.
> >
> > You are very correct, sorry for the fuss.
> >
> >>
> >>> are missing a '__func__' as second function argument.
> >>
> >> I'll fix this.
> >>
> >>>
> >>> Also, you may want to return error.
> >>
> >> How would caller handle this error? Should we kill all successfully
> >> registered devices on error adding backlight?
> >
> > As the function returned an error code for 'platform_add_devices()' I
> > thought we may want to return one as well. That's why I proposed to
> > invert the registration order :)
> >
> > All minor nits btw,  sorry for jumping up, I understand this is an
> > RFC and ecovec board file is not the real juice of this series ;)
> >
> > Ping me if I can help with testing as I've the board.
> >
> > Thanks
> >   j
> >
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJarkVeAAoJEHI0Bo8WoVY8p08QAIjKZjH8cGxLseindkdPZINL
kIuBohRDbNz4QDZ4vp8TcTU6mJ1vw4X/vFSN6FfmUfXIIqzYxzM3IfXObGyB4px3
HKV/uPtYCnatF0cWsxvbDwvqNjbLYHyzvMIBtrwlBSy1/9qJnUO/g+eusaktrtXe
Lis3gNDQCBzDL6MFVhaOiIHpjivmyIOeawBSxjgUX+AZeykSP1N2s2FSZ3m+gjnK
+/cxmEtXotkSoasYwwPYdqPmQF6D5n2NNEN3tMdYvgHWmRjJrDUER9bXa+LizxVb
sOigAwQd3NE/SGKbiMwNZlmEfzH6glyIy+9ZuPZ32SwqEmu+l40dCiw9dTFoTjOo
o/s4ueDW7E2xzIwGd7hnSGcGMObI0QLCTnLsDMcPS6SAVXE63hnAlNYFXuz1KZle
jGbSXax5y5vWrHrFFsmjOJskqvuzcTMGwMJufVpgbTTam2ahfB1Wij7khPbAtOmY
1UgG0+WlRVzKF3LKlQ+LuIy1VaahZlpAAODU5b1gGHY7JLWOJXh1RVCxbhaRc/e+
TfLcNRkSesXh0p+sWqQ12AMxWMOILHUaNS7ic3x++/x86vuTG4Sk56Roth5ClbCa
XBXzsCd8fw43Vo/oJcFrKg+WVKaZP77N0SbePn4+m/bgZNFYG8rsecnUX5uC11ZV
X3LzV52uNaEqrTpVcmv2
=sibO
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

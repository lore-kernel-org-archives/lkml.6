Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C13C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C647321470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9k+JZFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C647321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJDP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:28:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42248 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:28:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so7585441lje.9;
        Thu, 04 Oct 2018 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cx516kyabYnmxO4i3aOALeXoAAejlKgwu8cPMWMUzdg=;
        b=c9k+JZFYDRdrZaEyrSLdOnTCf7A8x1QeRHvOjMJA+PwVazf8jiL3welioCVixMWdfX
         Xmo4Qkcoypgj4OGHLg6t5vZqaqDTh5oSj7IKMdjjNp9UmpCiJaSRikPkOENIdsR1o7WZ
         M7XVcrPECwcVouk/pZ5glcOMOKfb6jtPhGkyOkoDGOVwqLzvRvyIQMWmm8zigfnuDL+L
         UmI8HUZ3hMyey8Esq3BakbqwXXzzPl+KIGvi45soUc781HSDNhMUuFo8wvjTJwsE7PSS
         vqos+S45+KaGC36DEO7SXevLs4hcPwDumqrXI6fojbyEYu5UtjN5uinftQ/w9daa2rNZ
         C7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cx516kyabYnmxO4i3aOALeXoAAejlKgwu8cPMWMUzdg=;
        b=QNLSlwpGeYfUM+WmMxJrR2pNPEMsO5bRPZKFkJW2+k19+24xs6e+1A3qM0RYXJgtJo
         cltdOwyeQDZU0k6xhFJIkeCLiqTqOLGhy47fnUyB+hcSnPaEXV1LREHFzqzTKq28cSpJ
         l2lWq9ncNmfmmMFMlZ/Qi4jTdXdcjhxYfB8AmejG8rVnYtKY2G23rqZ+m2w5D88R0MoT
         lSw3AwRZA1rd26tkQEyBPMMWA4VRWBK9oddKwx9V8IpquRXfCIc9ergYOZmX25aKf2cw
         EGfSMV7ldM264L960sbjyztbgWuIWiny7uNdhRNKsWadvGdXv+CnQ1/h7f7enHSu+YBj
         F9Pw==
X-Gm-Message-State: ABuFfogZ1n0gsx1NC4fqDNFlwXJsqgvtDgH6q42bv++95gLrX10Q/5tf
        oyfT3OggScHzIKh9U4haNCCdg+ALc8yQLvZBGgE=
X-Google-Smtp-Source: ACcGV60EBlPbLHWdFATwUYKWON55GGockOMf612YHz9XWwLyhXHFsiblxue4Rx7fBuu5in2mh8PAltn41zvSgP7r9Ls=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr3440889lji.140.1538642151722;
 Thu, 04 Oct 2018 01:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
 <20181003193859.23928-7-ricardo.ribalda@gmail.com> <20181003232702.4c18e725@bbrezillon>
 <CAPybu_3M75E9c+JmR7MVKsyv3vYPOrZ6qBABtvEF317KA+roBg@mail.gmail.com>
 <20181004001415.224d53fe@bbrezillon> <20181004001924.3644185d@bbrezillon>
In-Reply-To: <20181004001924.3644185d@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 4 Oct 2018 10:35:35 +0200
Message-ID: <CAPybu_1CoBLRx8FjzbXQ7M9KjJot9PF90qu+s8s5OUJ40KpYjw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] dt-binding: mtd: Document gpio-addr-flash
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Boris


On Thu, Oct 4, 2018 at 12:19 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu, 4 Oct 2018 00:14:15 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
> > On Wed, 3 Oct 2018 23:53:27 +0200
> > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> >
> > > Hi Boris
> > > On Wed, Oct 3, 2018 at 11:27 PM Boris Brezillon
> > > <boris.brezillon@bootlin.com> wrote:
> > > >
> > > > On Wed,  3 Oct 2018 21:38:58 +0200
> > > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > > >
> > > > > Add documentation for gpio-addr-flash. This binding allow creating
> > > > > flash devices that are paged using GPIOs.
> > > > >
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > > > ---
> > > > >  .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
> > > > >  1 file changed, 54 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > > > > new file mode 100644
> > > > > index 000000000000..5006a26e1753
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> > > > > @@ -0,0 +1,54 @@
> > > > > +Memory Mapped flash with some address lines addressed using GPIOs
> > > > > +
> > > > > +Handle the case where a flash device is mostly addressed using physical
> > > > > +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> > > > > +to a 2MiB memory range and use the GPIOs to select a particular range.
> > > > > +
> > > > > + - compatible : "cfi-gpio-addr-flash"
> > > > > + - reg : Address range of the mtd chip that is memory mapped, this is,
> > > > > +   on the previous example 2MiB.
> > > > > + - bank-width : Width (in bytes) of the bank.  Equal to the
> > > > > +   device width times the number of interleaved chips.
> > > > > + - gpios: List of GPIO specifiers that will be used to address the MSBs address
> > > > > +   lines. The order goes from LSB to MSB.
> > > > > + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> > > > > +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
> > > >
> > > > Looks like other bindings are encoding the probe type in the
> > > > compatible [1][2], and we should probably follow what's been done by
> > > > others.
> > >
> > > If I understood it right, they are special cases of physmap_of_core.c
> > > https://elixir.bootlin.com/linux/v4.18.11/source/drivers/mtd/maps/physmap_of_core.c#L242
> > >
> > > The driver that handles the compatible is physmap_of_core.c, and afaik
> > > multiple drivers with the same
> > > compatible string is a very bad idea.
> >
> > Yes, I know.
> >
> > >
> > > We can convert the driver to something like Versatile or gemini, but
> > > then we will not support platform devices
> > >
> > > btw, the binding that I am used is used by:
> > > https://elixir.bootlin.com/linux/v4.18.11/source/drivers/mtd/maps/physmap_of_core.c#L91
> >
> > Actually, the more I think about it the more I realize this should
> > somehow be integrated to the physmap core logic. I mean, there's nothing
> > controller/platform specific in what the gpio-physmap driver does.
> >
> > We could basically add the msb_addr_gpios related fields to map_info,
> > let physmap.c and physmap_of_core.c call
> > devm_gpiod_get_array_optional() and, based on the returned value,
> > call simple_map_init() (when the pointer is NULL) or
> > gpio_addr_map_init() (when the pointer is valid).
>
> Or even better, let simple_map_init() call gpio_addr_map_init() when
> map->addr_gpios != NULL, so that you don't even have to duplicate the
> selection logic in physmap.c and physmap_of_core.c.
>

I am all in for the removal of duplicated code. But I have implemented
it slightly different, following gemini and versatile

In physmap_of_core.c

I have added

err = of_flash_probe_gpio(dev, dp, &info->list[i].map);
if (err){
iounmap(info->list[i].map.virt);
goto err_out;
}

and on gpio-addr-flash the code for DT is simply

int of_flash_probe_gpio(struct platform_device *pdev, struct device_node *np,
struct map_info *map)
{
struct async_state *state;

if (!of_device_is_compatible(np, "mtd,gpio-addr-flash"))
return 0;

state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
if (!state)
return -ENOMEM;

return gpio_flash_probe_common(&pdev->dev, state, map);
}

You can take a look to the code at
https://github.com/ribalda/linux/tree/gpio-addr-flash-v6

once it is tested on hw I will commit to the list

I think now we are getting into something quite good :)

Thanks!

> >
> > gpio_addr_map_init() would still be implemented in gpio-addr-flash.c so
> > that we can still enable/disable support for this feature (providing
> > dummy wrappers when it's disabled). By doing that, we also keep a single
> > driver which matches a generic compatible string. We also stay
> > compatible with .c based board files.
>


-- 
Ricardo Ribalda

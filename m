Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeBBFV3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:21:29 -0500
Received: from mx.socionext.com ([202.248.49.38]:39515 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeBBFVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:21:23 -0500
Date: Fri, 02 Feb 2018 14:21:21 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] fbdev: simplefb: add support for 'memory-region' property on DT node
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
In-Reply-To: <CAHp75VfTrEELX9kKjZ7zmM8V=ZxbfAPbEDozG1i0A4P6gUjnEA@mail.gmail.com>
References: <2359956.Z9lQWSAgHb@amdc3058> <CAHp75VfTrEELX9kKjZ7zmM8V=ZxbfAPbEDozG1i0A4P6gUjnEA@mail.gmail.com>
Message-Id: <20180202142121.CEB8.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, 1 Feb 2018 21:03:30 +0200 <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 1, 2018 at 5:56 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Tuesday, January 23, 2018 08:34:56 PM Kunihiko Hayashi wrote:
> >> Enables 'memory-region' property referring to the memory description on
> >> the reserved-memory node in case of devicetree use.
> >> If there is no 'reg' property that specifies the address and size of
> >> the framebuffer, the address and size written in the memory description
> >> on the reserved-memory node can be used for the framebuffer.
> >>
> >> Furthermore, the reserved-memory node needs to have "no-map" attributes
> >> because simplefb driver maps the region by ioremap_wc().
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> >> +- memory-region: phandle to a node describing memory region as framebuffer
> >> +              memory instead of reg property. The node should include
> >> +              'no-map'.
> 
> >>       mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +     if (!mem)
> >> +             mem = simplefb_parse_dt_reserved_mem(&pdev->dev);
> 
> I'm not sure I understood why you need this entire function?
> 
> Put your memory resource ('reg' property) as part of reserved memory
> with necessary flags.

Surely we prepare a memory resource as a part of reserved memory,
for example:

	reserved-memory {
		fb_area: memory@0xa0000000 {
			reg = <0xa0000000 0x400000>;
			no-map;
		};
	};

And we need to specify the address and size as a reg property in
the framebuffer node.

	framebuffer {
		compatible = "simple-framebuffer";
		reg = <0xa0000000 0x400000>;
	};

This function allows us to specify the area with phandle to
the reserved memory instead of same address and size.

	framebuffer {
		compatible = "simple-framebuffer";
		memory-region = <&fb_area>;
	};

If both reg and memory-region properties are specified
in the framebuffer node, the reg propery will be applied.

---
Best Regards,
Kunihiko Hayashi

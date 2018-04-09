Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeDIVuL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:50:11 -0400
Received: from gloria.sntech.de ([95.129.55.99]:39302 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbeDIVuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:50:10 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        open list <linux-kernel@vger.kernel.org>, jcliang@chromium.org,
        simon xue <xxm@rock-chips.com>, tfiga@chromium.org,
        Romain Perier <romain.perier@collabora.com>,
        Yakir Yang <kuankuan.y@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Liang Chen <cl@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Mark Yao <markyao0591@gmail.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 07/14] ARM: dts: rockchip: add clocks in iommu nodes
Date: Mon, 09 Apr 2018 23:49:58 +0200
Message-ID: <5686492.Vgpi8vPSL1@diego>
In-Reply-To: <2255884.b1SkkUdh3X@diego>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com> <df522a01-6f4a-bb96-4423-19965b078a1b@arm.com> <2255884.b1SkkUdh3X@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. April 2018, 17:55:40 CEST schrieb Heiko Stübner:
> Am Montag, 9. April 2018, 17:53:01 CEST schrieb Robin Murphy:
> > On 09/04/18 16:44, Heiko Stübner wrote:
> > > Hi Tomeu,
> > > 
> > > Am Montag, 9. April 2018, 16:41:56 CEST schrieb Tomeu Vizoso:
> > >> in today's linux-next, the DRM driver fails to probe because the iommu
> > >> driver fails to find the aclk. I need to apply this patch for things
> > >> to work again.
> > > 
> > > Thanks for catching that issue.
> > > 
> > > This seems to expose a backwards-compatibility issue, as this breaks
> > > all old devicetrees, so should get a proper fix, apart from me applying
> > > the dt-patch I missed.
> > > 
> > > Looking at the iommu-clock-handling patch, I imagine this part as
> > > the culprit:
> > > 
> > > +	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
> > > +	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> > > +				     sizeof(*iommu->clocks), GFP_KERNEL);
> > > +	if (!iommu->clocks)
> > > +		return -ENOMEM;
> > > 
> > > The clk-bulk functions seem to work with simple for loops and
> > > should (as the other standard clock functions) just work fine with
> > > an empty struct, so I guess a simple
> > > 
> > > 	if (!iommu->clocks && iommu->num_clocks > 0)
> > > 	
> > > 		return -ENOMEM;
> > > 
> > > should hopefully be enough. I'll try to give this a test later on
> > > if nobody beats me to it :-)
> > 
> > But iommu->num_clocks is clearly set to a nonzero compile-time constant
> > at this point ;)
> > 
> > I'd assume it's the return from devm_clk_bulk_get() which needs to
> > special-case the "no clocks found" case from any other error, and *then*
> > blat num_clocks to 0 if so.
> 
> you're right of course. Looking at it again, I now clearly see the
> ARRAY_SIZE and am wondering what made me think num_clocks would be
> runtime-read.
> 
> Must be those 25°C today ;-)

In any case, this does not seem to fully fix the issue ... or be more exact 
seems to be the only issue.

- With 4.16 both pinky and kevin have working displays.
- When I was merging display patches to drm-misc, I did boot-tests on
  both pinky and kevin, keeping their displays in a working state.

- With current torvalds head (iommu not merged yet)
e9092d0d9796 ("Fix subtle macro variable shadowing in min_not_zero()")

I get display output on rk3399-kevin (edp), but not on
rk3288-pinky (edp + hdmi). [components + hdmi device+modes get
recognized correctly though]

- With iommu changes merged I end up with the failing clock issue
  which can be countered by making the iommu-clocks optional.

- After that I get working display output again on kevin but not pinky.

Looks like this needs bisecting.

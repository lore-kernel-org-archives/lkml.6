Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeA3ULb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:11:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53657 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeA3UL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:11:29 -0500
X-Google-Smtp-Source: AH8x225E6TdSyIj3LnTEzF9eVxwi1ACmfqvgK47qXuQPf+4b1bRh25dseS9Ld2DJRtj02EUcePq5Cg==
Date: Tue, 30 Jan 2018 21:11:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: exynos: Fix missing missing reg warning
 for syscon restart nodes
Message-ID: <20180130201124.v7jik3ds4kejsa3m@kozik-lap>
References: <20180116213129.16209-1-krzk@kernel.org>
 <20180116213129.16209-2-krzk@kernel.org>
 <20180129162714.2xrqrkfd2xo4jn2g@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180129162714.2xrqrkfd2xo4jn2g@rob-hp-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 10:27:14AM -0600, Rob Herring wrote:
> On Tue, Jan 16, 2018 at 10:31:28PM +0100, Krzysztof Kozlowski wrote:
> > Fix DTC warnings like:
> > 
> >     arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
> >         Node /soc/syscon-poweroff missing or empty reg/ranges property
> >     arch/arm/boot/dts/exynos4412-trats2.dtb: Warning (simple_bus_reg):
> >         Node /soc/syscon-reboot missing or empty reg/ranges property
> > 
> > by moving the syscon poweroff and restart nodes into the PMU (Power
> > Management Unit) node.  The PMU node is the actual block responsible for
> > power management, including typical Exynos on/off/restart procedures.
> > Therefore the syscon poweroff and restart nodes logically belong to it.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Tested on Exynos5420 and Exynos4412. Other tests are welcomed.
> > ---
> >  .../devicetree/bindings/arm/samsung/pmu.txt        |  4 +++-
> >  arch/arm/boot/dts/exynos-syscon-restart.dtsi       | 28 ++++++++++------------
> >  arch/arm/boot/dts/exynos3250.dtsi                  |  4 ++--
> >  arch/arm/boot/dts/exynos4.dtsi                     |  5 ++--
> >  arch/arm/boot/dts/exynos4412.dtsi                  |  2 +-
> >  arch/arm/boot/dts/exynos5.dtsi                     |  1 -
> >  arch/arm/boot/dts/exynos5250.dtsi                  |  3 ++-
> >  arch/arm/boot/dts/exynos5410.dtsi                  |  3 ++-
> >  arch/arm/boot/dts/exynos5420.dtsi                  |  3 ++-
> >  9 files changed, 27 insertions(+), 26 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > index 779f5614bcee..405646655ec7 100644
> > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> > @@ -12,6 +12,8 @@ Properties:
> >  		   - "samsung,exynos5433-pmu" - for Exynos5433 SoC.
> >  		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
> >  		second value must be always "syscon".
> > +		If PMU contains optional syscon-poweroff or syscon-restart nodes,
> > +		then third value must be "simple-mfd".
> 
> I don't think this is right. simple-mfd is only for cases where the 
> parent has no setup that the child nodes are dependent on. You need the 
> regmap setup by the parent before the child can be enumerated. The 
> correct thing to do here is add an of_platform_default_populate() call.

I understand, makes sense. I will send a follow-up.

Thanks for feedback!

Best regards,
Krzysztof

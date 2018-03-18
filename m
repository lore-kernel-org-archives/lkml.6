Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeCRMwc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38487 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754545AbeCRMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:25 -0400
X-Google-Smtp-Source: AG47ELvBN5uAj+o9PYn0u7bQfg0IypxO9B9NMaSFXQIO3achU5n4XqKPYSr7BYwODZhsEtmr7AAMRA==
Date: Sun, 18 Mar 2018 07:52:22 -0500
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: meson: update documentation with
 hhi syscon
Message-ID: <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
 <20180315115545.1884-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315115545.1884-2-jbrunet@baylibre.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
> The HHI register region hosts more than just clocks and needs to
> accessed drivers other than the clock controller, such as the display
> driver.
> 
> This register region should be managed by syscon. It is already the case
> on gxbb/gxl and it soon will be on axg. The clock controllers must use
> this system controller instead of directly mapping the registers.

Sounds like a kernel problem, not a DT one.

> 
> This changes the bindings of gxbb and axg's clock controllers. This is
> due to an initial 'incomplete' knowledge of these SoCs, which is why the
> meson bindings are unstable ATM.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt      | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e2b377ed6f91..e950599566a9 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -10,9 +10,6 @@ Required Properties:
>  		"amlogic,gxl-clkc" for GXL and GXM SoC,
>  		"amlogic,axg-clkc" for AXG SoC.
>  
> -- reg: physical base address of the clock controller and length of memory
> -       mapped region.
> -
>  - #clock-cells: should be 1.
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
> @@ -20,13 +17,22 @@ to specify the clock which they consume. All available clocks are defined as
>  preprocessor macros in the dt-bindings/clock/gxbb-clkc.h header and can be
>  used in device tree sources.
>  
> +Parent node should have the following properties :
> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-gx-hhi-sysctrl" or
> +              "amlogic,meson-axg-hhi-sysctrl"
> +- reg: base address and size of the HHI system control register space.
> +
>  Example: Clock controller node:
>  
> -	clkc: clock-controller@c883c000 {
> +sysctrl: system-controller@0 {
> +	compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
> +	reg = <0 0 0 0x400>;
> +
> +	clkc: clock-controller {

With a single child, there is really no point to this change. A single 
node can provide multiple functions. Look at nodes that are both reset 
and clock providers.

What other functions are there?

Rob

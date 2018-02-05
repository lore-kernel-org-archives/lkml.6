Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbeBEGJZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:09:25 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41402 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeBEGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:36 -0500
X-Google-Smtp-Source: AH8x225bEg4FWmqfCzj2XiE8Bs3pzyEF3318stJJWRe864bVMy+Tac2okZZrUH3pp5Cf4gXweLGf0A==
Date: Mon, 5 Feb 2018 00:08:33 -0600
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
Message-ID: <20180205060833.p56dun5i4bvs3jye@rob-hp-laptop>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <8651585c91ee40f6ab3e30b893bcfb90fe5c2c25.1515639336.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8651585c91ee40f6ab3e30b893bcfb90fe5c2c25.1515639336.git.ryder.lee@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:42:44PM +0800, Ryder Lee wrote:
> As the MediaTek audio hardware block that expose functionalities that are
> handled by separate subsystems in the kernel, and there are registers that
> are shared between related drivers.
> 
> Switch the current device to an MFD device, add more descriptions about the
> subsystem and modify example accordingly.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,audsys.txt      | 37 ++++++++++++++++++----
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> index 9b8f578..677af40 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> @@ -1,22 +1,45 @@
> -MediaTek AUDSYS controller
> +MediaTek Audio Subsystem
>  ============================
> +The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
> +It contains a system controller, which provides a number registers giving
> +access to two features: AUDSYS clocks and Audio Front End (AFE) components.
>  
> +For the top level node:
> +- compatible: must be: "syscon", "simple-mfd";

This should have some SoC specific compatible.

> +- reg: register area of the Audio Subsystem
> +
> +Required sub-nodes:
> +
> +AUDSYS clocks:
> +-------
>  The MediaTek AUDSYS controller provides various clocks to the system.
>  
>  Required Properties:
>  
>  - compatible: Should be one of:
> -	- "mediatek,mt7622-audsys", "syscon"
> +	- "mediatek,mt2701-audsys";
> +	- "mediatek,mt7622-audsys";
>  - #clock-cells: Must be 1
>  
>  The AUDSYS controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
>  The available clocks are defined in dt-bindings/clock/mt*-clk.h.

There's no register range associated with the clocks? If there is, add a 
reg property.

>  
> +AFE components:
> +-------
> +For common binding part and usage, refer to
> +../sonud/mt2701-afe-pcm.txt.
> +
>  Example:
>  
> -audsys: audsys@11220000 {
> -	compatible = "mediatek,mt7622-audsys", "syscon";
> -	reg = <0 0x11220000 0 0x1000>;
> -	#clock-cells = <1>;
> -};
> +	audio-subsystem@11220000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0 0x11220000 0 0x2000>;
> +
> +		audsys: clock {
> +			compatible = "mediatek,mt2701-audsys";
> +			#clock-cells = <1>;
> +		};
> +
> +		...
> +	};
> -- 
> 1.9.1
> 

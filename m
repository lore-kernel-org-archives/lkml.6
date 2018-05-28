Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeE1JGx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:06:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35937 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbeE1JGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:06:47 -0400
X-Google-Smtp-Source: ADUXVKJHScuIS1zkI079ELk42gWo69FFbG9KEGj+8yN4iX4kK3WJOBVhaURVdPe/fSUgXeYQSfDheY31yhlkHt4ljII=
MIME-Version: 1.0
In-Reply-To: <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com> <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 May 2018 11:06:45 +0200
X-Google-Sender-Auth: 6EmE1lCR3gLFbXMqyPa3qLOntrE
Message-ID: <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran, Morimoto-san,

On Fri, Apr 27, 2018 at 6:57 PM, Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
> The DU1 external dot clock is provided by the fixed frequency clock
> generator X21, while the DU0 and DU3 clocks are provided by the
> programmable Versaclock5 clock generator.
>
> Enable the clocks, and the HDMI encoder for the M3-N Salvator-X board
> and hook it up to the HDMI connector.
>
> Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>
> ---
> v2:
>  - Remove LVDS clocks from DU node
>  - Merge DU Clocks and HDMI enablement
> ---
>  .../boot/dts/renesas/r8a77965-salvator-x.dts  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> index 75d890d91df9..340a3c72b65a 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> @@ -19,3 +19,31 @@
>                 reg = <0x0 0x48000000 0x0 0x78000000>;
>         };
>  };
> +
> +&du {
> +       clocks = <&cpg CPG_MOD 724>,
> +                <&cpg CPG_MOD 723>,
> +                <&cpg CPG_MOD 721>,
> +                <&versaclock5 1>,
> +                <&x21_clk>,
> +                <&versaclock5 2>;
> +       clock-names = "du.0", "du.1", "du.3",
> +                     "dclkin.0", "dclkin.1", "dclkin.3";
> +};
> +
> +&hdmi0 {
> +       status = "okay";
> +
> +       ports {
> +               port@1 {
> +                       reg = <1>;
> +                       rcar_dw_hdmi0_out: endpoint {
> +                               remote-endpoint = <&hdmi0_con>;
> +                       };
> +               };
> +       };
> +};
> +
> +&hdmi0_con {
> +       remote-endpoint = <&rcar_dw_hdmi0_out>;
> +};

I think the hdmi0 and hdmi0_con parts can be moved to salvator-common.dtsi.
Can we do that now (with stubs?), or does this have to wait until r8a77965 has
received HDMI sound support?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

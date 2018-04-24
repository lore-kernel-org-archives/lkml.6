Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524548937; cv=none;
        d=google.com; s=arc-20160816;
        b=gv4twQ1Rs8LULQ98QSbFd31MBpMZJD1sAYFMmkBSokOmzw4EjTzTioNqPFDH0g2Pxa
         5dXPLYxbZCsu2XkbjJivWQqv6cjPA3+SJET2qGNPkGKO+1saZNdo2dZ20NX1FGn+dQHr
         5en3YlB1yglRN81GDqAhaha7ssj3U5vC3Q4L5xEwq0rB3mZM8D3imRlMSiPK0lQafpQ0
         TN5ISEfUjUE21+dNGw0FslGjm8647xlNZSgkxJg3vHrMi80IgpxDkuGpPamJaoH58M9S
         drgiIN0kiaOr3aPdtTKHC0yQTPOPesKAeJr847xBPvF8pv5eouvQkKKWgk55nd3VxT7J
         u3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=1TincGWN5Aomnh8Bb4y2N3P+xwFTVwhvtlktGB0R5VY=;
        b=Dg3Ksew5P3f84dQXdApNu+bc9TUtTubcYxquL//4DHhRnobfeEE6s0tYZsLWjbayBn
         JPhhmLjccjBTd+dmQKNCY8i1gSKaILqvQMj1aGaBy1fMdayXpukVyzGDk2goa3gpRDYx
         VUw6HC+/igOOiSZgQKRYf0+ki4ta4Is8Hw7I1XVUp0dcjMMORhJL1VDxAJaoTkjZoTYV
         gL5TK+IxWABxcSMxSDxy8YYV4a2i+XBkKTKi1Jz3EVABj6al5G6g8WsgUy54nox275pS
         qr1qTpKQa5hQDqdKGknnC+x6VQ9yjtZrCrfhjv6B8tj1ixyy1JQYNE4H46bTYipx68fl
         21bg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ILnX4cl4;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ILnX4cl4;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49aqOcP7iqhO60jY26D4FPvCRmFRdNUm7qGTBKGl4lYJhvy3IuSpX1LzBjSX5n4ExC/Asi38g==
Date: Tue, 24 Apr 2018 06:48:54 +0100
From: Lee Jones <lee.jones@linaro.org>
To: matthias.bgg@kernel.org
Cc: ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
	robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
	sboyd@codeaurora.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, mchehab@kernel.org,
	rdunlap@infradead.org, pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com, linux-clk@vger.kernel.org,
	linux@armlinux.org.uk, matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: Re: [v2 00/10] arm/arm64: mediatek: Fix mmsys device probing
Message-ID: <20180424054854.bpd6h3imazhqnuy3@dell>
References: <cover.1524497268.git.mbrugger@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551533402013398?=
X-GMAIL-MSGID: =?utf-8?q?1598605427170602311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> Changes since v1:
> - add binding documentation
> - ddp: use regmap_update_bits
> - ddp: ignore EPROBE_DEFER on clock probing
> - mfd: delete mmsys_private
> - add Reviewed-by and Acked-by tags

I'm confused by the double submission.

Please can you send it again completely detached from the first and
the second submissions please?

> ---
> 
> MMSYS in Mediatek SoCs has some registers to control clock gates (which is 
> used in the clk driver) and some registers to set the routing and enable
> the differnet blocks of the display subsystem.
> 
> Up to now both drivers, clock and drm are probed with the same device tree
> compatible. But only the first driver get probed, which in effect breaks
> graphics on mt8173 and mt2701.
> 
> This patch set introduces a new mfd device, which binds against the mmsys
> compatible and takes care of probing the needed devices. It was tested on the
> bananapi-r2 and the Acer R13 Chromebook.
> 
> 
> Matthias Brugger (10):
>   dt-bindings: mediatek: mmsys: Add support for mfd
>   drm/mediatek: Use regmap for register access
>   mfd: mtk-mmsys: Add mmsys driver
>   drm/mediatek: mt2701: switch to mfd probing.
>   clk: mediatek: mt2701-mm: switch to mfd device
>   mfd: mtk-mmsys: Add mt8173 nodes
>   drm/mediatek: Add mfd support for mt8173
>   clk: mediatek: mt8173-mm: switch to mfd device
>   drm: mediatek: Omit warning on probe defers
>   MAINTAINERS: update Mediatek Soc entry
> 
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 -
>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 +++++++
>  MAINTAINERS                                        |  2 +
>  drivers/clk/mediatek/clk-mt2701-mm.c               | 10 +--
>  drivers/clk/mediatek/clk-mt8173.c                  | 17 +++-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 41 ++++------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 33 ++++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +-
>  drivers/mfd/Kconfig                                |  9 +++
>  drivers/mfd/Makefile                               |  2 +
>  drivers/mfd/mtk-mmsys.c                            | 93 ++++++++++++++++++++++
>  14 files changed, 189 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>  create mode 100644 drivers/mfd/mtk-mmsys.c
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

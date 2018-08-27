Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB380C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7105D208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7105D208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH0XMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:12:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50511 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeH0XMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:12:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A71A2079D; Mon, 27 Aug 2018 21:24:51 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 953A120711;
        Mon, 27 Aug 2018 21:24:50 +0200 (CEST)
Date:   Mon, 27 Aug 2018 21:24:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
Message-ID: <20180827212449.723bdc99@bbrezillon>
In-Reply-To: <20180825085620.10566-1-peda@axentia.se>
References: <20180825085620.10566-1-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 10:56:16 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> The background for these patches is that our PCB interface between
> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
> this has to be described somewhere, or the atmel-hlcdc driver have no
> chance of selecting the correct output mode. Since we have similar
> problems with a tda19988 HDMI encoder I added patches to override
> the atmel-hlcdc output format via DT properties compatible with the
> media video-interface binding and things start to play together.

Queued to drm-misc-next.

Thanks,

Boris

> 
> Cheers,
> Peter
> 
> Changes since v8  https://lkml.org/lkml/2018/8/10/309
> - go back to the solution in v7 (but the ep device_node leak fixed)
>   for patch 4/4
> - redo (part of) 3/4 w/o using the disliked of_graph_parse_endpoint
> 
> Changes since v7  https://lkml.org/lkml/2018/8/4/288
> - The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
>   which simplifies fixing this in patch 4/4 (and adds flexibility)
>   and adjust patch 4/4 to the changes done in the new 3/4.
> - return -ENOMEM on allocation failure in patch 4/4
> 
> Changes since v6  https://lkml.org/lkml/2018/8/3/333
> - zap bus-type from the binding in patch 2/3
> 
> Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
> - add reg properties (and #*-cells) to the example in patch 2/3
> - prohibit bus-width 0 in the device-tree in patch 3/3
> - added reviewed-by from Jacopo to patch 2/3 and 3/3
> 
> Peter Rosin (4):
>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>   dt-bindings: display: atmel: optional video-interface of endpoints
>   drm/atmel-hlcdc: always iterate over the first 4 output endpoints
>   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
> 
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 23 ++++++
>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++-----
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 92 +++++++++++++++++++---
>  5 files changed, 163 insertions(+), 31 deletions(-)
> 


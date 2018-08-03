Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CD3C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ABB2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IumrAL/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABB2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbeHCKtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:49:55 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41856 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeHCKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:49:55 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58ACA112;
        Fri,  3 Aug 2018 10:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533286474;
        bh=2v10gNDERp1KH9zbX89NMR08xJXBkXNaTYS3bU3jGqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IumrAL/smnaAVto2r1TKeq35sVXcSfPhJQikzIWn/6XdsP6eEQFdK3uQJq1VHOXwQ
         6pL5YkeYQ7HuvGBn1Q/q/UggBj4eHj3HpXkv0nULNu8BG0pJheX/72KnrxUBG3rnQg
         iPej69QL0vUhT9Vf4oKeUVZjoilNPa0eEnBVmLgc=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jacopo mondi <jacopo@jmondi.org>, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
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
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional video-interface of endpoints
Date:   Fri, 03 Aug 2018 11:55:14 +0300
Message-ID: <3057649.ixkh6hxoBL@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
References: <20180803072308.14962-1-peda@axentia.se> <20180803081128.GA4528@w540> <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

(CC'ing Sakari Ailus)

On Friday, 3 August 2018 11:40:02 EEST Peter Rosin wrote:
> On 2018-08-03 10:11, jacopo mondi wrote:
> > On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
> >> With bus-type/bus-width properties in the endpoint nodes, the video-
> >> interface of the connection can be specified for cases where the
> >> heuristic fails to select the correct output mode. This can happen
> >> e.g. if not all RGB pins are routed on the PCB; the driver has no
> >> way of knowing this, and needs to be told explicitly.
> >> 
> >> This is critical for the devices that have the "conflicting output
> >> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> >> RGB bits move around depending on the selected output mode. For
> >> devices that do not have the "conflicting output formats" issue
> >> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> >> 
> >> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >> 
> >>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26
> >>  ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt index
> >> 82f2acb3d374..9de434a8f523 100644
> >> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> >> 
> >> @@ -15,6 +15,14 @@ Required children nodes:
> >>   to external devices using the OF graph reprensentation (see
> >>   ../graph.txt).
> >>   At least one port node is required.
> >> 
> >> +Optional properties in grandchild nodes:
> >> + Any endpoint grandchild node may specify a desired video interface
> >> + according to ../../media/video-interfaces.txt, specifically
> >> + - bus-type: must be <0>.
> > 
> > Is there any value in specifying this, if it has a fixed value to
> > "autodetect"? I understand it's optional, so if nobody else objects,
> > feels free to keep it there.
> 
> That's just how media/video-interfaces.txt works.
> 
> bus-type 0 means that other properties describe the bus type. In this
> case bus-width is specified, so that means a parallel bus. But bus-width
> has no meaning (or may not have) if bus-type is non-zero. But checking
> that bus-type for zero in the code seemed like overkill to me since the
> driver already knows that it is a parallel bus...
> 
> TL;DR I'd like to keep it.

Sakari told me recently that he was planning to introduce explicit bus types 
for parallel buses (both external sync and BT.656). Sakari, do you want to 
comment on this ?

> >> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> >> +   override any output mode selection heuristic, forcing "rgb444",
> >> +   "rgb565", "rgb666" and "rgb888" respectively.

[snip]

-- 
Regards,

Laurent Pinchart




Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4C3206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L8mS154e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4C3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440026AbeKXBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:17:25 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43000 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390803AbeKXBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:17:25 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7782C58E;
        Fri, 23 Nov 2018 15:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542983578;
        bh=YPMBMQ16VTd7MCop0s8+RVEEOYhmKON9fwj3e9K3SmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8mS154ehwvhoUs4Suec+UA9vxZ4RuTvJjoI3ECXhmMTKkpO4bKPvxdR6WabtarUX
         woshI+GvqbbbnIzWRkgQMqsMLLi5WMYfWNK0spX13BnhNotzfd0zk/mLAJ2aDdhnfi
         AN3tG3sh7qOiBidJLyYZk3meR1EmkvMjYiF0LRCw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
Subject: Re: [PATCH RFC 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
Date:   Fri, 23 Nov 2018 16:33:18 +0200
Message-ID: <18593437.RcPPLLf6y1@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <ca86b176-603b-8983-f6af-95e2bdce4aab@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com> <1880382.AeP59NOuia@avalon> <ca86b176-603b-8983-f6af-95e2bdce4aab@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Friday, 23 November 2018 16:29:15 EET Neil Armstrong wrote:
> On 23/11/2018 15:25, Laurent Pinchart wrote:
> > On Friday, 23 November 2018 16:02:14 EET Neil Armstrong wrote:
> >> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> >> Scrambling when supported or mandatory.
> >> 
> >> This patch also adds an helper to setup the control bit to support
> >> the hight TMDS Bit Period/TMDS Clock-Period Ratio as required with
> > 
> > s/hight/high/ ?
> 
> Thanks for catching !
> 
> >> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> > 
> > Why do you need a helper for this, is there no way it could be handled
> > internally ?
> 
> I could, but all the platforms would also do it internally... seems better
> to have common helper, no ? And it will be usable by the PHY models handler
> in the dw-hdmi driver aswell.

I meant internally in the dw-hdmi driver, not in the glue layer.

> >> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> >> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> >> on the Rockchip 4.4 BSP kernel at [1]
> >> 
> >> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> >> 
> >> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> >> Cc: Huicong Xu <xhc@rock-chips.com>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >> 
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++++++++++++--
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
> >>  include/drm/bridge/dw_hdmi.h              |  1 +
> >>  3 files changed, 44 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> >> 5971976284bf..523508af70b0 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c

[snip]

> >> @@ -1562,6 +1581,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
> >>  		vsync_len /= 2;
> >>  	}
> >> 
> >> +	/* Scrambling Control */
> >> +	if (hdmi_info->scdc.supported) {
> >> +		if (vmode->mpixelclock > 340000000 ||
> >> +		    hdmi_info->scdc.scrambling.low_rates) {
> >> +			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
> >> +				       &bytes);
> >> +			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
> >> +					bytes);
> > 
> > Shouldn't the source version be min(sink version, highest supported source
> > version) ?
> 
> How should the "highest supported source version" be defined ?

That's the highest version supported by the DW HDMI TX controller, and is an 
intrinsic property of the IP core. With the above code, a sink newer than the 
DW HDMI TX will incorrectly be told that the source supports the same version 
as the sink.

> >> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
> >> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> >> +				    HDMI_MC_SWRSTZ);
> >> +			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
> >> +		} else {
> >> +			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
> >> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> >> +				    HDMI_MC_SWRSTZ);
> >> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
> >> +		}
> >> +	}
> >> +
> >>  	/* Set up horizontal active pixel width */
> >>  	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
> >>  	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);

[snip]

-- 
Regards,

Laurent Pinchart




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDSLAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:00:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34934 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeDSLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:00:40 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Philippe CORNU <philippe.cornu@st.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH 2/2] drm/bridge: sii902x: add optional power supplies
Date: Thu, 19 Apr 2018 14:00:47 +0300
Message-ID: <2003583.WmldKZVqDK@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <ea6fbdbe-6ce5-0110-5590-083c7b697a85@st.com>
References: <20180410051927.8268-1-philippe.cornu@st.com> <3775994.jviQhGlOpf@avalon> <ea6fbdbe-6ce5-0110-5590-083c7b697a85@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

On Thursday, 19 April 2018 12:46:31 EEST Philippe CORNU wrote:
> On 04/19/2018 10:20 AM, Laurent Pinchart wrote:
> > On Tuesday, 10 April 2018 08:19:27 EEST Philippe Cornu wrote:
> > 
> >> Add the 3 optional power supplies using the exact description
> >> found in the document named
> >> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> >>
> >> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> >> ---
> >> drivers/gpu/drm/bridge/sii902x.c | 39 +++++++++++++++++++++++++++++++----
> >> 1 file changed, 35 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/sii902x.c
> >> b/drivers/gpu/drm/bridge/sii902x.c index 60373d7eb220..e17ba6db1ec8
> >> 100644
> >> --- a/drivers/gpu/drm/bridge/sii902x.c
> >> +++ b/drivers/gpu/drm/bridge/sii902x.c

[snip]

> >> @@ -443,6 +471,9 @@ static int sii902x_remove(struct i2c_client *client)
> >>
> >>   	drm_bridge_remove(&sii902x->bridge);
> >>
> >> +	regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
> >> +			       sii902x->supplies);
> >> +
> > 
> > While this seems functionally correct, would it be useful to only enable
> > power supplies when needed to save power ?
 
> that is a good point. I do not know well (yet) this bridge. Maybe I can 
> add a 3rd patch with bridge pre_enable() and post_disable() containing 
> reset & supplies management. Or I can put reset&supplies in bridge 
> enable() & disable() but it could be a little messy.
> 
> Any opinion/advice?

I'm not familiar with this bridge yet, so we need to be careful. The first 
point you need to check is the hardware requirements regarding power supply 
sequencing. For instance could it damage the chip if the I/O supply is turned 
off while the I/O pins are externally driven ? Can the core supplies be turned 
off with the I/O supply on ? Then, based on the hardware limitations, you 
should pick the appropriate location for power handling.

> >>   	return 0;
> >>   }

-- 
Regards,

Laurent Pinchart

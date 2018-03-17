Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeCQQAn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:00:43 -0400
Received: from gloria.sntech.de ([95.129.55.99]:60032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbeCQQAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:00:41 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Archit Taneja <architt@codeaurora.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        inki.dae@samsung.com, thierry.reding@gmail.com, hjc@rock-chips.com,
        seanpaul@chromium.org, airlied@linux.ie, tfiga@chromium.org,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, ykk@rock-chips.com, kernel@collabora.com,
        m.szyprowski@samsung.com, linux-samsung-soc@vger.kernel.org,
        jy0922.shim@samsung.com, rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: Re: [PATCH v5 07/36] drm/bridge: analogix_dp: Move enable video into config_video()
Date: Sat, 17 Mar 2018 17:00:21 +0100
Message-ID: <1685480.Fci6377Q9J@phil>
In-Reply-To: <79009f48-d677-ccc0-4d61-3b379d8448a8@codeaurora.org>
References: <20180309222327.18689-1-enric.balletbo@collabora.com> <20180309222327.18689-8-enric.balletbo@collabora.com> <79009f48-d677-ccc0-4d61-3b379d8448a8@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archit,

Am Mittwoch, 14. März 2018, 06:59:59 CET schrieb Archit Taneja:
> On Saturday 10 March 2018 03:52 AM, Enric Balletbo i Serra wrote:
> > From: Lin Huang <hl@rock-chips.com>
> > 
> > We need to enable video before analogix_dp_is_video_stream_on(), so
> > we can get the right video stream status.
> > 
> > Cc: 征增 王 <wzz@rock-chips.com>
> > Cc: Stéphane Marchesin <marcheu@chromium.org>
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > 
> >   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++------
> >   1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > index 5a2e35dc41e3..f9661b410cb9 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > @@ -819,11 +819,10 @@ static int analogix_dp_config_video(struct analogix_dp_device *dp)
> >   		if (analogix_dp_is_slave_video_stream_clock_on(dp) == 0)
> >   			break;
> >   		if (timeout_loop > DP_TIMEOUT_LOOP_COUNT) {
> > -			dev_err(dp->dev, "Timeout of video streamclk ok\n");
> > +			dev_err(dp->dev, "Timeout of slave video streamclk ok\n");
> >   			return -ETIMEDOUT;
> >   		}
> > -
> > -		usleep_range(1, 2);
> > +		usleep_range(1000, 1001);
> 
> Could we briefly explain in the commit message why we need to increase
> the delay in the timeout loop? Is it a consequence of calling
> analogix_dp_start_video() earlier, or is this the preferred time
> mentioned in the specs?

I asked Lin, the original author of this patch, response quoted below:

"There is random "Timeout of video streamclk ok" message happen when 
debug edp panel,
So we extend this time,  this time do not define in the spec."

So it looks like it was working by chance before and this move triggered
some sort of timing issue.


Heiko

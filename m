Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeCOQxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:53:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:53:12 -0400
Message-ID: <1521132789.4624.4.camel@pengutronix.de>
Subject: Re: [PATCH] [v3] gpu: ipu-v3: prg: avoid possible array underflow
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lucas Stach <l.stach@pengutronix.de>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Mar 2018 17:53:09 +0100
In-Reply-To: <20180315162011.807909-1-arnd@arndb.de>
References: <20180315162011.807909-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, 2018-03-15 at 17:19 +0100, Arnd Bergmann wrote:
> gcc-8 reports that we access an array with a negative index
> in an error case:
> 
> drivers/gpu/ipu-v3/ipu-prg.c: In function 'ipu_prg_channel_disable':
> drivers/gpu/ipu-v3/ipu-prg.c:252:43: error: array subscript -22 is below array bounds of 'struct ipu_prg_channel[3]' [-Werror=array-bounds]
> 
> This moves the range check in front of the first time that
> variable gets used.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

thank you, I've replaced v2 with this version in imx-drm/fixes.

regards
Philipp

> ----
> v1: Originally sent on Dec 4, 2017.
> v2: Sent again on Jan 16, after no reply, Phillipp said it was merged
> v3: Ran into a related problem with CONFIG_UBSAN, sent again fixing both
> ---
>  drivers/gpu/ipu-v3/ipu-prg.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index 97b99500153d..83f9dd934a5d 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -250,10 +250,14 @@ void ipu_prg_channel_disable(struct ipuv3_channel *ipu_chan)
>  {
>  	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
>  	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
> -	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
> +	struct ipu_prg_channel *chan;
>  	u32 val;
>  
> -	if (!chan->enabled || prg_chan < 0)
> +	if (prg_chan < 0)
> +		return;
> +
> +	chan = &prg->chan[prg_chan];
> +	if (!chan->enabled)
>  		return;
>  
>  	pm_runtime_get_sync(prg->dev);
> @@ -280,13 +284,15 @@ int ipu_prg_channel_configure(struct ipuv3_channel *ipu_chan,
>  {
>  	int prg_chan = ipu_prg_ipu_to_prg_chan(ipu_chan->num);
>  	struct ipu_prg *prg = ipu_chan->ipu->prg_priv;
> -	struct ipu_prg_channel *chan = &prg->chan[prg_chan];
> +	struct ipu_prg_channel *chan;
>  	u32 val;
>  	int ret;
>  
>  	if (prg_chan < 0)
>  		return prg_chan;
>  
> +	chan = &prg->chan[prg_chan];
> +
>  	if (chan->enabled) {
>  		ipu_pre_update(prg->pres[chan->used_pre], *eba);
>  		return 0;

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeE0WtG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:49:06 -0400
Received: from smtp-proxy004.phy.lolipop.jp ([157.7.104.45]:57381 "EHLO
        smtp-proxy004.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751976AbeE0WtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:49:05 -0400
Subject: Re: [PATCH][next] ALSA: xen-front: fix unsigned error check on return
 from to_sndif_format
To: Colin King <colin.king@canonical.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180527213219.24182-1-colin.king@canonical.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <e1312bb5-35c6-7954-c87d-2d72b15d99c5@sakamocchi.jp>
Date: Mon, 28 May 2018 07:49:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180527213219.24182-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On May 28 2018 06:32, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The negative error return from the call to to_sndif_format is being
> assigned to an unsigned 8 bit integer and hence the check for a negative
> value is always going to be false.  Fix this by using ret as the error
> return and hence the negative error can be detected and assign
> the u8 sndif_format to ret if there is no error.
> 
> Detected by CoverityScan, CID#1469385 ("Unsigned compared against 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   sound/xen/xen_snd_front_alsa.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
> index 5041f83e98d2..5a2bd70a2fa1 100644
> --- a/sound/xen/xen_snd_front_alsa.c
> +++ b/sound/xen/xen_snd_front_alsa.c
> @@ -466,13 +466,14 @@ static int alsa_prepare(struct snd_pcm_substream *substream)
>   		u8 sndif_format;
>   		int ret;
>   
> -		sndif_format = to_sndif_format(runtime->format);
> -		if (sndif_format < 0) {
> +		ret = to_sndif_format(runtime->format);
> +		if (ret < 0) {
>   			dev_err(&stream->front_info->xb_dev->dev,
>   				"Unsupported sample format: %d\n",
>   				runtime->format);
> -			return sndif_format;
> +			return ret;
>   		}
> +		sndif_format = ret;
>   
>   		ret = xen_snd_front_stream_prepare(&stream->evt_pair->req,
>   						   &stream->sh_buf,

Indeed. A typical assignment mistake. Instead, we could change the type 
of 'sndif_format' to signed int, however in this case it's not the same 
as the third argument of xen_snd_front_stream_prepare() because it is 
'u8'. This patch looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamoccchi.jp>


Regards

Takashi Sakamoto

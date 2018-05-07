Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeEGDBl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:01:41 -0400
Received: from smtp-proxy003.phy.lolipop.jp ([157.7.104.44]:46998 "EHLO
        smtp-proxy003.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751852AbeEGDBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:01:40 -0400
Subject: Re: [PATCH v3 6/9] ALSA: hda/ca0132: add alt_select_in/out for R3Di +
 SBZ
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
 <1525547001-17588-7-git-send-email-conmanx360@gmail.com>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <7d0154fa-2a98-4e3e-12ae-ff0472c6eb91@sakamocchi.jp>
Date: Mon, 7 May 2018 12:01:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525547001-17588-7-git-send-email-conmanx360@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On May 6 2018 04:03, Connor McAdams wrote:
> Add functions ca0132_alt_select_out and ca0132_alt_select_in for
> switching outputs and inputs for r3di and sbz. Also, add enumerated
> controls for selecting output and input source.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 597 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 572 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index bb0feaa..36cc2a1 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -480,6 +494,49 @@ static struct ct_voicefx_preset ca0132_voicefx_presets[] = {
>   	}
>   };
>   
> +/* DSP command sequences for ca0132_alt_select_out */
> +#define ALT_OUT_SET_MAX_COMMANDS 9 /* Max number of commands in sequence */
> +struct ca0132_alt_out_set {
> +	char *name; /*preset name*/
> +	unsigned char commands;
> +	unsigned int mids[ALT_OUT_SET_MAX_COMMANDS];
> +	unsigned int reqs[ALT_OUT_SET_MAX_COMMANDS];
> +	unsigned int vals[ALT_OUT_SET_MAX_COMMANDS];
> +};
> +
> +static struct ca0132_alt_out_set alt_out_presets[] = {
> +	{ .name = "Line Out",
> +	  .commands = 7,
> +	  .mids = { 0x96, 0x96, 0x96, 0x8F,
> +		    0x96, 0x96, 0x96 },
> +	  .reqs = { 0x19, 0x17, 0x18, 0x01,
> +		    0x1F, 0x15, 0x3A },
> +	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
> +		    0x00000000, 0x00000000, 0x00000000,
> +		    0x00000000 }
> +	},
> +	{ .name = "Headphone",
> +	  .commands = 7,
> +	  .mids = { 0x96, 0x96, 0x96, 0x8F,
> +		    0x96, 0x96, 0x96 },
> +	  .reqs = { 0x19, 0x17, 0x18, 0x01,
> +		    0x1F, 0x15, 0x3A },
> +	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
> +		    0x00000000, 0x00000000, 0x00000000,
> +		    0x00000000 }
> +	},
> +	{ .name = "Surround",
> +	  .commands = 8,
> +	  .mids = { 0x96, 0x8F, 0x96, 0x96,
> +		    0x96, 0x96, 0x96, 0x96 },
> +	  .reqs = { 0x18, 0x01, 0x1F, 0x15,
> +		    0x3A, 0x1A, 0x1B, 0x1C },
> +	  .vals = { 0x00000000, 0x00000000, 0x00000000,
> +		    0x00000000, 0x00000000, 0x00000000,
> +		    0x00000000, 0x00000000 }
> +	}
> +};
> +

It's better to add 'const' qualifier.


Regards

Takashi Sakamoto

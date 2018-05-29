Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeE2Fs5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:48:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38617 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbeE2Fsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:48:55 -0400
X-Google-Smtp-Source: ADUXVKLw1KCC/HCZFmIe6Pzmrtw3bgFau8caRlF5M9aDkpGTDKhoOZ46Ng62uerjZpAC8qk07qKqaQ==
Subject: Re: [alsa-devel] [PATCH] ALSA: xen: ensure nul-terminated device name
To: Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20180528160011.2989632-1-arnd@arndb.de>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <2469af3f-df85-fbca-a486-566f9aaa436d@gmail.com>
Date: Tue, 29 May 2018 08:48:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528160011.2989632-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 06:59 PM, Arnd Bergmann wrote:
> gcc-8 warns that pcm_instance->name is not necessarily terminated correctly
> if the input is more than 80 characters long or lacks a termination byte
> itself:
>
> In function 'strncpy',
>      inlined from 'cfg_device' at sound/xen/xen_snd_front_cfg.c:399:3,
>      inlined from 'xen_snd_front_cfg_card' at sound/xen/xen_snd_front_cfg.c:509:9:
> include/linux/string.h:254:9: error: '__builtin_strncpy' specified bound 80 equals destination size [-Werror=stringop-truncation]
>    return __builtin_strncpy(p, q, size);
>
> Using strlcpy() instead of strncpy() makes this a bit safer.
>
> Fixes: fd3b36045c2c ("ALSA: xen-front: Read sound driver configuration from Xen store")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/xen/xen_snd_front_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/xen/xen_snd_front_cfg.c b/sound/xen/xen_snd_front_cfg.c
> index 38c7e1eefbb9..684b5f1d51ac 100644
> --- a/sound/xen/xen_snd_front_cfg.c
> +++ b/sound/xen/xen_snd_front_cfg.c
> @@ -396,7 +396,7 @@ static int cfg_device(struct xen_snd_front_info *front_info,
>   
>   	str = xenbus_read(XBT_NIL, device_path, XENSND_FIELD_DEVICE_NAME, NULL);
>   	if (!IS_ERR(str)) {
> -		strncpy(pcm_instance->name, str, sizeof(pcm_instance->name));
> +		strlcpy(pcm_instance->name, str, sizeof(pcm_instance->name));
>   		kfree(str);
>   	}
>   
Thank you for your patch,
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

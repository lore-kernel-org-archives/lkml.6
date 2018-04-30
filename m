Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeD3MjB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:39:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39424 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeD3MjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:39:00 -0400
X-Google-Smtp-Source: AB8JxZrUMEjoSYYLtBaZW0s7WlMl9QL4R2Rwv8NOo3r6NPAzFC794R8em8GoZO8d1Yi+7ZNmd3MvtQ==
Date: Mon, 30 Apr 2018 13:38:56 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Kyle Spiers <ksspiers@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH v2] rave-sp: Remove VLA
Message-ID: <20180430123856.GI5147@dell>
References: <20180427223023.11849-1-ksspiers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427223023.11849-1-ksspiers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018, Kyle Spiers wrote:

> As part of the effort to remove VLAs from the kernel[1], this creates
> constants for the checksum lengths of CCITT and 8B2C and changes
> crc_calculated to be the maximum size of a checksum.
> 
> https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kyle Spiers <ksspiers@google.com>
> ---
>  drivers/mfd/rave-sp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied, thanks.

Kees, do you want me to add your Ack?

> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 5c858e784a89..4ce96b7137db 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -45,7 +45,9 @@
>  #define RAVE_SP_DLE			0x10
>  
>  #define RAVE_SP_MAX_DATA_SIZE		64
> -#define RAVE_SP_CHECKSUM_SIZE		2  /* Worst case scenario on RDU2 */
> +#define RAVE_SP_CHECKSUM_8B2C		1
> +#define RAVE_SP_CHECKSUM_CCITT		2
> +#define RAVE_SP_CHECKSUM_SIZE		RAVE_SP_CHECKSUM_CCITT
>  /*
>   * We don't store STX, ETX and unescaped bytes, so Rx is only
>   * DATA + CSUM
> @@ -415,7 +417,12 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
>  	const size_t payload_length  = length - checksum_length;
>  	const u8 *crc_reported       = &data[payload_length];
>  	struct device *dev           = &sp->serdev->dev;
> -	u8 crc_calculated[checksum_length];
> +	u8 crc_calculated[RAVE_SP_CHECKSUM_SIZE];
> +
> +	if (unlikely(checksum_length > sizeof(crc_calculated))) {
> +		dev_warn(dev, "Checksum too long, dropping\n");
> +		return;
> +	}
>  
>  	print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
>  		       16, 1, data, length, false);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

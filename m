Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756009AbeDXFnV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 01:43:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35936 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbeDXFnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 01:43:19 -0400
X-Google-Smtp-Source: AIpwx4/71/tx9mZmWP0/Xlf31GnWh0yd2Zcj7C7wYx1cqGbT0L0dmhpl8Hc/Fw2qlj2qOrPqwYjFkg==
Date: Tue, 24 Apr 2018 06:43:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Kyle Spiers <ksspiers@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] rave-sp: Remove VLA
Message-ID: <20180424054315.2yjpnht5pu62i54q@dell>
References: <20180423200255.154645-1-ksspiers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180423200255.154645-1-ksspiers@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Kyle Spiers wrote:

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
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 5c858e784a89..99fa482419f9 100644
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
> +	if (unlikely(length > sizeof(crc_calculated))) {

Forgive me if I have this wrong (it's still very early here), but this
doesn't leave any room for the payload?

    <--       length         -->
    <ck len><- payload length ->
    [CK][CK][D][A][T][A] .. [64]

It is my hope that length would always be larger than the size of the
checksum, or else there would never be any data?

Should this not be:

    if (unlikely(length > RAVE_SP_MAX_DATA_SIZE))

Nit: Adding the check is also an unrelated change, so would require a
separate patch.

> +		dev_warn(dev, "Dropping oversized frame\n");
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

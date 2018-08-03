Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8026217B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5BmFUZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8026217B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeHCXYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 19:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbeHCXYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 19:24:32 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2CF2178D;
        Fri,  3 Aug 2018 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533331590;
        bh=oFEq5z4HBQOsdY30N/e0TW8ntjyvbSbPm82mHXnQbCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m5BmFUZQ0Jigzb8vKvnArfNwpeAyBnlE8bthk1Lf7sfuyiVoV/4DoDbKW7lfHEsap
         iIwInnn0lTVqhWwCRf7QET0BhX400Am4VO/EwgpVJEqUkkA+T+TRsFccuPLkzqxW6s
         5z9fD2fp12VAZKJQzQeRJEutW6MPri3BpQCE8bAw=
Date:   Fri, 3 Aug 2018 22:26:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <broonie@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: Re: [PATCH v3 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180803222624.68572840@archlinux>
In-Reply-To: <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
        <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 16:02:18 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> From: Crestez Dan Leonard <leonard.crestez@intel.com>
> 
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read without range semantics.
> 
> Some linux drivers use regmap_bulk_read or regmap_raw_read for such
> registers, for example mpu6050 or bmi150 from IIO. This only happens to
> work because when caching is disabled a single regmap read op will map
> to a single bus read op (as desired). This breaks if caching is enabled and
> reg+1 happens to be a cacheable register.
> 
> Without regmap support refactoring a driver to enable regmap caching
> requires separate I2C and SPI paths. This is exactly what regmap is
> supposed to help avoid.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
I always liked this so am very pleased you have picked it up - so
if Mark want's to squeeze it in directly then I'm happy for him to do so.
If not, hopefully he's happy for this got via IIO next cycle?

Reviewed-by: Jonathan Cameron <jic23@kernel.org>

When this is applied we'll have to remember to clear up the odd cases
you hightlight above as well.
> ---
>  drivers/base/regmap/regmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/regmap.h       |  9 ++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 3bc8488..e632503 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2564,7 +2564,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
>  EXPORT_SYMBOL_GPL(regmap_raw_read);
>  
>  /**
> - * regmap_field_read() - Read a value to a single register field
> + * regmap_noinc_read(): Read data from a register without incrementing the
> + *			register number
> + *
> + * @map: Register map to read from
> + * @reg: Register to read from
> + * @val: Pointer to data buffer
> + * @val_len: Length of output buffer in bytes.
> + *
> + * The regmap API usually assumes that bulk bus read operations will read a
> + * range of registers. Some devices have certain registers for which a read
> + * operation read will read from an internal FIFO.
> + *
> + * The target register must be volatile but registers after it can be
> + * completely unrelated cacheable registers.
> + *
> + * This will attempt multiple reads as required to read val_len bytes.
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.
> + */
> +int regmap_noinc_read(struct regmap *map, unsigned int reg,
> +		      void *val, size_t val_len)
> +{
> +	size_t read_len;
> +	int ret;
> +
> +	if (!map->bus)
> +		return -EINVAL;
> +	if (!map->bus->read)
> +		return -ENOTSUPP;
> +	if (val_len % map->format.val_bytes)
> +		return -EINVAL;
> +	if (!IS_ALIGNED(reg, map->reg_stride))
> +		return -EINVAL;
> +	if (val_len == 0)
> +		return -EINVAL;
> +
> +	map->lock(map->lock_arg);
> +
> +	if (!regmap_volatile(map, reg) || !regmap_readable(map, reg)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	while (val_len) {
> +		if (map->max_raw_read && map->max_raw_read < val_len)
> +			read_len = map->max_raw_read;
> +		else
> +			read_len = val_len;
> +		ret = _regmap_raw_read(map, reg, val, read_len);
> +		if (ret)
> +			goto out_unlock;
> +		val = ((u8 *)val) + read_len;
> +		val_len -= read_len;
> +	}
> +
> +out_unlock:
> +	map->unlock(map->lock_arg);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(regmap_noinc_read);
> +
> +/**
> + * regmap_field_read(): Read a value to a single register field
>   *
>   * @field: Register field to read from
>   * @val: Pointer to store read value
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 4f38068..b6e6040 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
>  int regmap_raw_read(struct regmap *map, unsigned int reg,
>  		    void *val, size_t val_len);
> +int regmap_noinc_read(struct regmap *map, unsigned int reg,
> +		      void *val, size_t val_len);
>  int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
>  		     size_t val_count);
>  int regmap_update_bits_base(struct regmap *map, unsigned int reg,
> @@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
> +				   void *val, size_t val_len)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
>  static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
>  				   void *val, size_t val_count)
>  {


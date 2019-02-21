Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E766C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2132086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfBUJIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:08:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:16991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfBUJIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:08:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 01:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,394,1544515200"; 
   d="scan'208";a="148634708"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Feb 2019 01:08:51 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 11:08:50 +0200
Date:   Thu, 21 Feb 2019 11:08:50 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: Re: [PATCHv3] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190221090850.GE5054@kuha.fi.intel.com>
References: <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220151138.12332-1-nv@vosn.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220151138.12332-1-nv@vosn.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:11:38PM +0100, Nikolaus Voss wrote:
> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> 
> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
> adapters, but the problem described with regmap-i2c not handling
> SMBus block transfers (i.e. read and writes) correctly also exists
> with writes.
> 
> As workaround, this patch adds a block write function the same way
> 1a2f474d328f adds a block read function.
> 
> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: fix tps6598x_exec_cmd also
> v3: use fixed length for stack buffer
> ---
>  drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..eb8046f87a54 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  	return 0;
>  }
>  
> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> +				void *val, size_t len)
> +{
> +	u8 data[TPS_MAX_LEN + 1];
> +
> +	if (!tps->i2c_protocol)
> +		return regmap_raw_write(tps->regmap, reg, val, len);
> +
> +	data[0] = len;
> +	memcpy(&data[1], val, len);
> +
> +	return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
> +}
> +
>  static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
>  {
>  	return tps6598x_block_read(tps, reg, val, sizeof(u16));
> @@ -127,23 +141,23 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
>  
>  static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
>  {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u16));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u16));
>  }
>  
>  static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
>  {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>  }
>  
>  static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
>  {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u64));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
>  }
>  
>  static inline int
>  tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
>  {
> -	return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
> +	return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>  }
>  
>  static int tps6598x_read_partner_identity(struct tps6598x *tps)
> @@ -229,8 +243,8 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>  		return -EBUSY;
>  
>  	if (in_len) {
> -		ret = regmap_raw_write(tps->regmap, TPS_REG_DATA1,
> -				       in_data, in_len);
> +		ret = tps6598x_block_write(tps, TPS_REG_DATA1,
> +					   in_data, in_len);
>  		if (ret)
>  			return ret;
>  	}
> -- 
> 2.17.1

thanks,

-- 
heikki

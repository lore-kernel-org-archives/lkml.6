Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE92C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC022147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBTMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:14:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:57523 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfBTMOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:14:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 04:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="148351782"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Feb 2019 04:14:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 20 Feb 2019 14:14:41 +0200
Date:   Wed, 20 Feb 2019 14:14:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de
Subject: Re: [PATCH] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
Message-ID: <20190220121441.GA5054@kuha.fi.intel.com>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com>
 <20190220110017.BFA344CE86@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220110017.BFA344CE86@mail.steuer-voss.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 10, 2018 at 07:05:01AM +0200, Nikolaus Voss wrote:
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
> ---
>  drivers/usb/typec/tps6598x.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..57a3e6c5c175 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  	return 0;
>  }
>  
> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> +				void *val, size_t len)
> +{
> +	u8 data[len + 1];
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

You need to fix tps6598x_exec_cmd() as well.

Did you really send this last September? If you did, then the mail has
been stuck somewhere for a long time.


thanks,

-- 
heikki

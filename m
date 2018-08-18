Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EFC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901C2124D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 17:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901C2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeHRUWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:22:18 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35916 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeHRUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:22:18 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2018 16:22:16 EDT
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B27949E8215;
        Sat, 18 Aug 2018 18:07:33 +0100 (BST)
Date:   Sat, 18 Aug 2018 18:07:32 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 7/9] iio: tsl2772: add support for avago,apds9930
Message-ID: <20180818180724.2a489d07@archlinux>
In-Reply-To: <20180803225336.6cb5d581@archlinux>
References: <20180803001900.25371-1-masneyb@onstation.org>
        <20180803001900.25371-8-masneyb@onstation.org>
        <20180803225336.6cb5d581@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 22:53:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu,  2 Aug 2018 20:18:58 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > The Avago APDS9930 has the same register set as the TAOS/AMS TSL2772 so
> > this patch adds the correct bindings and the appropriate LUX table
> > values derived from the values in the datasheet. Driver was tested on a
> > LG Nexus 5 (hammerhead) phone.
> > 
> > avago,apds9930 datasheet:
> > https://www.mouser.com/datasheet/2/678/avago_AV02-3190EN_DS_APDS-9930_2014-03-25[1]-1217273.pdf
> > 
> > tsl2772 datasheet:
> > https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>  
> Glad you noticed they were the same.  will apply once precursors are in.
> 
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/tsl2772.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 4a11bf77a4d0..83cece921843 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -124,7 +124,8 @@ enum {
> >  	tsl2672,
> >  	tmd2672,
> >  	tsl2772,
> > -	tmd2772
> > +	tmd2772,
> > +	apds9930,
> >  };
> >  
> >  enum {
> > @@ -213,6 +214,12 @@ static const struct tsl2772_lux tmd2x72_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
> >  	{     0,      0 },
> >  };
> >  
> > +static const struct tsl2772_lux apds9930_lux_table[TSL2772_DEF_LUX_TABLE_SZ] = {
> > +	{ 52000,  96824 },
> > +	{ 38792,  67132 },
> > +	{     0,      0 },
> > +};
> > +
> >  static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
> >  	[tsl2571] = tsl2x71_lux_table,
> >  	[tsl2671] = tsl2x71_lux_table,
> > @@ -224,6 +231,7 @@ static const struct tsl2772_lux *tsl2772_default_lux_table_group[] = {
> >  	[tmd2672] = tmd2x72_lux_table,
> >  	[tsl2772] = tsl2x72_lux_table,
> >  	[tmd2772] = tmd2x72_lux_table,
> > +	[apds9930] = apds9930_lux_table,
> >  };
> >  
> >  static const struct tsl2772_settings tsl2772_default_settings = {
> > @@ -274,6 +282,7 @@ static const int tsl2772_int_time_avail[][6] = {
> >  	[tmd2672] = { 0, 2730, 0, 2730, 0, 699000 },
> >  	[tsl2772] = { 0, 2730, 0, 2730, 0, 699000 },
> >  	[tmd2772] = { 0, 2730, 0, 2730, 0, 699000 },
> > +	[apds9930] = { 0, 2730, 0, 2730, 0, 699000 },
> >  };
> >  
> >  static int tsl2772_int_calibscale_avail[] = { 1, 8, 16, 120 };
> > @@ -299,7 +308,8 @@ static const u8 device_channel_config[] = {
> >  	[tsl2672] = PRX2,
> >  	[tmd2672] = PRX2,
> >  	[tsl2772] = ALSPRX2,
> > -	[tmd2772] = ALSPRX2
> > +	[tmd2772] = ALSPRX2,
> > +	[apds9930] = ALSPRX2,
> >  };
> >  
> >  static int tsl2772_read_status(struct tsl2772_chip *chip)
> > @@ -513,6 +523,7 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
> >  	case tmd2672:
> >  	case tsl2772:
> >  	case tmd2772:
> > +	case apds9930:
> >  		if (!(ret & TSL2772_STA_PRX_VALID)) {
> >  			ret = -EINVAL;
> >  			goto prox_poll_err;
> > @@ -1393,6 +1404,7 @@ static int tsl2772_device_id_verif(int id, int target)
> >  	case tmd2672:
> >  	case tsl2772:
> >  	case tmd2772:
> > +	case apds9930:
> >  		return (id & 0xf0) == SWORDFISH_ID;
> >  	}
> >  
> > @@ -1932,6 +1944,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
> >  	{ "tmd2672", tmd2672 },
> >  	{ "tsl2772", tsl2772 },
> >  	{ "tmd2772", tmd2772 },
> > +	{ "apds9930", apds9930},
> >  	{}
> >  };
> >  
> > @@ -1948,6 +1961,7 @@ static const struct of_device_id tsl2772_of_match[] = {
> >  	{ .compatible = "amstaos,tmd2672" },
> >  	{ .compatible = "amstaos,tsl2772" },
> >  	{ .compatible = "amstaos,tmd2772" },
> > +	{ .compatible = "avago,apds9930" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, tsl2772_of_match);  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


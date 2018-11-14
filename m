Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E392089F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E392089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeKODOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:14:25 -0500
Received: from shell.v3.sk ([90.176.6.54]:46155 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeKODOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:14:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 09FDE46459;
        Wed, 14 Nov 2018 18:10:18 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 156NOISiFMMO; Wed, 14 Nov 2018 18:10:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 878A6467C6;
        Wed, 14 Nov 2018 18:10:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NYW20k4StrK7; Wed, 14 Nov 2018 18:10:12 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CDBAF46459;
        Wed, 14 Nov 2018 18:10:11 +0100 (CET)
Message-ID: <92612aad296f8204af80573ab99f256c026e3801.camel@v3.sk>
Subject: Re: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a
 struct
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Date:   Wed, 14 Nov 2018 18:10:10 +0100
In-Reply-To: <20181104143743.GF23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-14-lkundrak@v3.sk> <20181104143743.GF23864@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 15:37 +0100, Pavel Machek wrote:
> Hi!
> 
> > The global variables for private data are not too nice. I'd like some
> > more, and that would clutter the global name space even further.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Ok...
> 
> > -	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
> > -	if (IS_ERR(olpc_bat)) {
> > -		ret = PTR_ERR(olpc_bat);
> > -		goto battery_failed;
> > -	}
> > +	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
> > +	if (IS_ERR(data->olpc_bat))
> > +		return PTR_ERR(data->olpc_bat);
> >  
> > -	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > +	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	if (ret)
> > -		goto eeprom_failed;
> > +		return ret;
> >  
> > -	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
> > +	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
> >  	if (ret)
> >  		goto error_failed;
> >  
> >  	if (olpc_ec_wakeup_available()) {
> > -		device_set_wakeup_capable(&olpc_ac->dev, true);
> > -		device_set_wakeup_capable(&olpc_bat->dev, true);
> > +		device_set_wakeup_capable(&data->olpc_ac->dev, true);
> > +		device_set_wakeup_capable(&data->olpc_bat->dev, true);
> >  	}
> >  
> >  	return 0;
> >  
> >  error_failed:
> > -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > -eeprom_failed:
> > -	power_supply_unregister(olpc_bat);
> > -battery_failed:
> > -	power_supply_unregister(olpc_ac);
> > +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	return ret;
> >  }
> 
> ...but you are changing error handling here, which is not mentioned in
> the changelog, and I'm nut sure you got it right.
> 
> Are you sure?

I can't see what's wrong. I'll split the priv structure and devm/error
handling changes into two separate patches as you're right they indeed
are somewhat unrelated.

If v2 (tomorrow or so) will still seem wrong to you I'd be thankful if
you could elaborate a bit more.
> 
> >  static int olpc_battery_remove(struct platform_device *pdev)
> >  {
> > -	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
> > -	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
> > -	power_supply_unregister(olpc_bat);
> > -	power_supply_unregister(olpc_ac);
> > +	struct olpc_battery_data *data = platform_get_drvdata(pdev);
> > +
> > +	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
> > +	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> >  	return 0;
> >  }
> 
> Here too.
> 									Pavel

Cheers
Lubo


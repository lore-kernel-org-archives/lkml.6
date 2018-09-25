Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7FCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316F52087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316F52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeIYNxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:53:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60609 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeIYNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:53:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7D78520731; Tue, 25 Sep 2018 09:47:24 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4A0FD203DA;
        Tue, 25 Sep 2018 09:47:14 +0200 (CEST)
Date:   Tue, 25 Sep 2018 09:47:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khoroshilov@ispras.ru" <khoroshilov@ispras.ru>
Subject: Re: rtc: isl1208: avoid possible sysfs race
Message-ID: <20180925074714.GG13455@piout.net>
References: <20180915114343.31935-1-alexandre.belloni@bootlin.com>
 <1537857983.4657.5.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1537857983.4657.5.camel@diehl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 06:46:24+0000, Denis OSTERLAND wrote:
> Hi,
> 
> just for clarification:
> This changes user-space representation from
> /sys/class/rtc/rtcN/device/{atrim,dtrim,usr}
> to
> /sys/class/rtc/rtcN/{atrim,dtrim,usr}
> and fixes the "mistake made back in 2006" you mention in
> https://patchwork.ozlabs.org/patch/881397/
> correct?
> 

This is correct. At some point, it would also be great to move from
atrim/dtrim to offset

> Regards Denis
> 
> Am Samstag, den 15.09.2018, 13:43 +0200 schrieb Alexandre Belloni:
> > Use rtc_add_group to add the common sysfs group to avoid a possible race
> > condition.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/rtc/rtc-isl1208.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> > index ea18a8f4bce0..e1e9434c9972 100644
> > --- a/drivers/rtc/rtc-isl1208.c
> > +++ b/drivers/rtc/rtc-isl1208.c
> > @@ -804,7 +804,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  		evdet_irq = of_irq_get_byname(np, "evdet");
> >  	}
> >  
> > -	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > +	rc = rtc_add_group(rtc, &isl1208_rtc_sysfs_files);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -821,14 +821,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  	return rtc_register_device(rtc);
> >  }
> >  
> > -static int
> > -isl1208_remove(struct i2c_client *client)
> > -{
> > -	sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> > -
> > -	return 0;
> > -}
> > -
> >  static const struct i2c_device_id isl1208_id[] = {
> >  	{ "isl1208", TYPE_ISL1208 },
> >  	{ "isl1218", TYPE_ISL1218 },
> > @@ -851,7 +843,6 @@ static struct i2c_driver isl1208_driver = {
> >  		.of_match_table = of_match_ptr(isl1208_of_match),
> >  	},
> >  	.probe = isl1208_probe,
> > -	.remove = isl1208_remove,
> >  	.id_table = isl1208_id,
> >  };
> >  
> 
> Diehl Connectivity Solutions GmbH
> Geschäftsführung: Horst Leonberger
> Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
> Nürnberg: HRB 32315
> ___________________________________________________________________________________________________
> 
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
> Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

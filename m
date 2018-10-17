Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853DECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C62C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQnUY3OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C62C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJRFMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:12:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44238 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:12:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so13103921pgu.11;
        Wed, 17 Oct 2018 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=22JNDfv7sjL2DXeYvh5/hLbUGdpncKEtBEgKirFm3Sk=;
        b=rQnUY3OLBHGQykaFN2lsUhI+LUVCjnYV90TjR8HpzYe7sXSa3XjRhu/K2HezI12E10
         ZN5z8VspYMnfO8+omvnQNobFx6egSTXUyTJKPVypF7l79oHbc02vo9S90y8/J2/m/W25
         PcfAnXc9XaNoPgrBcUycmqTUdZY6upbzafpcvreIoyTVyTI1Bb0BHzvyg4u2mraxaBdr
         bkKHSigpAiaZbPzZfnnKKYvcoIRE2x6mKsIG6pLQP2sYTi5UzAZlan9K0a2n8DJkOzg7
         8B8ePYjsR8TXQXe1ML+vgX3rIgnbhL3dH68K0wrovPqh/9myPVCYs76FTydZQYzrQhmy
         iCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=22JNDfv7sjL2DXeYvh5/hLbUGdpncKEtBEgKirFm3Sk=;
        b=hHWG5VKdRaC0nqhx5KsfhhDvR0Ei1E5oc4zY0FLLGxI7JoTT5c7ILt5Jen0bdWLZ8b
         4VMdik8VWF4djNqYRfTUk01AKdc3F5ruTuZliMk5hIYxlyvPv5Xdi2a6e8ym+Ls41J1Z
         yWVeInNwzRrUH48vZ44756jpG0IIm8sKu9oiX90GuxdGxNluviy8Ebk/7tFsSLE0AMGk
         ESTpRn0ZXbHPt0zcjZ+9LlagqDvHHBo2pDpMh0C1BhZFHpGDrgbRw7QzMoQH3HNGoir1
         sMzCb6kvPHEJ3IxurbccB6Kr7/8jEA0icUtbc8B5iI7g6NrW7Jr6p+lZQypXB5qikXji
         PMjw==
X-Gm-Message-State: ABuFfogOEifhhvYjkfaa+ZZ5tofLnoT+7JaF4YlnaQX39zlXVHIZixTI
        Ox4hLvG7FehNkng39zUlHOE=
X-Google-Smtp-Source: ACcGV63E/kC/E4no8E+S7rHnlGpG2G3y/+c+4f87AxgNZfnbLdQQM7cal7R0k4sdUA8uEOv4BTCjFg==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr26072400pgc.351.1539810869429;
        Wed, 17 Oct 2018 14:14:29 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u79-v6sm35066260pfi.104.2018.10.17.14.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 14:14:27 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:14:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (ina3221) Return -ENODATA for two alarms
 attributes
Message-ID: <20181017211426.GA10990@roeck-us.net>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-3-nicoleotsuka@gmail.com>
 <20181017194605.GB6812@roeck-us.net>
 <20181017203917.GB15941@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017203917.GB15941@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:39:17PM -0700, Nicolin Chen wrote:
> On Wed, Oct 17, 2018 at 12:46:05PM -0700, Guenter Roeck wrote:
> > On Tue, Oct 16, 2018 at 06:24:23PM -0700, Nicolin Chen wrote:
> > > There is nothing critically wrong to read these two attributes
> > > without having a is_enabled() check at this point. But reading
> > > the MASK_ENABLE register would clear the CVRF bit according to
> > > the datasheet. So it'd be safer to fence for disabled channels
> > > in order to add pm runtime feature.
> > > 
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > ---
> > >  drivers/hwmon/ina3221.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> > > index d61688f04594..3e98b59108ee 100644
> > > --- a/drivers/hwmon/ina3221.c
> > > +++ b/drivers/hwmon/ina3221.c
> > > @@ -200,6 +200,8 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
> > >  		return 0;
> > >  	case hwmon_curr_crit_alarm:
> > >  	case hwmon_curr_max_alarm:
> > > +		if (!ina3221_is_enabled(ina, channel))
> > > +			return -ENODATA;
> > 
> > Makes sense, but can you check what the sensors command does with this ?
> 
> Not quite understanding the question. Do you mean the user case
> causing the race condition -- wiping out the CVRF bit?
> 
No. Question is what the "sensors" command reports if reading the alarm
attribute returns -ENODATA. If it reports an error, we would have a regression.

Guenter

> > If it bails out I'd rather have the code return 0 and no error (after all,
> > the sensor is disabled, so any alarm would be bogus).
> 
> That's true. Since they are alert flags, should return 0. I will
> fix it.
> 
> Thanks

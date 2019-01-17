Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F5B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6sqmsAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfAQXN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:13:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45652 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfAQXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:13:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so5098945pgc.12;
        Thu, 17 Jan 2019 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6GaRE7rKOZ1SAhXklBZkbCpMQANWGerAfcAudjCJLFA=;
        b=C6sqmsAncpReMN6ReID5Q3N4+BqWsS82QALhu9iEfmExoe3BIVCDfYqWGE3y6qu7Dw
         eWjpEulHRi8HNduNgzMPUY4Nxz8164AfN5Uq5vCjptt2l9a3y5qVpKhucpbj+ty5vZt6
         PtnFyj+aSHMCJO/GAgIOCGL/+o+5ayYCcNY1eSRXxh1iECC1xXPuL9gwdeHQzUIR6mrT
         FCKThDz46D04DWtXZERReTZnAcbaEwp0Bwvc1S3Mu5s4/fdRoX9MkqaeOy/XZB3nF2F+
         VBgjQy0jUNZwqVmxCT9vR3DMFelkE2Yle6whmDf/gaFDxHGzfmc6axyefg9WJ/TAoTqM
         FUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6GaRE7rKOZ1SAhXklBZkbCpMQANWGerAfcAudjCJLFA=;
        b=DacNyo9tHue20iJ/eaYKwNT6DNTOc5vLaWR1nkchohxye1Iz4Yu805tFR89K0d1Ze5
         oT8AHuEBI1eBGONeAYFRSQPYpPfI0dmjYBC5tJahm4FPkIBLvP6bLlm5yU23zcAMKrBn
         ZpAmpLiNmbddeXyzwub2RyF1rifU1mzassfMskB+pywP63aQZiCK1A7TP2d0K4BVsdwi
         BMGoAfC+08oA6fAC3iiA60KlrgYCJFvREIPxgAgQKAfJmrJ6PP06WC7NtXlOdoPpEGGW
         jGaPTeYxfhL48RVknNZCuNyD6KAFjutHDp/gO2SAClJmCr/tTOhM3fAlnvdtHuLyMDVg
         AgFw==
X-Gm-Message-State: AJcUukcIeo0zvo2LO3czf75snrWQ5+y+j4TrIGahN2RNCcwcrNC/fjdm
        fL9AdBpzSbH7I+taArX/4zU=
X-Google-Smtp-Source: ALg8bN6IkQhc0Hr39jrex2K2aTUarsTu0qrUlqQvm9KO5Ve3VrifiMquTwftfSLTcXB5N4F+GFC1fQ==
X-Received: by 2002:a65:610d:: with SMTP id z13mr15543313pgu.427.1547766805789;
        Thu, 17 Jan 2019 15:13:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v13sm3381547pff.20.2019.01.17.15.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:13:25 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:13:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     =?iso-8859-1?B?QnL8bnMs?= Stefan <Stefan.Bruens@rwth-aachen.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [RFC][PATCH] hwmon: (ina2xx) Improve current and power reading
 precision
Message-ID: <20190117231323.GB23511@roeck-us.net>
References: <20181121012629.5432-1-nicoleotsuka@gmail.com>
 <2863036.QIPGp1Eqjm@sbruens-linux.lcs.intern>
 <20181121194051.GA8902@Asurada-Nvidia.nvidia.com>
 <1717545.GXSegKtrMu@sbruens-linux.lcs.intern>
 <20190105012642.GA18025@Asurada-Nvidia.nvidia.com>
 <20190117223828.GI16918@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190117223828.GI16918@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:38:28PM -0800, Nicolin Chen wrote:
> On Fri, Jan 04, 2019 at 05:26:42PM -0800, Nicolin Chen wrote:
> > Hi Stefan,
> > 
> > Sorry for a super late reply. I took a long vacation.
> > 
> > On Wed, Nov 21, 2018 at 10:16:09PM +0000, Brüns, Stefan wrote:
> > > > > Another concern may be voltage drop over the shunt, but for this case you
> > > > > have a nominal voltage of 1.8V, so 30uV are 0.001%.
> > > > > 
> > > > > > When measuring a 1.8v voltage running a small current (e.g. 33 mA),
> > > > > > the power value (that's supposed to be 59.4 mW) becomes inaccurate
> > > > > > due to the larger scale (25mA for method A; 62.5 mA for method B).
> > > > 
> > > > Just found out that I have typos here: 25mW and 62.5mW.
> > > > 
> > > > > Another look into the datasheet reveals, even at full gain (PGA=1), the
> > > > > LSB is 40mV / 2^12 = 40mV / 4096 ~ 10uV. So when the current ADC reads
> > > > > out as 3*LSB, this anything between 25mA and 35mA. This is the best case
> > > > > figure.
> > > > Current read doesn't get affected a lot actually, since hwmon ABI
> > > > also reports current value in unit mA. However, the power read is
> > > > the matter here. With a 62.5mW power_lsb, power results are kinda
> > > > useless on my system.
> > > 
> > > The reported current does not matter here, actually. Internally, the ADC value 
> > > will have an uncertainty of 10mA (at PGA=1). At 1.8V, your uncertainty is 
> > > 18mW. And thats *only* the quantization noise. It wont get better than that.
> > 
> > The fact is that I do get better power results after setting the
> > calibration value to 0x7ff. That's the necessity of this change.
> > 
> > > Also note, you are apparently using the ina2xx hwmon driver - I strongly 
> > > advise against it, you should either use the ina2xx driver from the IIO 
> > > subsystem directly, or use the IIO driver via iio-hwmon.
> > 
> > The IIO version is also using the minimum calibration value. It
> > will not solve my problem here.
> > 
> > > There is also always the possibility to read the bus and shunt voltage 
> > > registers and calculate the power manually.
> > 
> > Won't that be a waste since the hardware could have provided a
> > better accuracy? It would need more I2C bus reads and cpu cycles
> > for calculation.
> > 
> > I don't get why you're against a setting for calibration value.
> > This is how the hardware got designed to cover different cases.
> > Since we do have such a case that needs some accuracy, it'd be
> > fair to add it into the driver. Plus, the feature won't change
> > the minimum calibration value at all -- everyone would be happy.
> 
> Stefan,
> 
> Would you please kindly give an ack to this intention so that
> we can at least move forward for patch review?
> 
> Neither changing hardware resistor values nor simply ignoring
> the inaccuracy is acceptable for us. Since configuring that
> calibration register value can help our use cases, we really
> need this setting to be available in the driver.
> 
> Guenter,
> 
> Do you have any input regarding this change? I would like to
> hear an opinion from you.
> 

I have one claim stating that your change won't make a difference,
and your claim that it would. That leaves me with no choice but to
spend a large amount of time with the datasheet, and possibly with
my evaluation boards, trying to find out who is correct. Unfortunately,
time is scarce to come by those days. I would very much prefer for
you folks to sort out your differences and present me with a single
opinion.

Long term the best solution would really be to replace the hwmon
driver with the iio driver and use the iio-hwmon bridge. The ina2xx
driver doesn't support limits, so there is no real benefit of using
the hwmon driver over the iio driver, at least assuming that the
iio driver supports all the attributes. So maybe you should make your
case for the changes in the iio driver.

Guenter

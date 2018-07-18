Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="DbzcOxha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE9F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbeGRJuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:50:50 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:60642 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:50:49 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 76EE1B00768
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:13:53 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1531905232; x=1532769233; bh=c+UurG2T0u1p5OxdgTE4hYgfxIlGe8eFwA9
        bgG67lvk=; b=DbzcOxhaSWLsLP3LJNopST1ZBQEwxRHd0TrVS2frDzcfJdyyki9
        ayJb37hddaN9AwmJ4fnOa+Oqw56jMeuZKgxtLxRBbslMAOFzqQBunTP3da/9Bqnl
        8I21mXXQ7d1tXDjOCJ0O+fDad+vQPtTPXMqd6d7FGf186QCE+W73VmI0=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vnqOZxZ0Kvxt for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 11:13:52 +0200 (CEST)
Received: from [192.168.2.133] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 80C94B0018C;
        Wed, 18 Jul 2018 11:13:52 +0200 (CEST)
Subject: Re: [PATCH v7 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718084916.79837-1-giulio.benetti@micronovasrl.com>
 <20180718084916.79837-2-giulio.benetti@micronovasrl.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <09456f94-8f4d-875d-c87f-4dedfeeebadc@micronovasrl.com>
Date:   Wed, 18 Jul 2018 11:13:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718084916.79837-2-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Il 18/07/2018 10:49, Giulio Benetti ha scritto:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> V6 => V7:
> * changed PPM to PPB as rtc sysfs offset handles PPB
>   drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 0162a600ff1b..b2ef9defc349 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -114,6 +114,20 @@ enum ds_type {
>   #	define RX8025_BIT_VDET		0x40
>   #	define RX8025_BIT_XST		0x20
>   
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		0x80
> +#	define M41TXX_BIT_FT		0x40
> +#	define M41TXX_BIT_CALIB_SIGN	0x20
> +#	define M41TXX_M_CALIBRATION	0x1f

Sorry, I've forgot to use BIT().
I would also use GENMASK() for M41TXX_M_CALIBRATION.
I correct and resend asap.

Giulio

Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8C216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8C216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeI1S2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:28:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56952 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1S2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:28:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6374E206FF; Fri, 28 Sep 2018 14:05:00 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E595208B7;
        Fri, 28 Sep 2018 14:04:50 +0200 (CEST)
Date:   Fri, 28 Sep 2018 14:04:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: isl1208: access i2c client via rtc parent
Message-ID: <20180928120451.GR16644@piout.net>
References: <20180928114832.27383-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928114832.27383-1-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/09/2018 11:51:17+0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The move of atrim, dtrim usr sysfs properties from i2c device
> to rtc device require to access them via dev->parent.
> This patch also aligns timestamp0.
> 
> Fixes: 03df75dd03301307ec578ccd4e8c1c0117b8e65c
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index 15094df12985..ec5ef518a09b 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -517,7 +517,7 @@ static ssize_t timestamp0_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
>  {
> -	struct i2c_client *client = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
>  	int sr;
> 
>  	sr = isl1208_i2c_get_sr(client);
> @@ -539,7 +539,7 @@ static ssize_t timestamp0_store(struct device *dev,
>  static ssize_t timestamp0_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	struct i2c_client *client = dev_get_drvdata(dev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
>  	u8 regs[ISL1219_EVT_SECTION_LEN] = { 0, };
>  	struct rtc_time tm;
>  	int sr;
> @@ -649,7 +649,7 @@ static ssize_t
>  isl1208_sysfs_show_atrim(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> -	int atr = isl1208_i2c_get_atr(to_i2c_client(dev));
> +	int atr = isl1208_i2c_get_atr(to_i2c_client(dev->parent));
>  	if (atr < 0)
>  		return atr;
> 
> @@ -662,7 +662,7 @@ static ssize_t
>  isl1208_sysfs_show_dtrim(struct device *dev,
>  			 struct device_attribute *attr, char *buf)
>  {
> -	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev));
> +	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev->parent));

Oh right, I actually had that but somehow, I stashed the patch instead
of squashing it.

If that is fine for you, I'll fold that in the original patch (I'll ad
your SoB).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

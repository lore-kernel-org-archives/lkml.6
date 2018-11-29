Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C299A2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C299A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbeK3Bsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55206 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbeK3Bsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0F21D26121E
Subject: Re: [PATCH 5/7] mfd / platform: cros_ec: move device sysfs attributes
 to its own driver.
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, lee.jones@linaro.org, gwendal@chromium.org,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181129112141.GR3073@unbuntlaptop>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <43f05051-b1ad-88a9-abea-2111fbc2be94@collabora.com>
Date:   Thu, 29 Nov 2018 15:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181129112141.GR3073@unbuntlaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 29/11/18 12:21, Dan Carpenter wrote:
> Hi Enric,
> 
> I love your patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/mfd-cros_ec-use-devm_mfd_add_devices/20181123-025253
> 
> smatch warnings:
> drivers/platform/chrome/cros_ec_sysfs.c:366 cros_ec_sysfs_probe() warn: variable dereferenced before check 'ec_dev' (see line 362)
> 
> # https://github.com/0day-ci/linux/commit/b3074e331f36fff8890e7bd5c1f5874f4c59d38f
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout b3074e331f36fff8890e7bd5c1f5874f4c59d38f
> vim +/ec_dev +366 drivers/platform/chrome/cros_ec_sysfs.c
> 
> b3074e33 Enric Balletbo i Serra 2018-11-22  358  
> b3074e33 Enric Balletbo i Serra 2018-11-22  359  static int cros_ec_sysfs_probe(struct platform_device *pd)
> b3074e33 Enric Balletbo i Serra 2018-11-22  360  {
> b3074e33 Enric Balletbo i Serra 2018-11-22  361  	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> b3074e33 Enric Balletbo i Serra 2018-11-22 @362  	struct cros_ec_platform *ec_platform = dev_get_platdata(ec_dev->dev);
>                                                                                                                 ^^^^^^^^^^^
> b3074e33 Enric Balletbo i Serra 2018-11-22  363  	struct device *dev = &pd->dev;
> b3074e33 Enric Balletbo i Serra 2018-11-22  364  	int ret;
> b3074e33 Enric Balletbo i Serra 2018-11-22  365  
> b3074e33 Enric Balletbo i Serra 2018-11-22 @366  	if (!ec_dev) {
>                                                              ^^^^^^
> Presumable this test can be removed?
> 

Yes, Guenter detected this and I already sent another patchset that removes
this. Thanks.

> b3074e33 Enric Balletbo i Serra 2018-11-22  367  		dev_err(dev, "No EC dev found\n");
> b3074e33 Enric Balletbo i Serra 2018-11-22  368  		return -EINVAL;
> b3074e33 Enric Balletbo i Serra 2018-11-22  369  	}
> b3074e33 Enric Balletbo i Serra 2018-11-22  370  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

I had this question on my mind for some time but I didn't look for an answer, in
fact, I'm not sure if I already asked you this before, sorry about that if I
did, the question is. There is a easy way to run your smatch scripts locally to
check the patch before I send to the ML?

Best regards,
 Enric

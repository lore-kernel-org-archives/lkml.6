Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473ECC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C17206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C17206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeI3JD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:03:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeI3JD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:03:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65B2E43D6A40E;
        Sun, 30 Sep 2018 10:32:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Sun, 30 Sep 2018
 10:32:21 +0800
Message-ID: <5BB035B4.3030201@huawei.com>
Date:   Sun, 30 Sep 2018 10:32:20 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8731: Fix a unused function gcc warning
References: <1538271918-24033-1-git-send-email-zhongjiang@huawei.com> <0e30a0ab635f0348bcf582efe018e53334a276fe.camel@perches.com>
In-Reply-To: <0e30a0ab635f0348bcf582efe018e53334a276fe.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/30 10:17, Joe Perches wrote:
> On Sun, 2018-09-30 at 09:45 +0800, zhong jiang wrote:
>> Fix the following compile warning:
>>
>> sound/soc/codecs/wm8731.c:575:12: warning: 'wm8731_request_supplies' defined but not used [-Wunused-function]
>> sound/soc/codecs/wm8731.c:600:12: warning: 'wm8731_hw_init' defined but not used [-Wunused-function]
> []
>> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> []
>> @@ -36,12 +36,15 @@
>>  #include "wm8731.h"
>>  
>>  #define WM8731_NUM_SUPPLIES 4
>> +
>> +#if defined(CONFIG_I2C) || defined(CONFIG_SPI_MASTER)
>>  static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
>>  	"AVDD",
>>  	"HPVDD",
>>  	"DCVDD",
>>  	"DBVDD",
>>  };
>> +#endif
>>  
>>  /* codec private data */
>>  struct wm8731_priv {
>> @@ -572,6 +575,7 @@ static int wm8731_startup(struct snd_pcm_substream *substream,
>>  	.symmetric_rates = 1,
>>  };
>>  
>> +#if defined(CONFIG_I2C) || defined(CONFIG_SPI_MASTER)
>>  static int wm8731_request_supplies(struct device *dev,
>>  		struct wm8731_priv *wm8731)
>>  {
>> @@ -627,6 +631,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
>>  
>>  	return ret;
>>  }
>> +#endif
> It would be better to move the declaration of
> wm8731_supply_ fnames into the second #if block so
> there would only be a single #if block.
>
Yep,  Thanks,  Will repost in v2.

Sincerely,
zhong jiang


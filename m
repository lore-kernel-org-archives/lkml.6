Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1289C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A887A20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A887A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeI3ItE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 04:49:04 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:35527 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727436AbeI3ItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 04:49:04 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 9852718024AFB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 02:18:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4EAAD180A885F;
        Sun, 30 Sep 2018 02:18:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pig96_803c423437d2d
X-Filterd-Recvd-Size: 2155
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 02:18:01 +0000 (UTC)
Message-ID: <0e30a0ab635f0348bcf582efe018e53334a276fe.camel@perches.com>
Subject: Re: [PATCH] ASoC: wm8731: Fix a unused function gcc warning
From:   Joe Perches <joe@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 29 Sep 2018 19:17:59 -0700
In-Reply-To: <1538271918-24033-1-git-send-email-zhongjiang@huawei.com>
References: <1538271918-24033-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-30 at 09:45 +0800, zhong jiang wrote:
> Fix the following compile warning:
> 
> sound/soc/codecs/wm8731.c:575:12: warning: 'wm8731_request_supplies' defined but not used [-Wunused-function]
> sound/soc/codecs/wm8731.c:600:12: warning: 'wm8731_hw_init' defined but not used [-Wunused-function]
[]
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
[]
> @@ -36,12 +36,15 @@
>  #include "wm8731.h"
>  
>  #define WM8731_NUM_SUPPLIES 4
> +
> +#if defined(CONFIG_I2C) || defined(CONFIG_SPI_MASTER)
>  static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
>  	"AVDD",
>  	"HPVDD",
>  	"DCVDD",
>  	"DBVDD",
>  };
> +#endif
>  
>  /* codec private data */
>  struct wm8731_priv {
> @@ -572,6 +575,7 @@ static int wm8731_startup(struct snd_pcm_substream *substream,
>  	.symmetric_rates = 1,
>  };
>  
> +#if defined(CONFIG_I2C) || defined(CONFIG_SPI_MASTER)
>  static int wm8731_request_supplies(struct device *dev,
>  		struct wm8731_priv *wm8731)
>  {
> @@ -627,6 +631,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
>  
>  	return ret;
>  }
> +#endif

It would be better to move the declaration of
wm8731_supply_ fnames into the second #if block so
there would only be a single #if block.



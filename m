Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ADECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD17C21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 10:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8bwdsF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD17C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIVQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 12:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeIVQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 12:29:27 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7CA21522;
        Sat, 22 Sep 2018 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537612580;
        bh=SKP2d0ZngcpuqDk48Z0U7rlMT1o+BVoWlDtq0J341SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E8bwdsF1QlDKnCUGKWxHWhxQZwMcCfYQTlZwvmqQw5tRi3Ao78lVLtyB+0o/Pvy9W
         paGgg8VexwcApdNxW6246bP8NFq1QnQQ5rWU0rphSZ6eblQiaJ/5v6cnXCFbLl2dds
         CsgBNwW+ydQMMrAx4wvDS0WfZUo46qgdnx7WxdDc=
Date:   Sat, 22 Sep 2018 11:36:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>, kbuild-all@01.org,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, nicolas.ferre@microchip.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180922113616.2d849fb0@archlinux>
In-Reply-To: <201809211544.zop1vk8B%fengguang.wu@intel.com>
References: <1537447238-18674-2-git-send-email-eugen.hristev@microchip.com>
        <201809211544.zop1vk8B%fengguang.wu@intel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 15:26:03 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Eugen,
This one is leaving me stumped...

Anyone care to point out what I'm missing that is wrong here?

Also Eugen, please don't cc stable on a patch directly.  It is fine to send
a backport request once a patch has hit mainline, but before that it's just
adding noise to a list as they won't take it directly anyway.

Jonathan

> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on v4.19-rc4 next-20180919]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Eugen-Hristev/iio-adc-at91-fix-acking-DRDY-irq-on-simple-conversions/20180920-215908
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/adc/at91_adc.c: In function 'at91_adc_trigger_handler':
> >> drivers/iio/adc/at91_adc.c:257:8: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]  
>       chan = idev->channels + i;
>            ^
> 
> vim +/const +257 drivers/iio/adc/at91_adc.c
> 
>    245	
>    246	static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>    247	{
>    248		struct iio_poll_func *pf = p;
>    249		struct iio_dev *idev = pf->indio_dev;
>    250		struct at91_adc_state *st = iio_priv(idev);
>    251		struct iio_chan_spec *chan;
>    252		int i, j = 0;
>    253	
>    254		for (i = 0; i < idev->masklength; i++) {
>    255			if (!test_bit(i, idev->active_scan_mask))
>    256				continue;
>  > 257			chan = idev->channels + i;  
>    258			st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
>    259			j++;
>    260		}
>    261	
>    262		iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
>    263	
>    264		iio_trigger_notify_done(idev->trig);
>    265	
>    266		/* Needed to ACK the DRDY interruption */
>    267		at91_adc_readl(st, AT91_ADC_LCDR);
>    268	
>    269		enable_irq(st->irq);
>    270	
>    271		return IRQ_HANDLED;
>    272	}
>    273	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


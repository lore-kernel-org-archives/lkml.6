Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5333CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD2421480
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD2421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGPLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:41:03 -0400
Received: from www381.your-server.de ([78.46.137.84]:60914 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeGPLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:41:02 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1ff1S1-0002fK-7G; Mon, 16 Jul 2018 13:13:57 +0200
Received: from [2003:8b:4817:700:8200:bff:fe9b:6612]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1ff1S1-0005li-0J; Mon, 16 Jul 2018 13:13:57 +0200
Subject: Re: [PATCH 1/5] iio: adxl372: New driver for Analog Devices ADXL372
 Accelerometer
To:     Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, shreeya.patel23498@gmail.com,
        mirq-linux@rere.qmqm.pl, thierry.escande@collabora.com,
        himanshujha199640@gmail.com, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1531409663-19846-1-git-send-email-stefan.popa@analog.com>
 <20180715105121.4c94bc53@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a54890d1-9ca4-b026-5c9c-539cf840315b@metafoo.de>
Date:   Mon, 16 Jul 2018 13:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180715105121.4c94bc53@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24757/Mon Jul 16 06:56:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15/2018 11:51 AM, Jonathan Cameron wrote:
> On Thu, 12 Jul 2018 18:34:23 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
>> This patch adds basic support for Analog Devices ADXL372 SPI-Bus
>> Three-Axis Digital Accelerometer.
>>
>> The device is probed and configured the with some initial default
>> values. With this basic driver, it is possible to read raw acceleration
>> data.
>>
>> Datasheet:
>> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf
>>
>> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> 
> Hi Stefan,
> 
> Looks pretty good, but a few comments inline.
> 
> The slightly 'unusual' register read / write field in the least significant
> bit is a pain.  I really don't like the approach of 'fiddling' the register
> addresses each time though so I think you need a custom version of
> regmap-spi to deal with this inside.  I wonder how often this
> pattern actually occurs and whether it's worth thinking about extending
> the core regmap to deal with it (so add a shift value for addresses).

regmap should be able to handle this as is. pad_bits = 1, reg_bits = 7
should ensure the correct behavior.


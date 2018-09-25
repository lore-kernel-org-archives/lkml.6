Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A25C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CBE2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CBE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeIYUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:44:51 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:53139 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbeIYUou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:44:50 -0400
Received: (qmail 6821 invoked by uid 5089); 25 Sep 2018 14:37:01 -0000
Received: by simscan 1.2.0 ppid: 6739, pid: 6741, t: 0.3026s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-RBL:  $rbltext
Received: from unknown (HELO ?10.1.1.211?) (preid@electromag.com.au@124.148.255.50)
  by anchovy3.45ru.net.au with ESMTPA; 25 Sep 2018 14:37:00 -0000
Subject: Re: [PATCH 2/2] iio: magnetometer: Add driver support for PNI RM3100
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20180925031724.21399-2-songqiang1304521@gmail.com>
 <20180925143054.00007fcb@huawei.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <57d8a9d6-c402-068e-0a21-bbd6c20a7816@electromag.com.au>
Date:   Tue, 25 Sep 2018 22:36:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925143054.00007fcb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 9:30 PM, Jonathan Cameron wrote:
>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	struct regmap *regmap = data->regmap;
>> +	u8 buffer[9];
>> +	int ret;
>> +	int i;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = rm3100_wait_measurement(data);
>> +	if (ret < 0) {
>> +		mutex_unlock(&data->lock);
>> +		goto done;
>> +	}
>> +
>> +	ret = regmap_bulk_read(regmap, RM3100_REG_MX2, buffer, sizeof(buffer));
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		goto done;
>> +
>> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for padding. */
>> +	for (i = 0; i < 3; i++)
>> +		memcpy(data->buffer + i * 4, buffer + i * 3, 3);
> Firstly X doesn't need copying.
> Secondly the copy of Y actually overwrites the value of Z
> XXXYYYZZZxxx
> XXXxYYYZZxxx
> XXXxYYYxYZZx
> 
> I think...
> 
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>> +			iio_get_time_ns(indio_dev));

memcpy target is a different buffer so should be ok.

But that raises the question of does it need to be?
'buffer' could be 12 bytes long and just shuffle Z then Y.
Do the unused bytes need to be zeroed? or does libiio mask them anyway?



-- 
Regards
Phil Reid

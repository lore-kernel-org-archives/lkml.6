Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3E520C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3E520C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeHTUAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:00:22 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56444 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeHTUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:00:22 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 16:00:21 EDT
Received: from roundcube.retrosnub.co.uk (hati.retrosnub.co.uk [IPv6:2a00:1098:86::4:1])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5F3AF9E75A7;
        Mon, 20 Aug 2018 17:37:08 +0100 (BST)
Received: from [86.188.218.117]
 by roundcube.retrosnub.co.uk
 with HTTP (HTTP/1.1 POST); Mon, 20 Aug 2018 17:37:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Aug 2018 17:37:08 +0100
From:   jic23@kernel.org
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Stefan Popa <stefan.popa@analog.com>, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adxl372: Provide validate_trigger and
 validate_device callbacks
In-Reply-To: <1fc5f7bb-67d1-fa03-2242-b38b94a151ee@metafoo.de>
References: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
 <1fc5f7bb-67d1-fa03-2242-b38b94a151ee@metafoo.de>
Message-ID: <f969da516d7185d84ae3c5abb51ab58b@kernel.org>
X-Sender: jic23@kernel.org
User-Agent: Roundcube Webmail/1.2.5 (Retrosnub)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2018 16:47, Lars-Peter Clausen wrote:
> On 08/20/2018 04:53 PM, Stefan Popa wrote:
>> This patch provides a validate_device callback for the trigger which 
>> makes
>> sure that other devices are rejected.
>> 
>> Signed-off-by: Stefan Popa <stefan.popa@analog.com
>> ---
>>  drivers/iio/accel/adxl372.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
>> index d2fdc75..5a039ba 100644
>> --- a/drivers/iio/accel/adxl372.c
>> +++ b/drivers/iio/accel/adxl372.c
>> @@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct 
>> iio_trigger *trig,
>>  	return adxl372_set_interrupts(st, mask, 0);
>>  }
>> 
>> +static int adxl372_validate_trigger(struct iio_dev *indio_dev,
>> +				    struct iio_trigger *trig)
>> +{
>> +	struct adxl372_state *st = iio_priv(indio_dev);
>> +
>> +	if (st->dready_trig != trig)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct iio_trigger_ops adxl372_trigger_ops = {
>> +	.validate_device = &iio_trigger_validate_own_device,
>>  	.set_trigger_state = adxl372_dready_trig_set_state,
>>  };
>> 
>>  static const struct iio_info adxl372_info = {
>> +	.validate_trigger = &adxl372_validate_trigger,
> 
> I wonder, if the device only works with the trigger and the trigger 
> only
> works with the device should we actually register a trigger?
> 
> Seems to be just extra hassle when setting up the device without any 
> extra
> benefits.

I wondered the same, but there is a reason to do this if we think we
will eventually have support for other triggers (which looks possible 
for
this device as we can bypass the fifo).  Then we want to do it in order
to avoid a breaking ABI change.  There is a way around that by setting
a default trigger so that it'll still use this one unless it is 
explicitly
set but that is rather ugly!

Jonathan

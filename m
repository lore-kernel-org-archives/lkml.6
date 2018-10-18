Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0301ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BDE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BDE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeJSBWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:22:02 -0400
Received: from www381.your-server.de ([78.46.137.84]:45698 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeJSBWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:22:02 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gDBxn-0005Fo-9C; Thu, 18 Oct 2018 19:19:59 +0200
Received: from eisbaer.ursus-maritimus.org ([78.47.220.141] helo=[127.0.0.1])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gDBxm-000WBD-Lj; Thu, 18 Oct 2018 19:19:59 +0200
Subject: Re: [PATCH 1/2] staging: iio: ad7606: Move out of staging
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
References: <1539853832-26534-1-git-send-email-stefan.popa@analog.com>
 <20181018125502.2hnp3s45lk6dggqt@mwanda>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2199f866-4c23-5424-3459-b966514414ce@metafoo.de>
Date:   Thu, 18 Oct 2018 19:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018125502.2hnp3s45lk6dggqt@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/25048/Thu Oct 18 14:58:26 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 02:55 PM, Dan Carpenter wrote:
> On Thu, Oct 18, 2018 at 12:10:32PM +0300, Stefan Popa wrote:
>> +static int ad7606_read_samples(struct ad7606_state *st)
>> +{
>> +	unsigned int num = st->chip_info->num_channels;
>> +	u16 *data = st->data;
>> +	int ret;
>> +
>> +	/*
>> +	 * The frstdata signal is set to high while and after reading the sample
>> +	 * of the first channel and low for all other channels. This can be used
>> +	 * to check that the incoming data is correctly aligned. During normal
>> +	 * operation the data should never become unaligned, but some glitch or
>> +	 * electrostatic discharge might cause an extra read or clock cycle.
>> +	 * Monitoring the frstdata signal allows to recover from such failure
>> +	 * situations.
>> +	 */
>> +
>> +	if (st->gpio_frstdata) {
>> +		ret = st->bops->read_block(st->dev, 1, data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> 
> This check should maybe be:
> 
> 		if (gpiod_get_value(st->gpio_frstdata) <= 0) {
> 
> (Or possibly not, I don't know the code very well).

gpiod_get_value() is only allowed to return either 0 or 1.

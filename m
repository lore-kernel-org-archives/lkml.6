Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD95EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC712086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC712086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeGQJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:58:52 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:53020 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbeGQJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:58:51 -0400
Received: (qmail 23729 invoked by uid 5089); 17 Jul 2018 09:27:09 -0000
Received: by simscan 1.2.0 ppid: 23635, pid: 23636, t: 0.0474s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 17 Jul 2018 09:27:08 -0000
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel@pengutronix.de,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
 <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
 <20180717090920.zy6lkeqlcewhrfs5@ninjato>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
Date:   Tue, 17 Jul 2018 17:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717090920.zy6lkeqlcewhrfs5@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 17:09, Wolfram Sang wrote:
> Hi Phil,
> 
>>> -	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
>>> +	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>>>    	if (IS_ERR(gpio)) {
>>>    		r = PTR_ERR(gpio);
>>>    		if (r == -ENOENT || r == -ENOSYS)
>>>
>>
>> This was intentional. The gpio we use to drive the i2c line is implemented in an
>> FPGA and signals a buffer attached to the GPIO to drive scl OPEN drain. The GPIO is output
>> only.
> 
> So, it is not possible to read SCL status then? Hmm, currently a working
> get_scl is required...
> 
>> The gpio setup can still specify the the GPIO be allocated OPEN drain if someone wishes
>> to use a "smarter" gpio.
>>
>> So while the scl is open drain, there may be hardware in between that isn't.
>> What would the correct way be to deal with that now?
> 
> Well, I don't know much about this IP core and how/where it is used. I
> just wonder what happens if another user comes along using an
> open-drain GPIO. Is that possible?
> 
> I assume it is the same with SDA? Non open-drain? Output only?
> 

Just had a closer look at how it's setup here.
Maybe the following helps.

The designware core is routed thru the fpga fabric.
Which provides and SCL SDA output enable pin.

Recovery gpio are provided by a FPGA gpio IO core.
This core has a fixed output and fixed input.

Here's the relevant bit on how it's all combined.
PWR_SDA_a / PWR_SCL_a are the signals to the outside world.
All the other signals are internal

   I2c0_Dat_s <= PWR_SDA_a;
   I2c0_Clk_s <= PWR_SCL_a;
   PWR_SDA_a <= '0' when  (I2c0_Dat_Oe_s = '1') else 'Z';

This bit of logic combines the i2c core and gpios.
   PWR_SCL_a <= '0' when ((I2c0_Clk_Oe_s = '1') or (PWR_SCL_rec_s = '0')) else 'Z';

     , pio_io_in_port(1)                   => PWR_SCL_a
     , pio_io_in_port(2)                   => PWR_SDA_a

     , pio_io_out_port(1)                  => PWR_SCL_rec_s

pio_io_out_port port is the fixed config for output
pio_io_in_port is the fixed config for input

The gpio input / outputs exist in the same ip core.

PWR_SCL_rec_s is the recovery clock gpio signal. It needs to be driven high / low.
There's no concept of HiZ internally in the FPGA.

If there was some kinda of OpenDrain gpio driver that modelled a FET driven by a push pull GPIO I guess
it could be made to work.

-- 
Regards
Phil Reid


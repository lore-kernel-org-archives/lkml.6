Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5155FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A005820856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A005820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeGYEgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:36:17 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:35262 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeGYEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:36:15 -0400
Received: (qmail 26094 invoked by uid 5089); 25 Jul 2018 03:26:36 -0000
Received: by simscan 1.2.0 ppid: 25986, pid: 25987, t: 0.0508s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 25 Jul 2018 03:26:36 -0000
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
 <b8d7c7aa-dbde-3037-4a1b-691bcf045131@electromag.com.au>
 <20180724072637.smhlrx4kpyh6hvwa@ninjato>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <4163910a-f37b-5987-ecc2-074cebda753b@electromag.com.au>
Date:   Wed, 25 Jul 2018 11:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724072637.smhlrx4kpyh6hvwa@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2018 15:26, Wolfram Sang wrote:
> Hi Phil,
> 
>>> So, it is not possible to read SCL status then? Hmm, currently a working
>>> get_scl is required...
> ...
>>> Well, I don't know much about this IP core and how/where it is used. I
>>> just wonder what happens if another user comes along using an
>>> open-drain GPIO. Is that possible?
>>>
>>> I assume it is the same with SDA? Non open-drain? Output only?
>>>
>>
>> Just had a closer look at how it's setup here.
>> Maybe the following helps.
> 
> Thanks for the detailed explanation. I am just afraid it is a litle too
> detailed for me. I am not sure if I can read it correctly:
> 
> When you read the SCL/SDA GPIO, does it return the true state of the
> SCL/SDA line or does it just reflect the value it was set to output?
Yes it returns the true state of the output pin.
I admit it's a bit odd from the classic GPIO point of view.

> 
>> There's no concept of HiZ internally in the FPGA.
> 
> Which probably means SDA is to be treated the same as SCL -> push/pull.
Yes. They're both driven push/pull, but the try state of the line is available.

> 
>> If there was some kinda of OpenDrain gpio driver that modelled a FET
>> driven by a push pull GPIO I guess it could be made to work.
> 
> Still, that sounds quite unlikely to me, so we can for now assume that
> all designware users will have push/pull?
I know of one other doing the same thing with the core in the Altera SocFPGA platform.
As they put me on to this solution for doing the recovery when the i2c was routed thru the SOC's fpga.

In other hard configurations they may have a 'proper' GPIO available that needs to be OpenDrain.



> 
> Disclaimer: I have zero experience with this core, I don't know how hard
> it is to modify or which versions are out there.
> 


-- 
Regards
Phil Reid

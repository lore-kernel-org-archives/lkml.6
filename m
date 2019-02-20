Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C43206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfBTPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:18:11 -0500
Received: from mail.steuer-voss.de ([85.183.69.95]:34232 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:18:11 -0500
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id E4FCE4D065; Wed, 20 Feb 2019 16:18:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id E0A4C4D05B;
        Wed, 20 Feb 2019 16:18:04 +0100 (CET)
Date:   Wed, 20 Feb 2019 16:18:04 +0100 (CET)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
In-Reply-To: <be1f988c-5b2f-91cf-d210-1e28c09f106f@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1902201616290.8597@fox.voss.local>
References: <20180425142209.30745-1-heikki.krogerus@linux.intel.com> <20190220110017.BFA344CE86@mail.steuer-voss.de> <20190220125731.02E274CFE0@mail.steuer-voss.de> <be1f988c-5b2f-91cf-d210-1e28c09f106f@roeck-us.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019, Guenter Roeck wrote:
> On 2/20/19 4:57 AM, Nikolaus Voss wrote:
>> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
>> adapters, but the problem described with regmap-i2c not handling
>> SMBus block transfers (i.e. read and writes) correctly also exists
>> with writes.
>> 
>> As workaround, this patch adds a block write function the same way
>> 1a2f474d328f adds a block read function.
>> 
>> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately 
>> with plain-I2C adapters")
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery 
>> controllers")
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>> v2: fix tps6598x_exec_cmd also
>> ---
>>   drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
>> index c84c8c189e90..c54b73fb2a2f 100644
>> --- a/drivers/usb/typec/tps6598x.c
>> +++ b/drivers/usb/typec/tps6598x.c
>> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void 
>> *val, size_t len)
>>   	return 0;
>>   }
>>   +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>> +				void *val, size_t len)
>> +{
>> +	u8 data[len + 1];
>> +
>
> You should use TPS_MAX_LEN + 1 here to avoid the variable length array.
> See upstream commit 0bb95f80a38f8 ("Makefile: Globally enable VLA warning")
> and 8d361fa2c29dc ("usb: typec: tps6598x: Remove VLA usage"). Not sure if
> the WARN_ON introduced by 8d361fa2c29dc is really needed; I dislike
> unnecessary runtime checks.

Thanks for the pointer, I fixed this...

Nikolaus

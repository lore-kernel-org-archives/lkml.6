Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeDCMMv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:12:51 -0400
Received: from smtp15.mail.ru ([94.100.176.133]:50750 "EHLO smtp15.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbeDCMMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:12:50 -0400
Subject: Re: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
 <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
 <20180403114006.u7tz2c7lvofsqwtg@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <34b3af7e-8e05-b131-d3ac-4920daf6343a@orpaltech.com>
Date: Tue, 3 Apr 2018 15:12:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403114006.u7tz2c7lvofsqwtg@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp15.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5AAA831C4D1275B73B582B4C635EB0959EE928EAF31F0B597725E5C173C3A84C30584FF81F342DA076FACFDC58F4FDB698CCB3ED2A1DE2304C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917CD963AD9F8FACFE52ECB286ACEAC7BBA069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 02:40 PM, Maxime Ripard wrote:
> On Tue, Apr 03, 2018 at 02:08:43PM +0300, Sergey Suloev wrote:
>> On 04/03/2018 11:10 AM, Maxime Ripard wrote:
>>> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>>>> There is no need to handle 3/4 empty/full interrupts as the maximum
>>>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>>>> SoCs.
>>> That assumes that you'll be able to treat the FIFO full interrupt and
>>> drain the FIFO before we have the next byte coming in. This would
>>> require a real time system, and we're not in one of them.
>> AFAIK in SPI protocol we send and receive at the same time.
> It depends. The protocol allows it yes, but most devices I've seen can
> only operate in half duplex. But it's not really the point.
>
>> As soon as the transfer length is <= FIFO depth then it means that
>> at the moment we get TC interrupt all data for this transfer
>> sent/received already.
>>
>> Is your point here that draining FIFO might be a long operation and we can
>> lose next portion of data ?
> My point is that, if you get another interrupt(s) right before the
> FIFO full interrupt, that interrupt is going to be masked for as long
> as it is needed for the previous handler(s) to execute.
>
> If you're having another byte received while the interrupt is masked,
> you're losing data.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

ok, I am going to put back 3/4 full handler then.

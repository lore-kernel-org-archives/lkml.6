Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDIMAD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:00:03 -0400
Received: from smtp47.i.mail.ru ([94.100.177.107]:59224 "EHLO smtp47.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeDIMAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:00:01 -0400
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
 <20180409113603.2iexkqvyeqmysp5e@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <0e2fefa5-b6e7-5e42-cf6e-8fc921f972dd@orpaltech.com>
Date: Mon, 9 Apr 2018 14:59:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409113603.2iexkqvyeqmysp5e@flea>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A50BB0DBCD8E08F1621EE9EE00ADE1A8F6E04EAE875677D07E725E5C173C3A84C3A1C30C8AFC676C8BBE60D505D8957FE9CCFFBAE954C2DE44C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D849173CADCD3248F81C39A73BF5B14D1B1C02069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 02:36 PM, Maxime Ripard wrote:
> On Mon, Apr 09, 2018 at 02:10:40PM +0300, Sergey Suloev wrote:
>> On 04/09/2018 01:50 PM, Mark Brown wrote:
>>> On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
>>>> On 04/09/2018 12:27 PM, Maxime Ripard wrote:
>>>>> On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
>>>>>> On 04/06/2018 10:34 AM, Maxime Ripard wrote:
>>>>>> According to what you said the driver must implement
>>>>>> "transfer_one_message" instead of "transfer_one"
>>>>> I'm not sure what makes you think that I said that.
>>>> Because current implementation tries to send more than FIFO-depth of data in
>>>> a single call to "transfer_one" which is wrong.
>>> No, that's absolutely not the case.  All any of these functions has to
>>> do is transfer whatever they were asked to, how they do it is not at all
>>> important to the framework.
>> I think you don't fully understand the issue. Let's talk about sun4i and
>> sun6i SPI  drivers separately.
>>
>> sun4i
>>
>> 1)it is correctly declaring max_transfer_size=FIFO depth for PIO mode  but
>> transfer_one() function doesn't follow the declaration allowing PIO
>> transfers longer than FIFO depth  by just refilling FIFO using 3/4 FIFO
>> empty interrupt. I can definitely state here that long transfers WON'T WORK
>> on real hardware.
> Surely the original author of the patch allowing to do just that
> disagrees with you.
I am not getting the point why the driver is declaring the max transfer 
length value and not following the rule.
> And it's not about the hardware itself, it's about
> how the driver operates as well.
>
>> I tested it and that's why I can say that.
> Then it must be fixed, and not silently reverted.
>
>> But as soon as sun4i SPI driver  is correctly declaring
>> max_transfer_size then "smart" clients will work well by limiting a
>> single transfer size to FIFO depth. I tested it with real hardware,
>> again.
> This is really not my point. What would prevent you from doing
> multiple transfers in that case, and filling the FIFO entirely,
> waiting for it to be done, then resuming until you have sent the right
> number of bytes?
Because it makes no sense IMHO. I can't see any single point in allowing 
long PIO transfers. Can you find at least one ?

I think we should reuse as much SPI core code as possible. The SPI core 
can handle an SPI message with multiple transfers,
all we need is to have max_transfer_size = FIFO depth and restrict it in 
transfer_one().

>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

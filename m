Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDILKt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:10:49 -0400
Received: from smtp43.i.mail.ru ([94.100.177.103]:58288 "EHLO smtp43.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeDILKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:10:48 -0400
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
To: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
Date: Mon, 9 Apr 2018 14:10:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409105001.GC11532@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Authentication-Results: smtp43.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5DA60E13DFBE702210E2B8329FB0861BC3E017661983E1680725E5C173C3A84C3A1C30C8AFC676C8B9E7D8EADAC458C63843AE0F20224B8D0C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917910E9D38B7A2C135A0E49671BDC5AC63069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 01:50 PM, Mark Brown wrote:
> On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
>> On 04/09/2018 12:27 PM, Maxime Ripard wrote:
>>> On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
>>>> On 04/06/2018 10:34 AM, Maxime Ripard wrote:
>>>> According to what you said the driver must implement
>>>> "transfer_one_message" instead of "transfer_one"
>>> I'm not sure what makes you think that I said that.
>> Because current implementation tries to send more than FIFO-depth of data in
>> a single call to "transfer_one" which is wrong.
> No, that's absolutely not the case.  All any of these functions has to
> do is transfer whatever they were asked to, how they do it is not at all
> important to the framework.

I think you don't fully understand the issue. Let's talk about sun4i 
and  sun6i SPI  drivers separately.

sun4i

1)it is correctly declaring max_transfer_size=FIFO depth for PIO mode  
but transfer_one() function doesn't follow the declaration allowing PIO 
transfers longer than FIFO depth  by just refilling FIFO using 3/4 FIFO 
empty interrupt. I can definitely state here that long transfers WON'T 
WORK on real hardware. I tested it and that's why I can say that. But as 
soon as sun4i SPI driver  is correctly declaring max_transfer_size then 
"smart" clients will work well by limiting a single transfer size to 
FIFO depth. I tested it with real hardware, again.


sun6i

2) it allows PIO transfers of any length by declaring max_transfer_size 
to a huge number, i.e. you can ONLY make this driver work in PIO mode  
by limiting a single transfer size to FIFO depth (64 or 128 bytes) on 
client side  and ignore max_transfer_size  exposed by the driver. Again, 
tested with real hardware.

All above doesn't work for DMA mode as there is no such limitation.

I can't clearly explain what is happening in the hardware in PIO mode 
but it seems that TC interrupt doesn't arrive in time when refilling 
FIFO multiple times takes place and every long transfer will end up with 
a timeout error.

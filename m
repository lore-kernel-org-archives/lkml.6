Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDFPy2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:54:28 -0400
Received: from smtp60.i.mail.ru ([217.69.128.40]:44608 "EHLO smtp60.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbeDFPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:54:27 -0400
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
From: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <46df9f95-a93f-57af-b7d9-dfd5db046622@orpaltech.com>
Date: Fri, 6 Apr 2018 18:54:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406073441.xesojvzc3deljhoy@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: smtp60.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5E42134B4FCCBF9A2FECD081630875D8E08403B7F31821B75725E5C173C3A84C3A1C30C8AFC676C8B4A628EF8AAF77906C6C49853BF2B2AEEC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491768DA1BE0602F42875B935239C30F4989069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 10:34 AM, Maxime Ripard wrote:
> On Thu, Apr 05, 2018 at 04:44:16PM +0300, Sergey Suloev wrote:
>> On 04/05/2018 04:17 PM, Mark Brown wrote:
>>> On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
>>>> On 04/05/2018 12:19 PM, Maxime Ripard wrote:
>>>>> The point of that patch was precisely to allow to send more data than
>>>>> the FIFO. You're breaking that behaviour without any justification,
>>>>> and this is not ok.
>>>> I am sorry, but you can't. That's a hardware limitation.
>>> Are you positive about that?  Normally you can add things to hardware
>>> FIFOs while they're being drained so so long as you can keep data
>>> flowing in at least as fast as it's being consumed.
>> Well, normally yes, but this is not the case with the hardware that I own.
>> My a20 (BPiM1+) and a31 (BPiM2) boards behaves differently. With a transfer
>> larger than FIFO then TC interrupt never happens.
> Because you're not supposed to have a transfer larger than the FIFO,
> but to have to setup at first a transfer the size of the FIFO, and
> then when it's (or starts to be) depleted, fill it up again.
According to what you said the driver must implement 
"transfer_one_message" instead of "transfer_one",
because the maximum transfer length is 64 bytes (for sun4i) and we 
shouldn't allow "transfer_one" handle
more than 64 bytes. Otherwise it breaks the concept.
>
> That's the point of the patch you're reverting, and if it doesn't
> work, you should make it work and not simply revert it.
>
> Maxime
>

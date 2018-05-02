Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEBLDh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:03:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57148 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751011AbeEBLCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:02:10 -0400
Subject: Re: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
 <20180502093601.fvkacdv62aqxshbr@flea>
From: Andre Przywara <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Message-ID: <aa2d6072-87a5-cd52-d3a5-17df889e6bc9@arm.com>
Date: Wed, 2 May 2018 12:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502093601.fvkacdv62aqxshbr@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/05/18 10:36, Maxime Ripard wrote:
> On Mon, Apr 30, 2018 at 10:47:35AM +0100, Andre Przywara wrote:
>>>> I am just asking because I want to avoid running into the same problem
>>>> as with the A64 before: that future DTs become incompatible with older
>>>> kernels, because we change the power supply to point to the AXP
>>>> regulators, which this kernel does not support yet.
>>>
>>> The answer is just not to keep this compatibility, as it's not
>>> supported option to update DT without updating kernel.
>>
>> Well, I recognise that statement.. ;-) and I understand that it's far
>> easier to handle it this way. But:
>> - Which .dtb are we going to write into the SPI flash? An older one,
>> which covers all kernels, but lacks features? Or a newer one, which
>> limits the bootable kernels to recent versions?
>> - Which DT are we going to give to EFI applications?
>> - Which DT are the BSDs suspected to take? They don't ship their own DTs
>> (which is good!).
>>
>> So I understand that "shipping the DT with the kernel" is the old
>> (embedded!) way of doing things, but I really believe we should stop
>> relying on this and try to come up with backwards compatible DTs, which
>> live in the firmware and get updated there. Because this is what the
>> distros seem to expect from ARM64 boards these days.
> 
> You're not talking about backward compatibility, you're talking about
> forward compatibility. All the changes in this patch and the one
> predicted by Icenowy are backward compatible.

Argh, yes, I meant forward compatibility, sorry!
Shouldn't write those emails while actually doing something completely
different ;-)

>>>> It looks like there are more users of those power rails, so we could
>>>> keep those supplies connected to these fixed regulators here, even with
>>>> AXP-805 support in the kernel.
>>>
>>> It's not a good choice.
>>>
>>>>
>>>> Or we keep this back until we get proper AXP support in the kernel? I
>>>> guess it's quite close to the existing PMICs, so it might be more a
>>>> copy&paste exercise to support the AXP-805?
>>>
>>> It's not a reason to keep it back.
>>
>> So I compared the manuals of the AXP806 and the AXP805, the register
>> interface looks identical to me. I only have a (somewhat) Chinese
>> version of the AXP806 manual, so couldn't really find the difference
>> between the two. Do you know more about it? Is it just maybe the
>> packaging and the electrical properties (like max current supported)?
>>
>> If the I2C register interface is really the same, we could just add the
>> DT nodes for the regulator and be done.
> 
> And that argument is only valid if you 100% trust the fact that both
> datasheet are complete and accurate.
> 
> And experience show that you can't.

Well, but I wonder how paranoid we are going to be? And in this case we
have confirmation from Wink that they are the same.
So I think we can go with just a DT addition, given that we test it and
confirm that it works for our use case. Should we discover something odd
or undocumented later, I'd consider this a bug fix, which we then (and
only then!) could fix by adding the compatible string to the driver. Any
DT would be fine already, because we list both compatible strings in there.

Cheers,
Andre.

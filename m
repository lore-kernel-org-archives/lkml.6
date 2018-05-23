Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754621AbeEWI5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:57:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51434 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbeEWI5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:57:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 23 May 2018 10:57:34 +0200
From: Stefan Agner <stefan@agner.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v5 1/3] ARM: dts: tegra: Remove skeleton.dtsi and fix DTC
 warnings for /memory
In-Reply-To: <CAJKOXPdwVNtDCiow-cYFdgeUVO5UuEtgmrdmHi2SvHeoZfPupg@mail.gmail.com>
References: <1526543103-21668-1-git-send-email-krzk@kernel.org>
 <cbcc6f929d2bd912c11530391d03cdf3@agner.ch>
 <CAJKOXPeOg7Xjx0qr2qZ0dLs56HFD=1=gbGh8VPeS+PgQm6QQZg@mail.gmail.com>
 <f762464c796fa1976c1ec6fde6869add@agner.ch>
 <CAJKOXPdwVNtDCiow-cYFdgeUVO5UuEtgmrdmHi2SvHeoZfPupg@mail.gmail.com>
Message-ID: <ba8102983f2ab29601e36b6b6c2ca28a@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.02 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.92)[99.65%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 10:34, Krzysztof Kozlowski wrote:
> On Wed, May 23, 2018 at 10:22 AM, Stefan Agner <stefan@agner.ch> wrote:
>> On 23.05.2018 09:05, Krzysztof Kozlowski wrote:
>>> On Thu, May 17, 2018 at 1:39 PM, Stefan Agner <stefan@agner.ch> wrote:
>>>> On 17.05.2018 09:45, Krzysztof Kozlowski wrote:
>>>> Could we not add
>>>>
>>>>         memory { device_type = "memory"; };
>>>>
>>>> in the SoC level device trees?
>>>>
>>>> This would save device_type in all other instances.
>>>>
>>>> That is also how it is done in other places, e.g.
>>>> arch/arm/boot/dts/imx6qdl.dtsi
>>>
>>> Not really because the unit address will not match between different
>>> boards. The imx6qdl, as I see, has the same issue:
>>>  - imx6qdl.dtsi defines "memory" node
>>>  - imx6dl-apf6dev.dts includes the previous and defines "memory@10000000"
>>>
>>> This is wrong - two memory nodes.
>>>
>>
>> Hm I see. We could add
>>
>> memory@0 { device_type = "memory"; };
>>
>> Since the reg property is specified in the board level device tree it
>> would be still fine?
>>
>> Or probably better to provide a complete spec with length zero:
>>
>> memory@0 {
>>         device_type = "memory";
>>         reg = <0x0 0x0>;
>> };
>>
>> Even some boards do that and assume that boot loader will fill it
>> correctly, so that should be fine.
> 
> That could be the solution although tegra30-apalis.dtsi is a problem
> here. For Tegra 114, 124 and 20 it would work fine - all boards from
> given SoC have the same address of memory (0x0 or 0x80000000). However
> for Tegra30 the Apalis did not have any memory reg before so I am not
> sure what should be used. I added 0x0. The other Tegra30 boards have
> memory@80000000.

The start address of memory is not something a board can decide on: That
is hard wired in the SoC...

In the Tegra 3 case the start address of main memory is 0x80000000.

So

	memory@80000000 {
		reg = <0x80000000 0x0>;
	};


Should be fine.

Or you can use 0x40000000 (1GiB) since that is the smallest
configuration Toradex sells currently.


	memory@80000000 {
		reg = <0x80000000 0x40000000>;
	};

Sorry for the hassle and thanks for fixing this!

--
Stefan

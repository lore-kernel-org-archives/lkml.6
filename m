Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeEKDpu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:45:50 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:52170 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:45:48 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 183.57.25.242
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <14b209c465b9d4dad2f279c56d4daae4>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v1 3/5] arm64: dts: rockchip: Add gpio-syscon10 to rk3328
To: Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        William Wu <william.wu@rock-chips.com>,
        Rocky Hao <rocky.hao@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-4-git-send-email-djw@t-chip.com.cn>
 <76f2bbde-e158-a186-f136-9fb610a810c5@arm.com>
From: Levin Du <djw@t-chip.com.cn>
Message-ID: <3fdfcc9b-90b5-191c-37e0-c99389a4e872@t-chip.com.cn>
Date: Fri, 11 May 2018 11:45:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <76f2bbde-e158-a186-f136-9fb610a810c5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 8:50 PM, Robin Murphy wrote:
> On 10/05/18 10:16, djw@t-chip.com.cn wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>>
>> Adding a new gpio controller named "gpio-syscon10" to rk3328, providing
>> access to the pins defined in the syscon GRF_SOC_CON10.
>
> This is the GPIO_MUTE pin, right? The public TRM is rather vague, but 
> cross-referencing against the datasheet and schematics implies that 
> it's the "gpiomut_*" part of the GRF bit names which is most significant.
>
> It might be worth using a more descriptive name here, since "syscon10" 
> is pretty much meaningless at the board level.
>
> Robin.
>
Previously I though other bits might be able to reference from syscon10, 
other than GPIO_MUTE alone.
If it is renamed to gpio-mute, then the GPIO_MUTE pin is accessed as 
`<&gpio-mute 1>`. Yet other
bits in syscon10 can also be referenced, say, `<&gpio-mute 10>`, which 
is not good.

I'd like to add a `gpio,syscon-bit` property to gpio-syscon, which 
overrides the properties
of bit_count,  data_bit_offset and dir_bit_offset in the driver. For 
example:

                 gpio_mute: gpio-mute {
                         compatible = "rockchip,gpio-syscon";
                         gpio-controller;
                         #gpio-cells = <2>;
                         gpio,syscon-dev = <0 0x0428 0>;
                         gpio,syscon-bit = <1 1 0>;
                 };

That way, the mute pin is strictly specified as <&gpio_mute 0>, and 
<&gpio_mute 1> will be invalid.
I think that is neat, and consistent with the gpio_mute name.

Thanks
Levin

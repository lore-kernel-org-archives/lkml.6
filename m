Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936009AbeEYNfu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:35:50 -0400
Received: from mout01.posteo.de ([185.67.36.141]:36266 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935320AbeEYNfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:35:47 -0400
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
        broonie@kernel.org
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
 <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
 <4d70c73e-9db7-bdff-7414-04a4843acae3@sorico.fr>
 <391de5c1-45d7-4773-fe57-7f2bc747214b@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <f817c82a-95b6-afb3-e662-c481a877cf01@sorico.fr>
Date: Fri, 25 May 2018 15:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <391de5c1-45d7-4773-fe57-7f2bc747214b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2018 14:17, Radu Pirea wrote:
> 
> 
> On 05/15/2018 04:14 PM, Richard Genoud wrote:
>> On 15/05/2018 14:47, Radu Pirea wrote:
>>> On Mon, 2018-05-14 at 12:57 +0200, Richard Genoud wrote:
>>>> After your patch, the DMA is not selected anymore:
>>>> atmel_usart_serial atmel_usart_serial.0.auto: TX channel not
>>>> available, switch to pio
>>>> instead of:
>>>> atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers
>>>>
>>> Fixed.
>>>> And the kernel doesn't log anymore on the serial console, despite the
>>>> loglevel=8
>>>> (after reverting this series, the kernel logs reappears on the serial
>>>> console)
>>>>
>>> Which serial are you using as console?
>> fffff200.serial (sam9g35-cm)
>> ( stdout-path = "serial0:115200n8"; in the DTS )
>>
>> With this series applied, all the kernel log goes on the screen.
>> Without, it goes on the serial debug.
>>
> I tested again with archlinux arm and poky-linux4sam release as distros
> and kernel log goes on the serial debug. Can you give me more details
> like cmdline?
I used kernel 4.17-rc6
at91_dt_defconfig
at91sam9g35ek.dtb

Kernel command line: root=/dev/mtdblock1 rw rootfstype=ubifs ubi.mtd=1 root=ubi0:rootfs
( the one from the DTS )

Detailed instructions:

git checkout v4.17-rc6 
ARCH=arm CROSS_COMPILE=path_to_my_Xchain/arm-linux- LOADADDR=0x20008000 make -j 12 at91_dt_defconfig
ARCH=arm CROSS_COMPILE=path_to_my_Xchain/arm-linux- LOADADDR=0x20008000 make -j 12 uImage at91sam9g35ek.dtb
cp arch/arm/boot/uImage arch/arm/boot/dts/at91sam9g35ek.dtb /tftpboot/

>From uboot:
tftpboot 0x20007FC0 uImage
tftpboot 0x26400000 at91sam9g35ek.dtb
bootm 0x20007FC0 - 0x26400000

[ I see the logs on the serial debug ]

git am \[PATCH\ v3\ [1-6]*

ARCH=arm CROSS_COMPILE=path_to_my_Xchain/arm-linux- LOADADDR=0x20008000 make -j 12 uImage at91sam9g35ek.dtb
cp arch/arm/boot/uImage arch/arm/boot/dts/at91sam9g35ek.dtb /tftpboot/

>From uboot:
tftpboot 0x20007FC0 uImage
tftpboot 0x26400000 at91sam9g35ek.dtb
bootm 0x20007FC0 - 0x26400000

[ I don't see the logs on the serial debug anymore ]


>>>> (tests done on sam9g35)
>>>>
>>> I will consider the rest of suggestions.
>>>> regards,
>>>> Richard
>>

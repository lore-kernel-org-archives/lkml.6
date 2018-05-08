Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeEHMfu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeEHMfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:35:48 -0400
X-Google-Smtp-Source: AB8JxZq7uVdPuKsllMNmAnITB4Tf6/8Ir2hf/TIog7zN1r3cvu896kwz8Z2ZW95Wp2jghP94+dDh1zoCFy9lfUadnOY=
MIME-Version: 1.0
In-Reply-To: <1525428885.6296.18.camel@toradex.com>
References: <1525360112-9893-1-git-send-email-krzk@kernel.org>
 <c47c07b2c112219093b668c0b4d46ac8@agner.ch> <CAJKOXPeb+DmKVQ1uXkBOjaGMpxtPVFp54SBWm6h=+o30z9K3aQ@mail.gmail.com>
 <1525428885.6296.18.camel@toradex.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 8 May 2018 14:35:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPetgqJgGHwdSzZeujM2KEDMWqffYMAJdBS3MXPd3Thb5w@mail.gmail.com>
Message-ID: <CAJKOXPetgqJgGHwdSzZeujM2KEDMWqffYMAJdBS3MXPd3Thb5w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: tegra: Add support for 256 MB Colibri-T20
 (plus such board on Iris)
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "stefan@agner.ch" <stefan@agner.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dev@lynxeye.de" <dev@lynxeye.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 12:14 PM, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
> Hi Krzysztof
>
> On Fri, 2018-05-04 at 12:03 +0200, Krzysztof Kozlowski wrote:
>> On Fri, May 4, 2018 at 11:19 AM, Stefan Agner <stefan@agner.ch>
>> wrote:
>> > On 03.05.2018 17:08, Krzysztof Kozlowski wrote:
>> > > Colibri-T20 can come in 256 MB RAM (with 512 MB NAND) or 512 MB
>> > > RAM
>> > > (with 1024 MB NAND) flavors.  Add support for the 256 MB version
>> > > on Iris
>> > > evaluation board.
>> >
>> > To we really need to specify memory size these days? I think all
>> > common
>> > boot loaders fill the memory node anyway.
>> >
>> > arch/arm/boot/dts/imx6qdl-apalis.dtsi:
>> >         /* Will be filled by the bootloader */
>> >         memory@10000000 {
>> >                 reg = <0x10000000 0>;
>> >         };
>> >
>> >
>> > I think we should just rename tegra20-colibri-512.dtsi =>
>> > tegra20-colibri.dtsi and tegra20-iris-512.dts => tegra20-iris.dts
>> > to
>> > avoid confusion and add such an empty node.
>>
>> Having memory node is requirement of DeviceTree specification (at
>> least one cpu and memory node). Of course if bootloader fills it,
>> then
>> we could assume that specification is satisfied... but what if some
>> bootloader skips it? This creates quite specific dependency between
>> kernel's DTS and bootloader.
>
> Yes, no system boots without any boot loader e.g. initialising the
> memory and what not. So there are obviously quite specific
> dependencies.

Sorry for late reply, I missed your emails because unfortunately
Google marks messages coming for Toradex as spam ("This message has a
from address in toradex.com but has failed toradex.com's required
tests for authentication."). Therefore I did not include your comments
and sent v3.

>
>> One safe solution would be to specify 256 MB memory node for both
>> boards and assume that bootloader will bump it to 512 MB for specific
>> module.
>
> Like I mentioned this actually used to be how it was done however
> lately it has been agreed that any boot loader anyway needs to do the
> device tree dance (e.g. even just loading and passing it).

Then the safest way is to provide /memory node with 256 MB. If some
bootloader omits it (e.g. because it is too old or by any mistake) the
FDT will be still usable with reduced memory in case of 512 board.

>> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > >
>> > > ---
>> > >
>> > > Changes since v1:
>> > > 1. Fix memory size in tegra20-colibri-256.dtsi (was working fine
>> > > because
>> > >    my bootloader uses mem= argument).
>> >
>> > What boot loader are you using? You even can omit mem= if your boot
>> > loader fills the memory node properly.
>>
>> I use the one provided by vendor - Toradex. By default it passes both
>> mem= and few other mem-like arguments (for FB and video processor) to
>> command line. I believe it does not adjust the DTB itself because
>> Toradex prepared this bootloader for... 3.1 kernel without DTB. 7
>> years old kernel. :)
>
> Remember our regular BSP is still based on NVIDIA's downstream Linux
> for Tegra aka L4T R16.5 based on Linux kernel 3.1.10 which does not
> even use any device tree yet.

Yes, I noticed. I am trying to bring it fully on new kernels but no
huge successes so far... I'm stuck on NAND trying Lucas Stach's old
patchset.

Best regards,
Krzysztof

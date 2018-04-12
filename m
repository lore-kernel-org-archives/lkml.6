Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeDLPX5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:23:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54420 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbeDLPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:23:53 -0400
X-Google-Smtp-Source: AIpwx495F12uZZsuxxMu5dzNajaNpIkko9NtIiYur1uBL8zrFRng/QepMzCWD9E4S8odaFLe/yF1rg==
MIME-Version: 1.0
In-Reply-To: <A027702A-F3F7-4896-B2B8-E024DA521661@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io> <20180411141641.14675-4-icenowy@aosc.io>
 <20180412145628.iaaeue2imiijwx5d@flea> <A027702A-F3F7-4896-B2B8-E024DA521661@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 12 Apr 2018 23:23:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
Message-ID: <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow
 getting syscon regmap from device
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 11:11 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2018年4月12日 GMT+08:00 下午10:56:28, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>>On Wed, Apr 11, 2018 at 10:16:39PM +0800, Icenowy Zheng wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
>>> address space; on the A64 SoC this register is in the SRAM controller
>>> address space, and with a different offset.
>>>
>>> To access the register from another device and hide the internal
>>> difference between the device, let it register a regmap named
>>> "emac-clock". We can then get the device from the phandle, and
>>> retrieve the regmap with dev_get_regmap(); in this situation the
>>> regmap_field will be set up to access the only register in the
>>regmap.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> [Icenowy: change to use regmaps with single register, change commit
>>>  message]
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 48
>>++++++++++++++++++++++-
>>>  1 file changed, 46 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>> index 1037f6c78bca..b61210c0d415 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
>>> @@ -85,6 +85,13 @@ const struct reg_field old_syscon_reg_field = {
>>>      .msb = 31,
>>>  };
>>>
>>> +/* Specially exported regmap which contains only EMAC register */
>>> +const struct reg_field single_reg_field = {
>>> +    .reg = 0,
>>> +    .lsb = 0,
>>> +    .msb = 31,
>>> +};
>>> +
>>
>>I'm not sure this would be wise. If we ever need some other register
>>exported through the regmap, will have to change all the calling sites
>>everywhere in the kernel, which will be a pain and will break
>>bisectability.
>
> In this situation the register can be exported as another
>  regmap. Currently the code will access a regmap with name
> "emac-clock" for this register.
>
>>
>>Chen-Yu's (or was it yours?) initial solution with a custom writeable
>>hook only allowing a single register seemed like a better one.
>
> But I remember you mentioned that you want it to hide the
> difference inside the device.

Hi,

The idea is that a device can export multiple regmaps. This one,
the one named "gmac" (in my soon to come v2) or "emac-clock" here,
is but one of many possible regmaps, and it only exports the register
needed by the GMAC/EMAC. IMHO it is highly unlikely the same piece of
hardware would need a second register from the same device. A more
likely situation would be it needs another register from a different
device, like on the H6 where the "internal PHY" is not so internal
from a system bus point of view.

ChenYu

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759923AbeD1Nm4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 09:42:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35631 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754892AbeD1Nmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 09:42:54 -0400
X-Google-Smtp-Source: AB8JxZrtElbzCR2EoXu22yUGDAHEdgEaHENJ2Qgj5HMHEdDZSg0LVlqq/lZZfhL0BPWwp/DgL7e7Fg==
MIME-Version: 1.0
In-Reply-To: <04C9F795-2680-4220-A39A-7B7D5FD74C4A@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io> <20180411141641.14675-2-icenowy@aosc.io>
 <20180416184745.tqxyvojtcbage4fu@rob-hp-laptop> <04C9F795-2680-4220-A39A-7B7D5FD74C4A@aosc.io>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 28 Apr 2018 21:42:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v64LcyfffBFfrnUd5XOyA1POphMMgEXLoTiTQAc9tjpzgw@mail.gmail.com>
Message-ID: <CAGb2v64LcyfffBFfrnUd5XOyA1POphMMgEXLoTiTQAc9tjpzgw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 1/5] dt-bindings: allow dwmac-sun8i to
 use other devices' exported regmap
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Apr 17, 2018 at 7:17 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2018年4月17日 GMT+08:00 上午2:47:45, Rob Herring <robh@kernel.org> 写到:
>>On Wed, Apr 11, 2018 at 10:16:37PM +0800, Icenowy Zheng wrote:
>>> On some Allwinner SoCs the EMAC clock register needed by dwmac-sun8i
>>is
>>> in another device's memory space. In this situation dwmac-sun8i can
>>use
>>> a regmap exported by the other device with only the EMAC clock
>>register.
>>
>>If this is a clock, then why not use the clock binding?
>
> EMAC clock register is only the datasheet name. It contains
> MII mode selection and delay chain configuration.

As Icenowy already mentioned, this is likely a misnomer.

The register contains controls on how to route the TX and RX clock
lines, and also what interface mode to use. The former includes things
like the delays mentioned in the device tree binding, and also whether
to invert the signals or not. The latter influences whether the TXC
line is an input or an output (or maybe what decoding module to send
all the signals to). On the H3/H5, it even contains controls for the
embedded PHY.

The settings only make sense to the MAC. To expose it as a generic
clock line would not be a good fit. You can look at what we did for
sun7i-a20-gmac, which is not pretty. All other DWMAC platforms that
were introduced after sun7i-a20-gmac also use a syscon, instead of
clocks, even though they probably cover the same set of RXC/TXC
controls.

ChenYu

>>
>>>
>>> Document this situation in the dwmac-sun8i device tree binding
>>> documentation.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>>b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>>> index 3d6d5fa0c4d5..0c5f63a80617 100644
>>> --- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>>> +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
>>> @@ -20,8 +20,9 @@ Required properties:
>>>  - phy-handle: See ethernet.txt
>>>  - #address-cells: shall be 1
>>>  - #size-cells: shall be 0
>>> -- syscon: A phandle to the syscon of the SoC with one of the
>>following
>>> - compatible string:
>>> +- syscon: A phandle to a device which exports the EMAC clock
>>register as a
>>> + regmap or to the syscon of the SoC with one of the following
>>compatible
>>> + string:
>>>    - allwinner,sun8i-h3-system-controller
>>>    - allwinner,sun8i-v3s-system-controller
>>>    - allwinner,sun50i-a64-system-controller
>>> --
>>> 2.15.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe devicetree"
>>in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

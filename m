Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCZHt4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:49:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44947 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeCZHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:49:54 -0400
X-Google-Smtp-Source: AG47ELvsUdkuydfSKh1r2AmTj0Q+u3zaayDYaYsJ1vfgZJZxrgBfm+YjJUVEoHwjGq8rdWxdOJApZQ==
Subject: Re: [PATCH 1/4] dt-bindings: clock: meson: update documentation with
 hhi syscon
To: Rob Herring <robh@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
 <20180315115545.1884-2-jbrunet@baylibre.com>
 <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
 <1521385797.6569.90.camel@baylibre.com>
 <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <8712ae70-9771-4438-68e2-9e4b37332de8@baylibre.com>
Date: Mon, 26 Mar 2018 09:49:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 04:04, Rob Herring wrote:
> On Sun, Mar 18, 2018 at 10:09 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Sun, 2018-03-18 at 07:52 -0500, Rob Herring wrote:
>>> On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
>>>> The HHI register region hosts more than just clocks and needs to
>>>> accessed drivers other than the clock controller, such as the display
>>>> driver.
>>>>
>>>> This register region should be managed by syscon. It is already the case
>>>> on gxbb/gxl and it soon will be on axg. The clock controllers must use
>>>> this system controller instead of directly mapping the registers.
>>>
>>> Sounds like a kernel problem, not a DT one.
>>
>> It's a platform problem, so it has much a kernel problem (solution already
>> merged) as a DT problem
>>
>> DT wise, we've got two devices mapping the same region
>>
>> in arch/arm64/boot/dts/amlogic/meson-gx.dtsi:
>>> system-controller@0
>>
>> which is used by the display device.
>>
>> and in arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi (same for gxl)
>>> clock-controller@0
>>
>> It has worked so far because the clock controller claims the region w/o
>> reserving it but it remains unsafe since both device may access the same region.
>> The fix is to have the clock controller go through the existing syscon.
> 
> We certainly want to avoid multiple nodes using the same mmio region.
> 
> 
>>> With a single child, there is really no point to this change. A single
>>> node can provide multiple functions. Look at nodes that are both reset
>>> and clock providers.
>>
>> There is more than a single user, as explained above and in the cover letter of
>> this series.
> 
> Right, but a single node can support more than a single user (or
> provider). You don't have to have multiple nodes to have multiple
> users/providers.
> 
> Rob
> 

Hi Rob,

It's a question about user/provider, the syscon node represents the entire mmio
region which has multiple sparse registers for multiple features, is used
indirectly by the display driver, ... and has multiple features, non limited to,
clock controller, multiple power domains,... and it is simpler to represent these
as subnodes instead of a big fat node.

Today, it is already represented like this within the Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
So this binding is only an extension for the clock controller which was mis-architectured
at the time due to a mis-knowledge of the HW architecture.

Neil

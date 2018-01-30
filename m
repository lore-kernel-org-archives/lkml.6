Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeA3Sqd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:46:33 -0500
Received: from vern.gendns.com ([206.190.152.46]:56786 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753294AbeA3Sqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:46:30 -0500
Subject: Re: [PATCH v6 01/41] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
To: Rob Herring <robh@kernel.org>
Cc: linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-2-git-send-email-david@lechnology.com>
 <20180129195315.bjanym7pmeh7bhaa@rob-hp-laptop>
 <ffec7cac-22cd-f19b-8c1b-ce3223606d20@lechnology.com>
 <CAL_JsqK+c-C9VJnEOr0Em3Y-dtvE+CSbsc6m-0JoWJSZxKeR_g@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <7064a0d6-0969-81a0-00af-84cca339b813@lechnology.com>
Date: Tue, 30 Jan 2018 12:46:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK+c-C9VJnEOr0Em3Y-dtvE+CSbsc6m-0JoWJSZxKeR_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 08:50 AM, Rob Herring wrote:
> On Mon, Jan 29, 2018 at 3:14 PM, David Lechner <david@lechnology.com> wrote:
>> On 01/29/2018 01:53 PM, Rob Herring wrote:
>>>
>>> On Sat, Jan 20, 2018 at 11:13:40AM -0600, David Lechner wrote:
>>>>
>>>> This adds a new binding for the PLL IP blocks in the mach-davinci
>>>> family of processors. Currently, only da850 has device tree support
>>>> but these bindings can also work for other SoCs in this family just
>>>> by adding new compatible strings.
>>>>
>>>> Note: Although these PLL controllers are very similar to the TI Keystone
>>>> SoCs, we are not re-using those bindings. The Keystone bindings use a
>>>> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
>>>> have a slightly different PLL register layout and a number of quirks
>>>> that can't be handled by the existing bindings, so the keystone bindings
>>>> could not be used as-is anyway.
>>>>
>>>> Signed-off-by: David Lechner <david@lechnology.com>
>>>> ---
>>>>
>>>> v6 changes:
>>>> - Added clock-names property
>>>> - Added ti,clkmode-square-wave property
>>>> - Added pllout child node
>>>> - Added obsclk child node
>>>> - Expanded examples
>>>>
>>>>    .../devicetree/bindings/clock/ti/davinci/pll.txt   | 96
>>>> ++++++++++++++++++++++
>>>>    1 file changed, 96 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>> b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>> new file mode 100644
>>>> index 0000000..36998e1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>> @@ -0,0 +1,96 @@
>>>> +Binding for TI DaVinci PLL Controllers
>>>> +
>>>> +The PLL provides clocks to most of the components on the SoC. In
>>>> addition
>>>> +to the PLL itself, this controller also contains bypasses, gates,
>>>> dividers,
>>>> +an multiplexers for various clock signals.
>>>> +
>>>> +Required properties:
>>>> +- compatible: shall be one of:
>>>> +       - "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
>>>> +       - "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
>>>> +- reg: physical base address and size of the controller's register area.
>>>> +- clocks: phandles corresponding to the clock names
>>>> +- clock-names: names of the clock sources - depends on compatible string
>>>> +       - for "ti,da850-pll0", shall be "clksrc", "extclksrc"
>>>> +       - for "ti,da850-pll1", shall be "clksrc"
>>>> +
>>>> +Optional properties:
>>>> +- ti,clkmode-square-wave: Indicates that the the board is supplying a
>>>> square
>>>> +       wave input on the OSCIN pin instead of using a crystal
>>>> oscillator.
>>>> +       This property is only valid when compatible = "ti,da850-pll0".
>>>> +
>>>> +
>>>> +Optional child nodes:
>>>> +
>>>> +pllout
>>>> +       Describes the main PLL clock output (before POSTDIV). The node
>>>> name must
>>>> +       be "pllout".
>>>> +
>>>> +       Required properties:
>>>> +       - #clock-cells: shall be 0
>>>> +
>>>> +sysclk
>>>> +       Describes the PLLDIVn divider clocks that provide the SYSCLKn
>>>> clock
>>>> +       domains. The node name must be "sysclk". Consumers of this node
>>>> should
>>>> +       use "n" in "SYSCLKn" as the index parameter for the clock cell.
>>>> +
>>>> +       Required properties:
>>>> +       - #clock-cells: shall be 1
>>>> +
>>>> +auxclk
>>>> +       Describes the AUXCLK output of the PLL. The node name must be
>>>> "auxclk".
>>>> +       This child node is only valid when compatible = "ti,da850-pll0".
>>>> +
>>>> +       Required properties:
>>>> +       - #clock-cells: shall be 0
>>>> +
>>>> +obsclk
>>>> +       Describes the OBSCLK output of the PLL. The node name must be
>>>> "obsclk".
>>>> +
>>>> +       Required properties:
>>>> +       - #clock-cells: shall be 0
>>>
>>>
>>> So why have all these child nodes vs. just defining a single number
>>> space of clock ids?
>>>
>>> Rob
>>>
>>
>> I think that it makes the bindings more self-documenting. Not all PLLs have
>> all of possible types of output clocks, so the presence or absence of a
>> child node indicates if a PLL actually has that output or not.
> 
> Doesn't the compatible string do that?

Sure.

> 
>> It is also complicated by the fact that one of the child nodes (sysclk)
>> is  already an array of clocks.
>>
>> To do what you are suggesting might look something like this...
>>
>> ---
>>
>> Required properties:
>> - compatible: shall be one of:
>>          - "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
>>          - "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
>> - reg: physical base address and size of the controller's register area.
>> - clocks: phandles corresponding to the clock names
>> - clock-names: names of the clock sources - depends on compatible string
>>          - for "ti,da850-pll0", shall be "clksrc", "extclksrc"
>>          - for "ti,da850-pll1", shall be "clksrc"
>> - #clock-cells: shall be set to <2>.
>>
>> Consumers:
>>
>> The clock cell values for consumers work as follows...
>>
>> The first index is one of the constants defined in ti-davinci-pll.h
>>
>> The second index is 0 unless the first index is TI_DAVINCI_SYSCLK. In the
>> case
>> of TI_DAVINCI_SYSCLK the second index the SYSCLK domain ID (n in SYSCLKn).
>>
>> For compatible = "ti,da850-pll0":
>>          - <&pll0 TI_DAVINCI_PLLOUT 0> is the PLLOUT clock
>>          - <&pll0 TI_DAVINCI_SYSCLK n> is one of the SYSCLKn clock domains
>> where n is 1 to 7
>>          - <&pll0 TI_DAVINCI_AUXCLK 0> is the AUXCLK clock domain
>>          - <&pll0 TI_DAVINCI_OBSCLK 0> is the OBSCLK clock domain
>>          - all other index combinations are invalid
>>
>> For compatible = "ti,da850-pll1":
>>          - <&pll0 TI_DAVINCI_SYSCLK n> is one of the SYSCLKn clock domains
>> where n is 1 to 3
>>          - <&pll0 TI_DAVINCI_OBSCLK 0> is the OBSCLK clock domain
>>          - all other index combinations are invalid
> 
> You don't really need 2 cells here. I guess if you want to keep the
> child nodes, that is fine.

OK, I can see how it could work with one cell.

Since this is already implemented and working, I'm inclined to leave it
as-is if it is "good enough". But, I am fine going either way if there
are other opinions on the matter.

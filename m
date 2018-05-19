Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeESPuX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:50:23 -0400
Received: from vern.gendns.com ([206.190.152.46]:43692 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbeESPuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:50:21 -0400
Subject: Re: [PATCH 2/3] dt-bindings: new binding for Ilitek ILI9341 display
 panels
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        limor@ladyada.net, Nitin Patil <nitin@mindsensors.com>,
        linux-kernel@vger.kernel.org
References: <20180515014349.26226-1-david@lechnology.com>
 <20180515014349.26226-3-david@lechnology.com>
 <50928486-822a-aff3-7c37-cc1c40cb62b8@tronnes.org>
From: David Lechner <david@lechnology.com>
Message-ID: <b86e0eac-35bb-e143-ad44-8a091af798a5@lechnology.com>
Date: Sat, 19 May 2018 10:50:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <50928486-822a-aff3-7c37-cc1c40cb62b8@tronnes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 05/19/2018 08:37 AM, Noralf Trønnes wrote:
> 
> Den 15.05.2018 03.43, skrev David Lechner:
>> This adds a new binding for Ilitek ILI9341 display panels. It includes
>> a compatible string for one display (more can be added in the future).
>>
>> The vendor prefix "noname" is used because the vendor is not known.
>> The YX240QV29-T panel[1] is found, for example, in an Adafruit breakout
>> board[2] and in Mindsensors' PiStorms[3].
>>
>> [1]: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
>> [2]: https://www.adafruit.com/product/2478
>> [3]: http://www.mindsensors.com/stem-with-robotics/13-pistorms-v2-base-kit-raspberry-pi-brain-for-lego-robot
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   .../bindings/display/ilitek,ili9341.txt       | 27 +++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>> new file mode 100644
>> index 000000000000..0fc90b2dd732
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
>> @@ -0,0 +1,27 @@
>> +Ilitek ILI9341 display panels
>> +
>> +This binding is for display panels using an Ilitek ILI9341 controller in SPI
>> +mode.
>> +
>> +Required properties:
>> +- compatible:    "noname,yx240qv29", "ilitek,ili9341"
> 
> Calling a vendor 'noname' looks a bit odd and AFAICT it isn't used by
> any other binding. A google search always mentions Adafruit in
> connection with this panel, so I suggest we use Adafruit as vendor.

I was hoping that someone might know the correct vendor, but barring that,
I agree that adafruit is probably the best choice.

> 
> I don't think we should use "ilitek,ili9341" as an option/fallback,
> because panels varies in resolution (rarely) and initialization. A
> generic ili9341 driver would probably not work with a random new panel.

I'm just following the precedent set in the other bindings for similar
displays that I have already done.

References:
* https://patchwork.freedesktop.org/patch/194648/
* https://patchwork.freedesktop.org/patch/195320/

I agree that it is probably not super-useful as a fallback. On the other
hand, the vendors and models for these displays are pretty obscure and
I think having the more well-known controller name _somewhere_ is useful.


> 
>> +- dc-gpios:    D/C pin
>> +- reset-gpios:    Reset pin
>> +
>> +The node for this driver must be a child node of a SPI controller, hence
>> +all mandatory properties described in ../spi/spi-bus.txt must be specified.
>> +
>> +Optional properties:
>> +- rotation:    panel rotation in degrees counter clockwise (0,90,180,270)
>> +- backlight:    phandle of the backlight device attached to the panel
> 
> You forgot to mention the regulator that you support in the driver.
> 
> Noralf.
> 
>> +
>> +Example:
>> +    display@0{
>> +        compatible = "noname,yx240qv29", "ilitek,ili9341";
>> +        reg = <0>;
>> +        spi-max-frequency = <32000000>;
>> +        dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>> +        reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
>> +        rotation = <270>;
>> +        backlight = <&backlight>;
>> +    };
> 

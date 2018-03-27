Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeC0P4i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:56:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40880 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeC0P4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:56:33 -0400
X-Google-Smtp-Source: AIpwx4/zRZdnWhr0mAlCO9hlr8FR2kHRtVihqjhGqiynQf8R8I9Xf4n1fMh9k815lDYviv9PEDVFAw==
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
 <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
 <20180326225106.GC1403@tuxbook-pro>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <2e0db4b4-80cc-9a5b-9e0a-812f1bc9fbcf@linaro.org>
Date: Tue, 27 Mar 2018 17:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326225106.GC1403@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 27/03/2018 00:51, Bjorn Andersson wrote:
> On Tue 20 Mar 23:58 HKT 2018, Marcel Holtmann wrote:
>>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> [..]
>>> + - clocks: clock phandle for SUSCLK_32KHZ
>>
>> if I compare this with broadcom-bluetooth.txt or ti-bluetooth.txt then
>> besides compatible, everything else is optional. The
>> nokia-bluetooth.txt has everything required, but that is also a really
>> specific platform.
>>
>> Can we be less restrictive for a QCA general purpose chip?
>>
> 
> The way we deal with this in other bindings is that we tie such
> requirements to the compatible; i.e. we would say that qcom,qca6174-bt
> requires a clock and we would have something like qcom,qca-bt that makes
> it optional.
> 
> The beauty of this is that the driver will tell you if you forgot to
> specify the clock when it actually is required, which saves you
> considerable amount of debugging time.
> 
> 
> NB. The way the bcm driver handles this is insufficient, as it treats
> any error from clk_get as "there's no clock specified". The driver
> should accept a clock not being specified, but should fail properly when
> a clock is specified but can't be acquired (e.g. due to clk_get()
> returning EPROBE_DEFER).
> 
>>> +
>>> +Example:
>>> +
>>> +serial@7570000 {
>>> +	pinctrl-names = "default", "sleep";
>>> +	pinctrl-0 = <&blsp1_uart1_default>;
>>> +	pinctrl-1 = <&blsp1_uart1_sleep>;
>>> +
>>> +	bluetooth {
>>> +		compatible = "qcom,qca6174-bt";
>>> +
>>> +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&bt_en_pin_a>;
>>
>> This one I do not understand and you might want to shed some light
>> into why this is done that way.
>>
> 
> This is completely generic and only relates to getting the electrical
> properties of the gpio pin set up correctly. So I would recommend that
> we omit this from the binding and example (including the pinctrl
> properties for the serial above).

If I remove the pinctrl entry in the bluetooth node, the gpio19 is then 
marked as unclaimed. The drive strength also defaults to low but that 
doesn't seem to be an issue and the the chip can still be enabled 
through gpio19. Is it ok to have it unclaimed? If so I can remove it 
from the binding and the doc then.

Regarding the blsp1_uart1_default of the serial node, I can still enable 
the chip if I remove it but the hci commands all end in timeout. It 
seems that the function for these pins has to be explicitly set to 
blsp_uart2. So at least, the default pinctrl seems mandatory.

Regards,
Thierry

> 
> Regards,
> Bjorn
> 

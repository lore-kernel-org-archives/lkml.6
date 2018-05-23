Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeEWCCt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 22:02:49 -0400
Received: from regular1.263xmail.com ([211.150.99.130]:38904 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbeEWCCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 22:02:47 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 59.33.100.150
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <44bf2a732710535411c1926523a7acd8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, Wayne Chou <zxf@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-2-git-send-email-djw@t-chip.com.cn>
 <20180522180238.GA7328@rob-hp-laptop>
From: Levin Du <djw@t-chip.com.cn>
Message-ID: <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
Date: Wed, 23 May 2018 10:02:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522180238.GA7328@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 2:02 AM, Rob Herring wrote:
> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>>
>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
>> which do not belong to the general pinctrl.
>>
>> Adding gpio-syscon support makes controlling regulator or
>> LED using these special pins very easy by reusing existing
>> drivers, such as gpio-regulator and led-gpio.
>>
>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>
>> ---
>>
>> Changes in v2:
>> - Rename gpio_syscon10 to gpio_mute in doc
>>
>> Changes in v1:
>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>> - Add doc rockchip,gpio-syscon.txt
>>
>>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
>>   drivers/gpio/gpio-syscon.c                         | 30 ++++++++++++++++
>>   2 files changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> new file mode 100644
>> index 0000000..b1b2a67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> @@ -0,0 +1,41 @@
>> +* Rockchip GPIO support for GRF_SOC_CON registers
>> +
>> +Required properties:
>> +- compatible: Should contain "rockchip,gpio-syscon".
>> +- gpio-controller: Marks the device node as a gpio controller.
>> +- #gpio-cells: Should be two. The first cell is the pin number and
>> +  the second cell is used to specify the gpio polarity:
>> +    0 = Active high,
>> +    1 = Active low.
> There's no need for this child node. Just make the parent node a gpio
> controller.
>
> Rob
Hi Rob, it is not clear to me. Do you suggest that the grf node should 
be a gpio controller,
like below?

+    grf: syscon at ff100000 {
+        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf", 
"syscon", "simple-mfd";
+        //...
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio,syscon-dev = <&grf 0x0428 0>;
+    };

or just reserve the following case in the doc?

+    grf: syscon at ff100000 {
+        compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+        //...
+    };
+
+    gpio_mute: gpio-mute {
+        compatible = "rockchip,gpio-syscon";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio,syscon-dev = <&grf 0x0428 0>;
+    };


Thanks
Levin

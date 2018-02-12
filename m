Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeBLQqI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:46:08 -0500
Received: from regular1.263xmail.com ([211.150.99.141]:50174 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeBLQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:46:06 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: wulf@rock-chips.com
X-FST-TO: enric.balletbo@collabora.com
X-SENDER-IP: 111.146.46.117
X-LOGIN-NAME: wulf@rock-chips.com
X-UNIQUE-TAG: <821ab30e108070f0e3d62d3709739de8>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/3] dt-bindings: phy: phy-rockchip-typec: add usb3 otg
 reset
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Brian Norris <briannorris@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        William Wu <william.wu@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Frank Wang <frank.wang@rock-chips.com>, huangtao@rock-chips.com,
        Doug Anderson <dianders@google.com>, Guenter Roeck <groeck@google.com>,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        lin.huang@rock-chips.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com>
 <20180119214916.fegrzgcmbbdiesyz@rob-hp-laptop>
 <d05fb977-cd6c-4875-25be-9212e75b7e39@rock-chips.com>
 <1907466.pgqOKPpIkg@phil>
From: wlf <wulf@rock-chips.com>
Message-ID: <7996ee24-1376-a7ec-91dc-26798c9159c7@rock-chips.com>
Date: Tue, 13 Feb 2018 00:40:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1907466.pgqOKPpIkg@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Heiko,

在 2018年02月11日 03:55, Heiko Stuebner 写道:
> Hi Wulf,
>
> Am Montag, 22. Januar 2018, 12:33:05 CET schrieb wlf:
>> 在 2018年01月20日 05:49, Rob Herring 写道:
>>> On Thu, Jan 18, 2018 at 09:47:50AM -0800, Brian Norris wrote:
>>>> On Thu, Jan 18, 2018 at 06:20:09PM +0100, Enric Balletbo Serra wrote:
>>>>> As Brian said commit 06c47e6286d5 'usb: dwc3: of-simple: Add support
>>>>> to get resets for the device' introduced the support to get the resets
>>>>> from dwc3-of-simple and the queued commit 'b7e63d95c14d arm64: dts:
>>>>> rockchip: add reset property for dwc3 controllers on rk3399' started
>>>>> using it. Without the latest I get errors like this doing bind/unbind
>>>>> tests.
>>>>>
>>>>>      dwc3: probe of fe900000.dwc3 failed with error -110
>>>>>
>>>>> I just tested these series on top of mainline, I reverted my patch
>>>>> because otherwise two drivers are requesting the same reset and fails,
>>>>> and I did some of the bind/unbind test. They just worked fine, and
>>>>> seems that this is right way, so this makes me think some questions.
>>>> Actually, this was intended to coexist with DWC3 optionally controlling
>>>> the same reset. It was written before the reset framework was rewritten
>>>> to have shared and exclusive resets. Should this be rewritten to use
>>>> shared resets? We'd have to modify both dwc3 core and the PHY driver.
>>> Seems like abuse of DT to me. If you need to control the controller's
>>> reset from the phy driver, then get the reset out of the controller
>>> node. The phy node should describe the connections to the phy.
>> I try to get the reset out of the controller, but I don't find a good
>> way to get the reset ofthe controller associated with the given phy
>> device node.  Is there an API like theof_usb_get_dr_mode_by_phy() to
>> get 'dr_mode' of the controller?
> I guess the easiest way would be taking the of_usb_get_dr_mode_by_phy()
> function move the part above the "finish" label into a separate function
> like of_usb_get_node_by_phy (or possibly move that to an even more general
> place as it is not usb-related at all) and use that function in
> of_usb_get_dr_mode_by_phy() and also use it to get the reset you want via
> something like:
>
> node = of_usb_get_node_by_phy(...);
> rst = of_reset_control_get(node, ...);
Thanks for your good suggestion. I think it's a good way to get the 
reset of the
controller by phy.
>> And we're trying to find another method to fix the RK3399 tcphy power
>> on fail issue.If we get another proper method, we may not need these
>> phy patch series.
> Did you find any different solution for that yet?
>
> Heiko
Yes, finally, we have found another way to fix the  RK3399 tcphy usb power
on fail issue. And Enric Balletbo i Serra <Enric Balletbo i Serra> has 
submitted
new patch series, refer to the following patches:
https://patchwork.kernel.org/patch/10207261/
https://patchwork.kernel.org/patch/10207267/
https://patchwork.kernel.org/patch/10207263/

So my patches can be abandoned.
>

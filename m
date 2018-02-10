Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBJTz6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 14:55:58 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52822 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeBJTz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 14:55:56 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: wlf <wulf@rock-chips.com>
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
Subject: Re: [PATCH 1/3] dt-bindings: phy: phy-rockchip-typec: add usb3 otg reset
Date: Sat, 10 Feb 2018 20:55:45 +0100
Message-ID: <1907466.pgqOKPpIkg@phil>
In-Reply-To: <d05fb977-cd6c-4875-25be-9212e75b7e39@rock-chips.com>
References: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com> <20180119214916.fegrzgcmbbdiesyz@rob-hp-laptop> <d05fb977-cd6c-4875-25be-9212e75b7e39@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wulf,

Am Montag, 22. Januar 2018, 12:33:05 CET schrieb wlf:
> 在 2018年01月20日 05:49, Rob Herring 写道:
> > On Thu, Jan 18, 2018 at 09:47:50AM -0800, Brian Norris wrote:
> >> On Thu, Jan 18, 2018 at 06:20:09PM +0100, Enric Balletbo Serra wrote:
> >>> As Brian said commit 06c47e6286d5 'usb: dwc3: of-simple: Add support
> >>> to get resets for the device' introduced the support to get the resets
> >>> from dwc3-of-simple and the queued commit 'b7e63d95c14d arm64: dts:
> >>> rockchip: add reset property for dwc3 controllers on rk3399' started
> >>> using it. Without the latest I get errors like this doing bind/unbind
> >>> tests.
> >>>
> >>>     dwc3: probe of fe900000.dwc3 failed with error -110
> >>>
> >>> I just tested these series on top of mainline, I reverted my patch
> >>> because otherwise two drivers are requesting the same reset and fails,
> >>> and I did some of the bind/unbind test. They just worked fine, and
> >>> seems that this is right way, so this makes me think some questions.
> >> Actually, this was intended to coexist with DWC3 optionally controlling
> >> the same reset. It was written before the reset framework was rewritten
> >> to have shared and exclusive resets. Should this be rewritten to use
> >> shared resets? We'd have to modify both dwc3 core and the PHY driver.
> > Seems like abuse of DT to me. If you need to control the controller's
> > reset from the phy driver, then get the reset out of the controller
> > node. The phy node should describe the connections to the phy.
> I try to get the reset out of the controller, but I don't find a good
> way to get the reset ofthe controller associated with the given phy
> device node.  Is there an API like theof_usb_get_dr_mode_by_phy() to
> get 'dr_mode' of the controller?

I guess the easiest way would be taking the of_usb_get_dr_mode_by_phy()
function move the part above the "finish" label into a separate function
like of_usb_get_node_by_phy (or possibly move that to an even more general
place as it is not usb-related at all) and use that function in
of_usb_get_dr_mode_by_phy() and also use it to get the reset you want via
something like:

node = of_usb_get_node_by_phy(...);
rst = of_reset_control_get(node, ...);

> And we're trying to find another method to fix the RK3399 tcphy power
> on fail issue.If we get another proper method, we may not need these
> phy patch series.

Did you find any different solution for that yet?

Heiko

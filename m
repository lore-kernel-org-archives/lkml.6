Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D61C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91EF24075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91EF24075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeGECwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:52:40 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:40761 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGECwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:52:38 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 5 Jul 2018
 10:51:49 +0800
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <886462fa-1833-a99a-a2fa-5b7dd58341fd@amlogic.com>
Date:   Thu, 5 Jul 2018 10:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Neil

On 07/04/18 22:57, Neil Armstrong wrote:
> Hi Yixun,
> 
> On 05/07/2018 00:45, Yixun Lan wrote:
>> This patch series try to add pinctrl driver support for
>> the Meson-G12A SoC.
> 
> Thanks for submitting these patches.
> 
> Can you explicit this patchset with more details on the G12A SoC family ?
> It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?
> 
I thought this was already discussed while we doing pinctrl driver for
Meson-AXG SoC.

Anyway, here it is:

Starting from Meson-AXG SoC, the pinctrl controller block using 4
continues bit to specific pin mux function, while comparing to old
generation SoC which kind of using various length bits for the pin mux
definition. The new design would greatly simplify the software model..

for detail example, one 32bit register can describe 8 pins, and each of
them has 0-7 value to set, start from value 0 to 7.

partition the register into 8 parts:
bit[3:0]
bit[7:4]
bit[11:8]
bit[15:12]
bit[19:16]
bit[23:20]
bit[27:24]
bit[31:28]


for each value:
value == 0, means the pin is GPIO
value = {1, 2, ... 7 } is one of specific PIN function

I could put this info into cover-letter or commit message?

> Why is there a GPIOE bank within the AO controller ?
> 

It actually sit in the AO domain, although it's sounds strange from the
naming..

I'm not sure if it's good idea to append a AO suffix? since the
documentation just use the plain GPIOE

> Thanks,
> Neil
> 
>>
>> Yixun Lan (3):
>>   documentation: Add compatibles for Amlogic Meson G12A pin controllers
>>   dt-bindings: pinctrl: meson-g12a: document pin name
>>   pinctrl: meson-g12a: add pinctrl driver support
>>
>>  .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
>>  drivers/pinctrl/meson/Kconfig                 |    6 +
>>  drivers/pinctrl/meson/Makefile                |    1 +
>>  drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1432 +++++++++++++++++
>>  include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
>>  5 files changed, 1555 insertions(+)
>>  create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
>>  create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
>>
> 
> .
> 


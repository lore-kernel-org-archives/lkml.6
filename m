Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98E2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD97420693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD97420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeFTJxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:53:35 -0400
Received: from foss.arm.com ([217.140.101.70]:34764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752595AbeFTJxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:53:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D5980D;
        Wed, 20 Jun 2018 02:53:32 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DB73F589;
        Wed, 20 Jun 2018 02:53:27 -0700 (PDT)
Subject: Re: [PATCH 00/20] coresight: Update device tree bindings
To:     linux-arm-kernel@lists.infradead.org, xuwei5@hisilicon.com,
        lipengcheng8@huawei.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>,
        Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     mathieu.poirier@linaro.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <7b03e604-3792-7846-56dc-d3feae5410d8@arm.com>
Date:   Wed, 20 Jun 2018 10:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/18 22:43, Suzuki K Poulose wrote:
> Coresight uses DT graph bindings to describe the connections of the
> components. However we have some undocumented usage of the bindings
> to describe some of the properties of the connections.
> 
> The coresight driver needs to know the hardware ports invovled
> in the connection and the direction of data flow to effectively
> manage the trace sessions. So far we have relied on the "port"
> address (as described by the generic graph bindings) to represent
> the hardware port of the component for a connection.
> 

...

> There were three options considered for the hardware port number scheme:
> 


...

>   3) Use explicit properties (implemented in the series) for the hardware
>      port id and direction. We define a new property "coresight,hwid" for
>      each endpoint in coresight devices to specify the hardware port number
>      explicitly. Also use a separate property "direction" to specify the
>      direction of the data flow.
> 
> 	e.g,
> 
> 	port@0{
> 		reg = <0>;
> 		endpoint {
> 			direction = <1>;	// Output
> 			coresight,hwid = <0>;	// Port # 0
> 		}
> 	};
> 
> 	port@1{
> 		reg = <1>;
> 		endpoint {
> 			direction = <0>;	// Input
> 			coresight,hwid = <0>;	// Port # 0
> 		};
> 	};
> 
>      Pros:
>         - The bindings are formal and reader friendly, and less prone to errors.
>      Cons:
>         - Backward compatibility is lost.
> 
> 
> This series implements Option (3) listed above and falls back to the old
> bindings if the new bindings are not available. This allows the systems
> with old bindings work with the new driver. The driver now issues a warning
> (once) when it encounters the old bindings.

  ....

>    dts: juno: Update coresight bindings for hw port
>    dts: hisilicon: Update coresight bindings for hw ports
>    dts: spreadtrum: Update coresight bindings for hw ports
>    dts: qcom: Update coresight bindings for hw ports
>    dts: arm: hisilicon: Update coresight bindings for hardware port
>    dts: arm: imx7{d,s}: Update coresight binding for hardware ports
>    dts: arm: omap: Update coresight bindings for hardware ports
>    dts: arm: qcom: Update coresight bindings for hardware ports
>    dts: sama5d2: Update coresight bindings for hardware ports
>    dts: ste-dbx5x0: Update coresight bindings for hardware port
>    dts: tc2: Update coresight bindings for hardware ports
> 

All,

Pleas hold on with applying the DTS changes listed above. There are
still some on going discussions on the bindings and we are yet to
come to a conclusion [0]. And there are high chances that these might
change. Sorry for the inconvenience.

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582269.html

Kind regards
Suzuki

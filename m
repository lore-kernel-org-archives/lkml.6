Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF33FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E21820862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E21820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeKESiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:38:10 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9400 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:38:06 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="19933660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 02:19:20 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Mon, 5 Nov 2018
 02:19:19 -0700
Date:   Mon, 5 Nov 2018 10:19:22 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Jean-Michel Hautbois <jhautbois@gmail.com>
CC:     <boris.brezillon@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: sama5d: using the ebi interface from another driver
Message-ID: <20181105091922.gws52ledkqwc46xx@M43218.corp.atmel.com>
Mail-Followup-To: Jean-Michel Hautbois <jhautbois@gmail.com>,
        boris.brezillon@bootlin.com,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

On Fri, Nov 02, 2018 at 02:35:26PM +0100, Jean-Michel Hautbois wrote:
> Hi all,
> 
> I have a custom board based on a sama5d3 chip. The SoC is connected to
> 2 pef24628 SHDSL transceivers, the first one on ebi@40000000 and the
> second one on ebi@50000000.
> I tried to write a basic char driver, using request_mem_region and
> ioremap but I can't read or write into the device.
> I have to say that the driver is based on a proprietary one, and
> tested years ago on a PowerPC board.
> 
> Then, after looking into deeper details in the datasheet I understand
> it is connected through EBI and it sounds not so easy :D.
> 
> I would appreciate some help/pointers on this, as there is (at least,
> I could find) few documentation on how to use it except for NAND
> cases.
> 
> I have something like that in my DTS, but not sure this is the correct
> way to do it :
> 
>         ebi: ebi@10000000 {
>             pinctrl-0 = <&pinctrl_ebi_nand_addr>;
>             pinctrl-names = "default";
>             status = "okay";
> 
>             dsp0: pef24628@1 {
>                 status = "okay";
>                 compatible = "intel,pef24628";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 reg = <0x1 0x0 0x8000>;
>                 pinctrl-0 = <&pinctrl_dsp_cs1>;
>             };
> 
>             dsp1: pef24628@2 {
>                 status = "okay";
>                 compatible = "intel,pef24628";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 reg = <0x2 0x0 0x8000>;
>                 pinctrl-0 = <&pinctrl_dsp_cs2>;
>             };
> 
>             nand_controller: nand-controller {
>                 status = "okay";
> 
>                 nand@3 {
>                     reg = <0x3 0x0 0x2>;
>                     atmel,rb = <0>;
>                     nand-bus-width = <8>;
>                     nand-ecc-mode = "hw";
>                     nand-ecc-strength = <4>;
>                     nand-ecc-step-size = <512>;
>                     nand-on-flash-bbt;
>                     label = "atmel_nand";
> 
>                     partitions {
>                         compatible = "fixed-partitions";
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> [...]
>                     };
>                 };
>             };
> 
> The pinctrl for ebi should probably be changed however, I am wondering
> how the (platform ?) driver can access the adress ? Should it parse
> itself the parent, and find range, etc. Or is there an accessor for it
> ?

At first look, your DT seems correct. You have nothing special to do,
the usual platform_get_resource() and devm_ioremap_resource() calls are enough.
The address translation should be done automatically according to ranges
property.

Another hint is to check and specify the signals timings.

Regards

Ludovic

> 
> Maybe can I just manually toggle the CS GPIO, and don't try to make
> anything more complex than what it should be ? The driver should not
> be atmel dependant...
> 
> Thanks !
> JM
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

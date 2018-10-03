Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7510720684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7510720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDDtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:49:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeJDDtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:49:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F1226207F3; Wed,  3 Oct 2018 22:59:30 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A71F22072B;
        Wed,  3 Oct 2018 22:59:20 +0200 (CEST)
Date:   Wed, 3 Oct 2018 22:59:21 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 7/8] dt-binding: mtd: Document gpio-addr-flash
Message-ID: <20181003225921.40ab58a7@bbrezillon>
In-Reply-To: <20181003193859.23928-7-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
        <20181003193859.23928-7-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Oct 2018 21:38:58 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> Add documentation for gpio-addr-flash. This binding allow creating
> flash devices that are paged using GPIOs.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> new file mode 100644
> index 000000000000..5006a26e1753
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> @@ -0,0 +1,54 @@
> +Memory Mapped flash with some address lines addressed using GPIOs
> +
> +Handle the case where a flash device is mostly addressed using physical
> +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> +to a 2MiB memory range and use the GPIOs to select a particular range.
> +
> + - compatible : "cfi-gpio-addr-flash"
> + - reg : Address range of the mtd chip that is memory mapped, this is,
> +   on the previous example 2MiB.
> + - bank-width : Width (in bytes) of the bank.  Equal to the
> +   device width times the number of interleaved chips.
> + - gpios: List of GPIO specifiers that will be used to address the MSBs address
> +   lines. The order goes from LSB to MSB.

I'd recommend naming the GPIO set (addr-gpios or msb-addr-gpios?), just
to make things clear.

> + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
> + - #address-cells, #size-cells : Must be present if the device has
> +   sub-nodes representing partitions (see below).  In this case
> +   both #address-cells and #size-cells must be equal to 1.
> +
> +The device tree may optionally contain sub-nodes describing partitions of the
> +address space. Check partition.txt for more details.
> +
> +Example:
> +
> +	flash@300000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "cfi-gpio-addr-flash";
> +		bank-width = <2>;
> +		reg = < 0x00300000 0x00200000 >;
> +		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				reg = < 0x0 0x200000 >;
> +				label = "Golden Bitstream";
> +			};
> +			partition@200000 {
> +				reg = < 0x200000 0x200000 >;
> +				label = "User Bitstream";
> +			};
> +			partition@400000 {
> +				reg = < 0x400000 0x200000 >;
> +				label = "V4L Controls";
> +			};
> +			partition@600000 {
> +				reg = < 0x600000 0x200000 >;
> +				label = "Production Data";
> +			};
> +		}
> +	} ;


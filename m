Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4152082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4152082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJDUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:55:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJDUzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:55:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B9347207F0; Thu,  4 Oct 2018 16:02:07 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7172820714;
        Thu,  4 Oct 2018 16:02:07 +0200 (CEST)
Date:   Thu, 4 Oct 2018 16:02:07 +0200
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
Subject: Re: [PATCH v6 09/10] dt-binding: mtd: Document gpio-addr-flash
Message-ID: <20181004160207.3b0403d7@bbrezillon>
In-Reply-To: <20181004130110.8496-9-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
        <20181004130110.8496-9-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Oct 2018 15:01:09 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> Add documentation for gpio-addr-flash. This binding allow creating
> flash devices that are paged using GPIOs.
> 
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  .../bindings/mtd/mtd,gpio-addr-flash.txt      | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> new file mode 100644
> index 000000000000..304a33880f9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mtd,gpio-addr-flash.txt
> @@ -0,0 +1,25 @@
> +Memory Mapped flash with some address lines addressed using GPIOs
> +
> +Handle the case where a flash device is mostly addressed using physical
> +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> +to a 2MiB memory range and use the GPIOs to select a particular range.
> +
> + - compatible :  must be "mtd,gpio-addr-flash", "cfi-flash";

I keep thinking you don't need a specific binding, just add an optional
addr-gpios property to the generic physmap binding and that should do
the trick. Plus, "*mtd*,gpio-addr-flash" is a linux-ism, and DT
bindings should be OS-agnostic.

> + - reg : Address range of the mtd chip that is memory mapped, this is,
> +   on the previous example 2MiB.
> + - addr-gpios: List of GPIO specifiers that will be used to address the MSBs
> +   address lines. The order goes from LSB to MSB.
> +
> +For the rest of the properties, see mtd-physmap.txt.
> +
> +The device tree may optionally contain sub-nodes describing partitions of the
> +address space. Check partition.txt for more details.
> +
> +Example:
> +
> +	flash@300000 {
> +		compatible = "mtd,gpio-addr-flash", "cfi-flash";
> +		bank-width = <2>;
> +		reg = < 0x00300000 0x00200000 >;
> +		addr-gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> +	} ;


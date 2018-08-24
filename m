Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE710C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78C921557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78C921557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeHXSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:43:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55397 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbeHXSnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:43:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D257F22A2A; Fri, 24 Aug 2018 17:08:50 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1AA0B20719;
        Fri, 24 Aug 2018 17:08:50 +0200 (CEST)
Date:   Fri, 24 Aug 2018 17:08:48 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
Message-ID: <20180824170848.29594318@bbrezillon>
In-Reply-To: <20180810080526.27207-2-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-2-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Fri, 10 Aug 2018 10:04:58 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> +struct nvmem_cell_lookup {
> +	struct nvmem_cell_info	info;
> +	struct list_head	list;
> +	const char		*nvmem_name;
> +};

Hm, maybe I don't get it right, but this looks suspicious. Usually the
consumer lookup table is here to attach device specific names to
external resources.

So what I'd expect here is:

struct nvmem_cell_lookup {
	/* The nvmem device name. */
	const char *nvmem_name;

	/* The nvmem cell name */
	const char *nvmem_cell_name;

	/*
	 * The local resource name. Basically what you have in the
	 * nvmem-cell-names prop.
	 */
	const char *conid;
};

struct nvmem_cell_lookup_table {
	struct list_head list;

	/* ID of the consumer device. */
	const char *devid;

	/* Array of cell lookup entries. */
	unsigned int ncells;
	const struct nvmem_cell_lookup *cells;
};

Looks like your nvmem_cell_lookup is more something used to attach cells
to an nvmem device, which is NVMEM provider's responsibility not the
consumer one.

Regards,

Boris

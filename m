Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8781720869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8781720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIESwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:52:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51284 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIESwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:52:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B9FA720763; Wed,  5 Sep 2018 16:21:36 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4192120734;
        Wed,  5 Sep 2018 16:21:36 +0200 (CEST)
Date:   Wed, 5 Sep 2018 16:21:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 11/13] nvmem: add support for cell lookups from machine
 code
Message-ID: <20180905162135.700d2145@bbrezillon>
In-Reply-To: <CAMRc=Mco7Tbk5P_mgv49f+3j9DKYk5AL6EjPhwF7M=Hb7o5-Mw@mail.gmail.com>
References: <20180905095738.26406-1-brgl@bgdev.pl>
        <20180905095738.26406-12-brgl@bgdev.pl>
        <20180905155741.22b7d0ef@bbrezillon>
        <CAMRc=Mco7Tbk5P_mgv49f+3j9DKYk5AL6EjPhwF7M=Hb7o5-Mw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 16:00:36 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-09-05 15:57 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Wed,  5 Sep 2018 11:57:36 +0200
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> >>
> >> +struct nvmem_cell_lookup {
> >> +     const char              *nvmem_name;
> >> +     const char              *dev_id;  
> >
> > Shouldn't we have a con_id here?
> >  
> >> +     const char              *cell_id;
> >> +     struct list_head        node;
> >> +};  
> 
> I wanted to stay in line with the current API - nvmem_cell_get() takes
> as argument a string called cell_id. I wanted to reflect that here.

Actually, you need both. con_id is the name you would have in your DT
in the nvmem-cell-names property, cell_id is the name of the cell
you'd find under the nvmem device node.

Let's take an example:

	mydev {
		#nvmem-cell-names = "mac-address", "revision";
		#nvmem-cells = <&cell1>, <&cell2>;
	};

	mynvmemdev {
		#size-cells = <1>;
		#address-cells = <1>;

		cell1: foo@0 {
			reg = <0x0 0x6>;
		};

		cell2: bar@6 {
			reg = <0x6 0x10>;
		};
	};

this can be described the same way using a consumer lookup table:

struct nvmem_cell_lookup_entry {
	const char *con_id;
	const char *nvmem_name;
	const char *cell_name;
};

struct nvmem_cell_lookup_table {
	struct list_head node;
	const char *dev_id;
	unsigned int nentries;
	const struct nvmem_cell_lookup_entry *entries;
}

static const struct nvmem_cell_lookup_entry mydev_nvmem_cells[] = {
	{
		.con_id = "mac-address",
		.nvmem_name = "mynvmemdev",
		.cell_name = "foo",
	},
	{
		.con_id = "revision",
		.nvmem_name = "mynvmemdev",
		.cell_name = "bar",
	},
}

static const struct nvmem_cell_lookup_table mydev_nvmem_lookup = {
	.dev_id = "mydev.0",
	.nentries = ARRAY_SIZE(mydev_nvmem_cells),
	.entries = mydev_nvmem_cells,
};


...

	nvmem_add_cell_lookups(&mydev_nvmem_lookup);

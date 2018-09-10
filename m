Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B955C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2139C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2139C206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIJM3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:29:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55043 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbeIJM3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:29:25 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 25DD12071D; Mon, 10 Sep 2018 09:36:44 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 94CF7204AE;
        Mon, 10 Sep 2018 09:36:33 +0200 (CEST)
Date:   Mon, 10 Sep 2018 09:36:32 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
        Chen-Yu Tsai <wens@csie.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 11/16] nvmem: add support for cell info
Message-ID: <20180910093632.3a9337a9@bbrezillon>
In-Reply-To: <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
        <20180907100750.14564-12-brgl@bgdev.pl>
        <21ec4e6f-aa39-66cf-af32-d9e8e85f4961@linaro.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, 10 Sep 2018 08:32:21 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 07/09/18 11:07, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Add new structs and routines allowing users to define nvmem cells from
> > machine code. This global list of entries is parsed when a provider
> > is registered and cells are associated with the relevant nvmem_device
> > struct.
> > 
> > A possible improvement for the future is to allow users to register
> > cell tables after the nvmem provider has been registered by updating
> > the cell list at each call to nvmem_(add|del)_cell_table().
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   MAINTAINERS                   |  1 +
> >   drivers/nvmem/core.c          | 97 ++++++++++++++++++++++++++++++++++-  
> 
> I see some of this code is removed in first patch and added back here, I 
> dont really see a value in doing this in a single series of patchset.
> 
> I would recommend "[PATCH v2 01/16] nvmem: remove unused APIs" and this 
> patch to be merged.
> 
> >   include/linux/nvmem-machine.h | 41 +++++++++++++++
> >   3 files changed, 138 insertions(+), 1 deletion(-)
> >   create mode 100644 include/linux/nvmem-machine.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ad052aeac39..a520924bf0a9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10391,6 +10391,7 @@ F:	drivers/nvmem/
> >   F:	Documentation/devicetree/bindings/nvmem/
> >   F:	Documentation/ABI/stable/sysfs-bus-nvmem
> >   F:	include/linux/nvmem-consumer.h
> > +F:	include/linux/nvmem-machine.h
> >   F:	include/linux/nvmem-provider.h
> >   
> >   NXP SGTL5000 DRIVER
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 17307015905a..854baa0559a1 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c  
> ...
> >    *
> > diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h
> > new file mode 100644
> > index 000000000000..1e199dfaacab
> > --- /dev/null
> > +++ b/include/linux/nvmem-machine.h  
> 
> This should go in nvmem-consumer.h, I don't think we should add header 
> files for each usecase. These are nvmem consumers so lets put them in 
> correct header file.

Actually no, it should go in nvmem-provider.h. Consumer should not be
allowed to define cells, only reference existing ones.

Regards,

Boris

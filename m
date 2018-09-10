Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496BAC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92D3206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92D3206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeIJNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:16:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56232 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeIJNQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:16:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D69AE2079D; Mon, 10 Sep 2018 10:23:35 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5B5BE20701;
        Mon, 10 Sep 2018 10:23:25 +0200 (CEST)
Date:   Mon, 10 Sep 2018 10:23:24 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from
 machine code
Message-ID: <20180910102324.52ecd8f7@bbrezillon>
In-Reply-To: <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
        <20180907100750.14564-14-brgl@bgdev.pl>
        <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
        <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 10:17:48 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-09-10 9:32 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
> >
> >
> > On 07/09/18 11:07, Bartosz Golaszewski wrote:  
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> Add a way for machine code users to associate devices with nvmem cells.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> ---
> >>   drivers/nvmem/core.c          | 143 +++++++++++++++++++++++++++-------
> >>   include/linux/nvmem-machine.h |  16 ++++
> >>   2 files changed, 132 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >> index da7a9d5beb33..9e2f9c993a07 100644
> >> --- a/drivers/nvmem/core.c
> >> +++ b/drivers/nvmem/core.c
> >> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
> >>   static DEFINE_MUTEX(nvmem_cell_mutex);
> >>   static LIST_HEAD(nvmem_cell_tables);
> >>   +static DEFINE_MUTEX(nvmem_lookup_mutex);
> >> +static LIST_HEAD(nvmem_lookup_list);
> >> +
> >>   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
> >>     #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >> @@ -285,6 +288,18 @@ static struct nvmem_device *of_nvmem_find(struct
> >> device_node *nvmem_np)
> >>         return to_nvmem_device(d);
> >>   }
> >>   +static struct nvmem_device *nvmem_find(const char *name)
> >> +{
> >> +       struct device *d;
> >> +
> >> +       d = bus_find_device_by_name(&nvmem_bus_type, NULL, name);
> >> +
> >> +       if (!d)
> >> +               return NULL;
> >> +
> >> +       return to_nvmem_device(d);
> >> +}
> >> +  
> >
> > This is removed and added back in same patch, you should consider
> > positioning the caller if possible to avoid any un-necessary changes.
> >  
> >>   static void nvmem_cell_drop(struct nvmem_cell *cell)
> >>   {
> >>         mutex_lock(&nvmem_mutex);
> >> @@ -421,6 +436,21 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem,
> >> int index)
> >>         return cell;
> >>   }
> >>   +static struct nvmem_cell *
> >> +nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
> >> +{
> >> +       struct nvmem_cell *cell = ERR_PTR(-ENOENT);
> >> +       struct nvmem_cell_lookup *lookup;
> >> +       struct nvmem_device *nvmem;
> >> +       const char *dev_id;
> >> +
> >> +       if (!dev)
> >> +               return ERR_PTR(-EINVAL);
> >> +
> >> +       dev_id = dev_name(dev);
> >> +
> >> +       mutex_lock(&nvmem_lookup_mutex);
> >> +
> >> +       list_for_each_entry(lookup, &nvmem_lookup_list, node) {
> >> +               if ((strcmp(lookup->dev_id, dev_id) == 0) &&
> >> +                   (strcmp(lookup->con_id, con_id) == 0)) {
> >> +                       /* This is the right entry. */
> >> +                       nvmem = __nvmem_device_get(NULL,
> >> lookup->nvmem_name);
> >> +                       if (!nvmem) {
> >> +                               /* Provider may not be registered yet. */
> >> +                               cell = ERR_PTR(-EPROBE_DEFER);
> >> +                               goto out;
> >> +                       }
> >> +
> >> +                       cell = nvmem_find_cell_by_name(nvmem,
> >> +                                                      lookup->cell_name);
> >> +                       if (!cell)
> >> +                               goto out;  
> >
> > Here nvmem refcount has already increased, you should probably fix this!  
> 
> Indeed.
> 
> >>
> >> +               }
> >> +       }
> >> +
> >> +out:
> >> +       mutex_unlock(&nvmem_lookup_mutex);
> >> +       return cell;
> >> +}  
> >
> >
> > ...
> >  
> >> diff --git a/include/linux/nvmem-machine.h b/include/linux/nvmem-machine.h  
> >
> >
> > Should be part of nvmem-consumer.h.
> >  
> 
> If anything, this should probably go to nvmem-provider.h.

Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
everything that is related to cell creation should be placed in
nvmem-provider.h.

> But I like
> the gpiolib way of putting machine-specific code into a separate
> header. Most systems are not interested in these definitions anyway.
> IMO this is a valid use case where creating a new header makes sense.

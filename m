Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543EBECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092032156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0qrdC+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092032156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbeIVFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:22:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43012 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIVFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:22:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id 38-v6so6587941plc.10;
        Fri, 21 Sep 2018 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4L1LM3ex8sBhHCNCfzn6ZACWUZDLRkMQii9Hl6m2fw=;
        b=L0qrdC+SQW97EGjRiMSJy+kGzLaIG7hv/oghvIV0QGfQjFOioJ65932PUV1Wv7mT2b
         2WFblsWzBqzhETcjsEy7sAfWlKJ4w4IzUBKda4WZ+Py/C6VkDoVqpQgwonMshVeSFaT9
         5yp0IDm2LkNvJGwPadXB3g8OJBqgsHpMPefUeygk7ZKZXyzZA7CqPRKDkWi+Uxm6IWEI
         sLiCs3HV1AT+62lgK09TkLQ5vJySt9Dx7rXQHjzrtOub39uIHMZ0gXX4fPPuO1ZI8V9r
         C40eb5H3cTGshbJaHTpdb5RFWJjpa9gUPAogrRqHlrAH8QlYKj47HtadbZUmhWHtPtLA
         4B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4L1LM3ex8sBhHCNCfzn6ZACWUZDLRkMQii9Hl6m2fw=;
        b=ClSaiPn+yS3J1QnLI9nVWH+BtIYRpwd8AVOvTZymSIOKqs7wisPNgQX2zEkydIDN3a
         e5AWToXZntwpfbvhWlcwv6Afu8hLa+muSaIQTHDGQs2FzPk1rP8jlo+GCEgre107HjeJ
         BvoQDINzG7nAg2OgrHiIDypXcYcVYhzmzcb/XLqLopJKputG++EZH8JpcqZO226wnmgJ
         GUM/oHYnPVMoo1MFX0kHYNgFkpONxsL9wh1TeG4cwlXI/6jnInshhcKGWlbJbwqTfqXM
         uIYfKaqVIu3lqEqfzvPaFdj2/K9uU7ern8OJsxCCGTA/iOvwKd0E0XbQr0CDLAiUIn+K
         bD3Q==
X-Gm-Message-State: ABuFfogVFM4uzjfvGfpnujhatt6DOfO27DkWe/Wd1g3MothIZ3eXeFCO
        y3M2XZ9V23zzPokTgGieW6y1f2AF
X-Google-Smtp-Source: ACcGV60S+PBztWJB2bNyJS6vmEaMR3iWjs3NEu+E5RJk84l+yCJEdzZByIhjXW7x9ds4Kwi+dB3vFQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr10266plp.18.1537572682458;
        Fri, 21 Sep 2018 16:31:22 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u9-v6sm39054366pfi.104.2018.09.21.16.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:31:21 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:31:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180921233119.GA44099@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920135348.GF11965@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Thu, Sep 20, 2018 at 04:53:48PM +0300, Heikki Krogerus wrote:
> Hi Dmitry,
> 
> On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> > +/**
> > + * device_add_child_properties - Add a collection of properties to a device object.
> > + * @dev: Device to add properties to.
> 
> In case you didn't notice my comment for this, you are missing @parent
> here.
> 
> But why do you need both the parent and the dev?

I could go by parent only and fetch dev from parent.

> 
> > + * @properties: Collection of properties to add.
> > + *
> > + * Associate a collection of device properties represented by @properties as a
> > + * child of given @parent firmware node.  The function takes a copy of
> > + * @properties.
> > + */
> > +struct fwnode_handle *
> > +device_add_child_properties(struct device *dev,
> > +			    struct fwnode_handle *parent,
> > +			    const struct property_entry *properties)
> > +{
> > +	struct property_set *p;
> > +	struct property_set *parent_pset;
> > +
> > +	if (!properties)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	parent_pset = to_pset_node(parent);
> 
> For this function, the parent will in practice have to be
> dev_fwnode(dev), so I don't think you need @parent at all, no?
> 
> There is something wrong here..

Yes, I expect majority of the calls will use dev_fwnode(dev) as parent,
but nobody stops you from doing:

	device_add_properties(dev, props);
	c1 = device_add_child_properties(dev, dev_fwnode(dev), cp1);
	c2 = device_add_child_properties(dev, c1, cp2);
	c3 = device_add_child_properties(dev, c2, cp3);
	...

> 
> > +	if (!parent_pset)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	p = pset_create_set(properties);
> > +	if (IS_ERR(p))
> > +		return ERR_CAST(p);
> > +
> > +	p->dev = dev;
> 
> That looks wrong.
> 
> I'm guessing the assumption here is that the child nodes will never be
> assigned to their own devices, but you can't do that. It will limit
> the use of the child nodes to a very small number of cases, possibly
> only to gpios.

If I need to assign a node to a device I'll use device_add_properties()
API. device_add_child_properties() is for nodes living "below" the
device.

All nodes (the primary/secondary and children) would point to the owning
device, just for convenience.

> 
> I think that has to be fixed. It should not be a big deal. Just expect
> the child nodes to be removed separately, and add ref counting to the
> struct property_set handling.

Why do we need to remove them separately and what do we need refcounting
for?

> 
> > +	p->parent = parent_pset;
> > +	list_add_tail(&p->child_node, &parent_pset->children);
> > +
> > +	return &p->fwnode;
> > +}
> > +EXPORT_SYMBOL_GPL(device_add_child_properties);
> 
> The child nodes will change the purpose of the build-in property
> support. Originally the goal was just to support adding of build-in
> device properties to real firmware nodes, but things have changed
> quite a bit from that. These child nodes are purely tied to the
> build-in device property support, so we should be talking about adding
> pset type child nodes to pset type parent nodes in the API:
> fwnode_pset_add_child_node(), or something like that.

OK, I can change device_add_child_properties() to
fwnode_pset_add_child_node() if Rafael would prefer this name.

Thanks.

-- 
Dmitry

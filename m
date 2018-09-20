Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E302152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E302152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbeITTh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:37:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:28200 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeITTh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:37:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="91791252"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Sep 2018 06:53:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 Sep 2018 16:53:48 +0300
Date:   Thu, 20 Sep 2018 16:53:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180920135348.GF11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917181603.125492-3-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> +/**
> + * device_add_child_properties - Add a collection of properties to a device object.
> + * @dev: Device to add properties to.

In case you didn't notice my comment for this, you are missing @parent
here.

But why do you need both the parent and the dev?

> + * @properties: Collection of properties to add.
> + *
> + * Associate a collection of device properties represented by @properties as a
> + * child of given @parent firmware node.  The function takes a copy of
> + * @properties.
> + */
> +struct fwnode_handle *
> +device_add_child_properties(struct device *dev,
> +			    struct fwnode_handle *parent,
> +			    const struct property_entry *properties)
> +{
> +	struct property_set *p;
> +	struct property_set *parent_pset;
> +
> +	if (!properties)
> +		return ERR_PTR(-EINVAL);
> +
> +	parent_pset = to_pset_node(parent);

For this function, the parent will in practice have to be
dev_fwnode(dev), so I don't think you need @parent at all, no?

There is something wrong here..

> +	if (!parent_pset)
> +		return ERR_PTR(-EINVAL);
> +
> +	p = pset_create_set(properties);
> +	if (IS_ERR(p))
> +		return ERR_CAST(p);
> +
> +	p->dev = dev;

That looks wrong.

I'm guessing the assumption here is that the child nodes will never be
assigned to their own devices, but you can't do that. It will limit
the use of the child nodes to a very small number of cases, possibly
only to gpios.

I think that has to be fixed. It should not be a big deal. Just expect
the child nodes to be removed separately, and add ref counting to the
struct property_set handling.

> +	p->parent = parent_pset;
> +	list_add_tail(&p->child_node, &parent_pset->children);
> +
> +	return &p->fwnode;
> +}
> +EXPORT_SYMBOL_GPL(device_add_child_properties);

The child nodes will change the purpose of the build-in property
support. Originally the goal was just to support adding of build-in
device properties to real firmware nodes, but things have changed
quite a bit from that. These child nodes are purely tied to the
build-in device property support, so we should be talking about adding
pset type child nodes to pset type parent nodes in the API:
fwnode_pset_add_child_node(), or something like that.

I'm sorry to be a bit of pain in the butt with this. The build-in
property support is a hack, it always was. A useful hack, but hack
nevertheless. That means we need to be extra careful when expanding
it, like here.


Thanks,

-- 
heikki

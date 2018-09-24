Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EA4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDBF21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDBF21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbeIXTXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:23:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:18155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeIXTXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:23:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 06:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="92762414"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 24 Sep 2018 06:20:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Sep 2018 16:20:50 +0300
Date:   Mon, 24 Sep 2018 16:20:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180924132050.GK11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921233119.GA44099@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Sep 21, 2018 at 04:31:19PM -0700, Dmitry Torokhov wrote:
> > > +	if (!parent_pset)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	p = pset_create_set(properties);
> > > +	if (IS_ERR(p))
> > > +		return ERR_CAST(p);
> > > +
> > > +	p->dev = dev;
> > 
> > That looks wrong.
> > 
> > I'm guessing the assumption here is that the child nodes will never be
> > assigned to their own devices, but you can't do that. It will limit
> > the use of the child nodes to a very small number of cases, possibly
> > only to gpios.
> 
> If I need to assign a node to a device I'll use device_add_properties()
> API. device_add_child_properties() is for nodes living "below" the
> device.

device_add_properties() is not available to us before we have the
actual struct device meant for the properties. If the child device is
populated outside of the "boardfiles" then we have to be able to link
it to the child node afterwards.

But I took a closer look at the code and realized that you are not
using that p->dev with the child nodes for anything, so I may be wrong
about this. You are not actually linking the child nodes to that
device here.

> All nodes (the primary/secondary and children) would point to the owning
> device, just for convenience.

Since you don't use that for anything, then drop that line. It's only
confusing.

And besides, since we will have separate child devices for those child
nodes, there is a small change that somebody needs to call
device_remove_properties(child_dev). At least then that operation
becomes safe, as it's a nop with the child pset nodes.

> > I think that has to be fixed. It should not be a big deal. Just expect
> > the child nodes to be removed separately, and add ref counting to the
> > struct property_set handling.
> 
> Why do we need to remove them separately and what do we need refcounting
> for?

If you could remove the nodes independently, then obviously the parent
can not be removed before the children. The ref count would be there
to prevent that.

Though my original comment is not valid, I still think that the child
nodes should be created and destroyed separately. Actually, I don't
think we should be talking about child nodes in the API at all. Check
below..

> > > +	p->parent = parent_pset;
> > > +	list_add_tail(&p->child_node, &parent_pset->children);
> > > +
> > > +	return &p->fwnode;
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_add_child_properties);
> > 
> > The child nodes will change the purpose of the build-in property
> > support. Originally the goal was just to support adding of build-in
> > device properties to real firmware nodes, but things have changed
> > quite a bit from that. These child nodes are purely tied to the
> > build-in device property support, so we should be talking about adding
> > pset type child nodes to pset type parent nodes in the API:
> > fwnode_pset_add_child_node(), or something like that.
> 
> OK, I can change device_add_child_properties() to
> fwnode_pset_add_child_node() if Rafael would prefer this name.

So not even that. We should have API like this:

struct fwnode_handle *
fwnode_pset_create(struct fwnode_handle *parent, const char *name,
                   const struct property_entry *props);

void fwnode_pset_destroy(struct fwnode_handle *fwnode);

int device_add_properties(struct device *dev,
                          const struct fwnode_handle *pset_node);

void device_remove_properties(struct device *dev);

So basically we separate creation of the nodes from linking them to the
devices completely. That would give this API much better structure. It
would scale better, for example, it would then be possible to add
child nodes from different locations if needed.


Thanks,

-- 
heikki

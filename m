Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C86ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7CC208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7CC208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIXNhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:37:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:62256 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeIXNhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:37:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 00:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,296,1534834800"; 
   d="scan'208";a="92682559"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 24 Sep 2018 00:29:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Sep 2018 10:29:53 +0300
Date:   Mon, 24 Sep 2018 10:29:53 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180924072953.GH11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
 <20180919171326.GB116719@dtor-ws>
 <20180920101648.GC11965@kuha.fi.intel.com>
 <20180921233336.GB44099@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921233336.GB44099@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:33:36PM -0700, Dmitry Torokhov wrote:
> On Thu, Sep 20, 2018 at 01:16:48PM +0300, Heikki Krogerus wrote:
> > On Wed, Sep 19, 2018 at 10:13:26AM -0700, Dmitry Torokhov wrote:
> > > > > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > > > > index 08ecc13080ae..63f2377aefe8 100644
> > > > > --- a/drivers/base/pset_property.c
> > > > > +++ b/drivers/base/pset_property.c
> > > > > @@ -18,6 +18,11 @@ struct property_set {
> > > > >  	struct device *dev;
> > > > >  	struct fwnode_handle fwnode;
> > > > >  	const struct property_entry *properties;
> > > > > +
> > > > > +	struct property_set *parent;
> > > > > +	/* Entry in parent->children list */
> > > > > +	struct list_head child_node;
> > > > > +	struct list_head children;
> > > > 
> > > > Add
> > > > 
> > > >         const char *name;
> > > > 
> > > > and you can implement also pset_get_named_child_node().
> > > 
> > > Or
> > > 	char name[];
> > > 
> > > to avoid separate allocation.
> > 
> > Let's not do that, especially if you are planning on exporting this
> > structure.
> 
> Can you please elaborate why? Not using pointer saves us 4/8 bytes +
> however much memory we need for bookkeeping for the extra chunk. Given
> that majority of pset nodes are unnamed this seems wasteful.
> 
> > If the name is coming from .rodata, there is no need to
> > allocate anything for the name. Check kstrdup_const().
> 
> The data is most likely coming as __initconst so we do need to copy it.

OK, I did not consider that. Yes, it makes sense to always copy.

Thanks,

-- 
heikki

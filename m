Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D52DECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9921529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E9921529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbeITQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:05:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:4221 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731755AbeITQFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:05:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 03:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="91738481"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 Sep 2018 03:16:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 Sep 2018 13:16:48 +0300
Date:   Thu, 20 Sep 2018 13:16:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180920101648.GC11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
 <20180919171326.GB116719@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919171326.GB116719@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:13:26AM -0700, Dmitry Torokhov wrote:
> > > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > > index 08ecc13080ae..63f2377aefe8 100644
> > > --- a/drivers/base/pset_property.c
> > > +++ b/drivers/base/pset_property.c
> > > @@ -18,6 +18,11 @@ struct property_set {
> > >  	struct device *dev;
> > >  	struct fwnode_handle fwnode;
> > >  	const struct property_entry *properties;
> > > +
> > > +	struct property_set *parent;
> > > +	/* Entry in parent->children list */
> > > +	struct list_head child_node;
> > > +	struct list_head children;
> > 
> > Add
> > 
> >         const char *name;
> > 
> > and you can implement also pset_get_named_child_node().
> 
> Or
> 	char name[];
> 
> to avoid separate allocation.

Let's not do that, especially if you are planning on exporting this
structure. If the name is coming from .rodata, there is no need to
allocate anything for the name. Check kstrdup_const().

> Alternatively, we can add it later when we need it, and add
> device_add_named_child_properties().
> 
> I'll leave it up to Rafael to decide.

Fair enough.


Thanks,

-- 
heikki

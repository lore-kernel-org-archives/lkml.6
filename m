Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C942AECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606D92156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUYzb3A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606D92156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbeIVFYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:24:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34878 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeIVFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:24:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so6624420pfh.2;
        Fri, 21 Sep 2018 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=axLDuYefmA2uvjmcj61BjT6ReXudzQM9K2iLPqRpKuU=;
        b=ZUYzb3A+vlzfUGao83ThvO+XyWO0OHan2TcQQFojCggl/5xyGsh1hOtahyQlbNlAqf
         cDUzU0fCtQTvlYmyOxvh9PF9Apuu3C+AtgwylJglJBjuLN1JwXOj6NOvF4ACvGd7slWo
         iOd7eGifXC7uxhdyL9N70LJqxQRenZDYzwxwFGyoX49gNIzsr0d0W3ul/iU3MjWxTmHN
         VnTKna/r4kgddZJgr9Dkd//TksM0AWPf0Zs3mDJYqdSekOK/MODtUpf0cyZVVlVq5RFY
         y/STMnEHbs78ppTf8+DkpMxnu55GnEChBVHyxI/FWmUf9kylw261FAERH4/TT2Z66P32
         EIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=axLDuYefmA2uvjmcj61BjT6ReXudzQM9K2iLPqRpKuU=;
        b=FQ7bK7Y7skM4/naDkp2frsLmiWECUaWfEm8vJQhBMalix230lu7ot0OXNAnJ+mVe9o
         8+juYAOglRo9Z+MgRKRlYVLexuKGdeVLvREEmtHRJqvSHIuuIsSiXV5v7gfMeAeJP9cH
         3E6DHTkfqOKcRqh4qA3/qtiljjoyzwzlm3tYdKUiH5glp1grgseFCxTJh8oHCEFQDBqL
         qdJ6rnaYG791m5jLHh2bYfj/yeCxQN1DoD/mKXBtjDblVwVPAt06UreGfoe/erEkjR1e
         k6D4b/iUXSkG3YTohySuCrBpYpawzlS8p66Q6WHdWb1zpjinnb7XxQ1E/WHTUMrdvZqu
         uieA==
X-Gm-Message-State: ABuFfohd3lmx9CdX7OQBjGCPCnkNaAuNtupFHprFutFPqvjV3WT5okmH
        Njw7juNe/ryPE5hBJcNJytY=
X-Google-Smtp-Source: ACcGV63mgUZgDxrokMuxj2zPYGVv6e04cEHUWpnF8vDA7L+OXk+dYClMoHcuRcERDL9AQ0lhsschDg==
X-Received: by 2002:a63:7e1c:: with SMTP id z28-v6mr19427pgc.246.1537572819185;
        Fri, 21 Sep 2018 16:33:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 1-v6sm47337471pfk.134.2018.09.21.16.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:33:38 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:33:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180921233336.GB44099@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
 <20180919171326.GB116719@dtor-ws>
 <20180920101648.GC11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920101648.GC11965@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 01:16:48PM +0300, Heikki Krogerus wrote:
> On Wed, Sep 19, 2018 at 10:13:26AM -0700, Dmitry Torokhov wrote:
> > > > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > > > index 08ecc13080ae..63f2377aefe8 100644
> > > > --- a/drivers/base/pset_property.c
> > > > +++ b/drivers/base/pset_property.c
> > > > @@ -18,6 +18,11 @@ struct property_set {
> > > >  	struct device *dev;
> > > >  	struct fwnode_handle fwnode;
> > > >  	const struct property_entry *properties;
> > > > +
> > > > +	struct property_set *parent;
> > > > +	/* Entry in parent->children list */
> > > > +	struct list_head child_node;
> > > > +	struct list_head children;
> > > 
> > > Add
> > > 
> > >         const char *name;
> > > 
> > > and you can implement also pset_get_named_child_node().
> > 
> > Or
> > 	char name[];
> > 
> > to avoid separate allocation.
> 
> Let's not do that, especially if you are planning on exporting this
> structure.

Can you please elaborate why? Not using pointer saves us 4/8 bytes +
however much memory we need for bookkeeping for the extra chunk. Given
that majority of pset nodes are unnamed this seems wasteful.

> If the name is coming from .rodata, there is no need to
> allocate anything for the name. Check kstrdup_const().

The data is most likely coming as __initconst so we do need to copy it.

> 
> > Alternatively, we can add it later when we need it, and add
> > device_add_named_child_properties().
> > 
> > I'll leave it up to Rafael to decide.
> 
> Fair enough.
> 
> 
> Thanks,
> 
> -- 
> heikki

Thanks.

-- 
Dmitry

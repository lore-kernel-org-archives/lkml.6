Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE92CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7930B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7930B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeKFXxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:53:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:37844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388583AbeKFXxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:53:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 06:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="277526053"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2018 06:28:11 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gK2Kw-00053g-Fm; Tue, 06 Nov 2018 16:28:10 +0200
Date:   Tue, 6 Nov 2018 16:28:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Message-ID: <20181106142810.GX10650@smile.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 07:18:14AM -0600, Rob Herring wrote:
> On Tue, Nov 6, 2018 at 6:27 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Nov 06, 2018 at 12:58:03PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 05, 2018 at 12:50:02PM -0600, Rob Herring wrote:
> > > > On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > > > +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> > > > > +{
> > > > > +       return to_of_node(fwnode)->name;
> > > >
> > > > I'm trying to get rid of the DT name ptr, so please don't add one. You
> > > > can use of_node_full_name() here instead if "<name>@<unit-address>"
> > > > instead of <name> is fine. Otherwise, you've got to allocate your own
> > > > storage and use "%pOFn" printf specifier.
> > >
> > > If we do this here, we will change a behaviour of the entire set of
> > > of_fwnode_get_named_child_node() users.
> > >
> > > I think this is out of scope of the series.
> 
> No, because you are adding a firmware op for something that's going away.

W/o your below explanation it wasn't obvious.

> 
> > You have a point. We must use the same member that was used in
> > of_fwnode_get_named_child_node().
> >
> > The goal of this series if most likely not clear from this patch
> > alone, so I'll send a second version and make sure to CC the DT list
> > and Rob.
> 
> Looking at patch 4, if matching the name is what you want to do, then
> use the DT name matching functions. They were added in 4.19.

Do you mean of_node_name_eq()?


-- 
With Best Regards,
Andy Shevchenko



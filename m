Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C30A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIFCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:02:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:47536 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeKIFCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:02:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 11:25:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="106610765"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2018 11:25:10 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gKpvR-0008RB-Pn; Thu, 08 Nov 2018 21:25:09 +0200
Date:   Thu, 8 Nov 2018 21:25:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Message-ID: <20181108192509.GW10650@smile.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > This implements get_name fwnode op for DT.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/of/property.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f46828e3b082..9bc8fe136fa3 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> >         of_node_put(to_of_node(fwnode));
> >  }
> >
> > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > +{
> > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > +       size_t len = strchrnul(name, '@') - name;
> > +
> > +       snprintf(buf, len + 1, "%s", name);
> 
> This can be simplified to:
> 
> snprintf(..., "%pOFn", to_of_node(fwnode))
> 
> But that presents a problem with knowing the length. Not passing in
> the buf length is not good design because you can't tell if you
> overflow the buffer. Either you can pass in the length of buf or do
> the allocation here. In the latter case, then you can use kasnprintf.
> The downside to doing the allocation here is then get_name() has side
> effect of allocating memory that the caller needs to be aware of.

Agree on matter of potential overflow.

I wouldn't limit users with 32 characters for node name if it's not by both
ACPI and DT specifications. OTOH allocating and freeing memory in a loop each
time when we would like to go through the child nodes sounds much worse
scenario to me. Thus, giving a length of the buffer is a good enough compromise.

> However, I think the current API is better. It leaves low-level
> details up to the firmware implementation. But as long as .get_name()
> is not exposed to drivers I don't really care that much.

I don't think this concept is changed by Heikki's patch series. It provides a
common abstract function on top of more low-level firmware implementation which
I consider a good approach.

-- 
With Best Regards,
Andy Shevchenko



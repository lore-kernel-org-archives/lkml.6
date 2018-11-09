Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CF02081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeKIXP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:15:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:47054 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeKIXP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:15:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 05:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="106720099"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2018 05:34:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 09 Nov 2018 15:34:43 +0200
Date:   Fri, 9 Nov 2018 15:34:42 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Message-ID: <20181109133442.GA28183@kuha.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com>
 <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:18:21PM -0600, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 1:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> > > On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > This implements get_name fwnode op for DT.
> > > >
> > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > ---
> > > >  drivers/of/property.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > index f46828e3b082..9bc8fe136fa3 100644
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> > > >         of_node_put(to_of_node(fwnode));
> > > >  }
> > > >
> > > > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > > > +{
> > > > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > > > +       size_t len = strchrnul(name, '@') - name;
> > > > +
> > > > +       snprintf(buf, len + 1, "%s", name);
> > >
> > > This can be simplified to:
> > >
> > > snprintf(..., "%pOFn", to_of_node(fwnode))
> > >
> > > But that presents a problem with knowing the length. Not passing in
> > > the buf length is not good design because you can't tell if you
> > > overflow the buffer. Either you can pass in the length of buf or do
> > > the allocation here. In the latter case, then you can use kasnprintf.
> > > The downside to doing the allocation here is then get_name() has side
> > > effect of allocating memory that the caller needs to be aware of.
> >
> > Agree on matter of potential overflow.
> >
> > I wouldn't limit users with 32 characters for node name if it's not by both
> > ACPI and DT specifications.
> 
> While the DT spec says 31 characters, this has never been enforced. As
> you might guess, we have node names longer than 31 characters. There's
> been some discussion about what to do and the consensus seems to be
> change the spec.
> 
> > OTOH allocating and freeing memory in a loop each
> > time when we would like to go through the child nodes sounds much worse
> > scenario to me.
> 
> Yes, I wrote that before looking at how you were using it... Of
> course, if you want efficient, then you shouldn't use sprintf either
> and use of_node_name_eq() as I've suggested.

Since the fwnode API is just a wrapper layer (at least IMO), I don't
think there should be any assumptions that it provides the optimal
solution for anything. The low-level APIs should be the ones providing
the optimal solutions.

> > Thus, giving a length of the buffer is a good enough compromise.

OK. That's what we'll do then.

> > > However, I think the current API is better. It leaves low-level
> > > details up to the firmware implementation. But as long as .get_name()
> > > is not exposed to drivers I don't really care that much.

Side note:

I would prefer that we had something like of_node_name_get() function
that of_fwnode_get_name() could simply call. I don't know how you want
that implemented, but I'm expecting you will implement something like
that in any case once you start removing that ->name member. I figured
that at that point we can update of_fwnode_get_name() as well.

> > I don't think this concept is changed by Heikki's patch series. It provides a
> > common abstract function on top of more low-level firmware implementation which
> > I consider a good approach.
> 
> Generally, I would agree that's a worthwhile goal. However, in this
> case you aren't saving anything. We still have at least a DT version
> of the same thing (of_get_child_by_name). Maybe there's some dream
> that the fwnode API will become the only one for both drivers and
> non-drivers, but I really don't see that happening. As long as both DT
> and fwnode APIs are in use, it is best to keep the APIs aligned.

I don't think that anybody was planning to have the fwnode API as
the only available API for the drivers. It's just a helper for the
drivers on top of the low-level APIs, so the low-level APIs really
need to always stay available for the drivers. There will always be
corner cases.

> There's another aspect that the node name comparison is case
> insensitive on powerpc (and until 4.20, was for everything but Sparc).
> I changed it in 4.20 and hopefully don't have to revert. Patch 4 does
> a case sensitive compare. That probably is fine (as lots of powerpc
> code already does case sensitive name compares), but no one really
> knows until we break users.

I actually used stccasecmp() in the first version. I don't know how,
or why, I've changed it to strcmp(). I'll fix that.

> Another issue is how are disabled nodes dealt with by different
> firmwares? It's a frequent bug that we don't honor the 'status'
> property (such as in the very code we're discussing). But then there
> are some cases were want to ignore it so we can't just go add that
> check in and we end up needing 2 flavors of everything. You're
> probably okay though. Most devices with child nodes are
> enabled/disabled only in the parent device node.


thanks,

-- 
heikki

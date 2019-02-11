Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D3FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD69220821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfBKJyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:54:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:33942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfBKJyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:54:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 01:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="317990891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga006.fm.intel.com with SMTP; 11 Feb 2019 01:54:36 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 11:54:36 +0200
Date:   Mon, 11 Feb 2019 11:54:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 13/28] thunderbolt: Add helper function to iterate
 from one port to another
Message-ID: <20190211095436.GW7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-14-mika.westerberg@linux.intel.com>
 <20190211061600.6ty733qfagk7f6fp@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211061600.6ty733qfagk7f6fp@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:16:00AM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:23PM +0300, Mika Westerberg wrote:
> > We need to be able to walk from one port to another when we are creating
> > paths where there are multiple switches between two ports. For this
> > reason introduce a new function tb_port_get_next() and a new macro
> > tb_for_each_port().
> 
> These names seem fairly generic, they might as well refer to the next port
> on a switch or iterate over the ports on a switch.  E.g. I've proposed a
> tb_sw_for_each_port() macro in this patch:
> 
> https://lore.kernel.org/patchwork/patch/983863/
> 
> I'd suggest renaming tb_port_get_next() to something like
> tb_next_port_on_path() or tb_path_next_port() or tb_path_walk().

OK, tb_next_port_on_path() sounds good to me.

> And I'd suggest dropping tb_for_each_port() because there are only
> two occurrences where it's used, one calculates the path length,
> and I think that's simply the route string length plus 2, and the
> other one in patch 17 isn't even interested in the ports along a path,
> but rather in the switches between the root switch and the end of a path.
> It seems simpler to just iterate from the switch at the end upwards to
> the root switch by following the parent pointer in the switch's
> struct device, or alternatively by bytewise iterating over the route
> string and calling get_switch_at_route() each time.

OK.

> > +/**
> > + * tb_port_get_next() - Return next port for given port
> > + * @start: Start port of the walk
> > + * @end: End port of the walk
> > + * @prev: Previous port (%NULL if this is the first)
> > + *
> > + * This function can be used to walk from one port to another if they
> > + * are connected through zero or more switches. If the @prev is dual
> > + * link port, the function follows that link and returns another end on
> > + * that same link.
> > + *
> > + * If the walk cannot be continued, returns %NULL.
> 
> This sounds as if NULL is returned if an error occurs but that doesn't
> seem to be what the function does.  I'd suggest:
> 
> "If the @end port has been reached, return %NULL."

It returns NULL if @end cannot be reached. So what about:

  "If @end cannot be reached, returns %NULL"

?

> > +struct tb_port *tb_port_get_next(struct tb_port *start, struct tb_port *end,
> > +				 struct tb_port *prev)
> > +{
> > +	struct tb_port *port, *next;
> > +
> > +	if (!prev)
> > +		return start;
> > +
> > +	if (prev->sw == end->sw) {
> > +		if (prev != end)
> > +			return end;
> > +		return NULL;
> > +	}
> > +
> > +	/* Switch back to use primary links for walking */
> 
> "Switch back" requires that you switched to something else before,
> which you didn't.  I'd suggest something like:
> 
> "use primary link to discover next port"

OK.

> Why is it necessary to use the primary link anyway?  Is the
> ->remote member not set on the secondary link port?  The reason
> should probably be spelled out in the code comment.

IIRC it was because you may have something in the middle with only one
port (the primary). I'll add a comment here explaining that.

> > +	if (prev->dual_link_port && prev->link_nr)
> > +		port = prev->dual_link_port;
> > +	else
> > +		port = prev;
> > +
> > +	if (start->sw->config.depth < end->sw->config.depth) {
> > +		if (port->remote &&
> > +		    port->remote->sw->config.depth > port->sw->config.depth)
> 
> Can we use "if (!tb_is_upstream_port(port))" for consistency with the
> if-clause below?

Yes, I think that should work.

> > +			next = port->remote;
> > +		else
> > +			next = tb_port_at(tb_route(end->sw), port->sw);
> > +	} else if (start->sw->config.depth > end->sw->config.depth) {
> > +		if (tb_is_upstream_port(port))
> > +			next = port->remote;
> > +		else
> > +			next = tb_upstream_port(port->sw);
> > +	} else {
> > +		/* Must be the same switch then */
> > +		if (start->sw != end->sw)
> > +			return NULL;
> > +		return end;
> > +	}
> 
> The else-clause here appears to be dead code, you've already checked
> further up whether prev and end are on the same switch.

OK.

> > +
> > +	/* If prev was dual link return another end of that link then */
> 
> *Here* a "switch back" comment would be appropriate.  Nit: Please either
> end code comments with a period or don't start them with an upper case
> letter.

That's the style I've been using in this driver and elsewhere and is my
preference anyway.

I'll update the comment content, though. :)

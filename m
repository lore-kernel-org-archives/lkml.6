Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4C4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D0F218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfBLNzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:55:45 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:34055 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfBLNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:55:45 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 49809100D940B;
        Tue, 12 Feb 2019 14:55:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F117A13BC1E; Tue, 12 Feb 2019 14:55:42 +0100 (CET)
Date:   Tue, 12 Feb 2019 14:55:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 13/28] thunderbolt: Add helper function to iterate
 from one port to another
Message-ID: <20190212135542.xkxjjai3wvnq2mk6@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-14-mika.westerberg@linux.intel.com>
 <20190211061600.6ty733qfagk7f6fp@wunner.de>
 <20190211095436.GW7875@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211095436.GW7875@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:54:36AM +0200, Mika Westerberg wrote:
> On Mon, Feb 11, 2019 at 07:16:00AM +0100, Lukas Wunner wrote:
> > On Wed, Feb 06, 2019 at 04:17:23PM +0300, Mika Westerberg wrote:
> > > +/**
> > > + * tb_port_get_next() - Return next port for given port
> > > + * @start: Start port of the walk
> > > + * @end: End port of the walk
> > > + * @prev: Previous port (%NULL if this is the first)
> > > + *
> > > + * This function can be used to walk from one port to another if they
> > > + * are connected through zero or more switches. If the @prev is dual
> > > + * link port, the function follows that link and returns another end on
> > > + * that same link.
> > > + *
> > > + * If the walk cannot be continued, returns %NULL.
> > 
> > This sounds as if NULL is returned if an error occurs but that doesn't
> > seem to be what the function does.  I'd suggest:
> > 
> > "If the @end port has been reached, return %NULL."
> 
> It returns NULL if @end cannot be reached. So what about:
> 
>   "If @end cannot be reached, returns %NULL"
> 
> ?

That doesn't appear to match what the function does.  There are two places
where NULL is returned:

The first is at the top of the function and returns NULL if
((prev->sw == end->sw) && (prev == end)).  So this happens when the
entire path has been traversed and "end" is passed in as prev argument.

The second is at the bottom and is presumably never executed because
it only happens if (start->sw->config.depth == end->sw->config.depth),
which I believe is only the case if (start->sw == end->sw), which implies
that prev can only be either "start" or "end", and both cases are already
handled at the top of the function.

Bottom line is that NULL is returned once the traversal has concluded.
Am I missing something?


> > Why is it necessary to use the primary link anyway?  Is the
> > ->remote member not set on the secondary link port?  The reason
> > should probably be spelled out in the code comment.
> 
> IIRC it was because you may have something in the middle with only one
> port (the primary). I'll add a comment here explaining that.

Hm, I'm wondering if it wouldn't be more straightforward to also set
the remote member on secondary links to avoid all this special casing?
Any downside to that?

Thanks,

Lukas

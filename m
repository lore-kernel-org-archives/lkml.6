Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E2C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC79222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfBLTDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:03:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:65130 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfBLTDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:03:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 11:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="274522894"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 12 Feb 2019 11:03:18 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Feb 2019 21:03:17 +0200
Date:   Tue, 12 Feb 2019 21:03:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 13/28] thunderbolt: Add helper function to iterate
 from one port to another
Message-ID: <20190212190317.GK7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-14-mika.westerberg@linux.intel.com>
 <20190211061600.6ty733qfagk7f6fp@wunner.de>
 <20190211095436.GW7875@lahna.fi.intel.com>
 <20190212135542.xkxjjai3wvnq2mk6@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212135542.xkxjjai3wvnq2mk6@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:55:42PM +0100, Lukas Wunner wrote:
> On Mon, Feb 11, 2019 at 11:54:36AM +0200, Mika Westerberg wrote:
> > On Mon, Feb 11, 2019 at 07:16:00AM +0100, Lukas Wunner wrote:
> > > On Wed, Feb 06, 2019 at 04:17:23PM +0300, Mika Westerberg wrote:
> > > > +/**
> > > > + * tb_port_get_next() - Return next port for given port
> > > > + * @start: Start port of the walk
> > > > + * @end: End port of the walk
> > > > + * @prev: Previous port (%NULL if this is the first)
> > > > + *
> > > > + * This function can be used to walk from one port to another if they
> > > > + * are connected through zero or more switches. If the @prev is dual
> > > > + * link port, the function follows that link and returns another end on
> > > > + * that same link.
> > > > + *
> > > > + * If the walk cannot be continued, returns %NULL.
> > > 
> > > This sounds as if NULL is returned if an error occurs but that doesn't
> > > seem to be what the function does.  I'd suggest:
> > > 
> > > "If the @end port has been reached, return %NULL."
> > 
> > It returns NULL if @end cannot be reached. So what about:
> > 
> >   "If @end cannot be reached, returns %NULL"
> > 
> > ?
> 
> That doesn't appear to match what the function does.  There are two places
> where NULL is returned:
> 
> The first is at the top of the function and returns NULL if
> ((prev->sw == end->sw) && (prev == end)).  So this happens when the
> entire path has been traversed and "end" is passed in as prev argument.
> 
> The second is at the bottom and is presumably never executed because
> it only happens if (start->sw->config.depth == end->sw->config.depth),
> which I believe is only the case if (start->sw == end->sw), which implies
> that prev can only be either "start" or "end", and both cases are already
> handled at the top of the function.
> 
> Bottom line is that NULL is returned once the traversal has concluded.
> Am I missing something?

No, you are right. I'll update the comment accordingly.

> > > Why is it necessary to use the primary link anyway?  Is the
> > > ->remote member not set on the secondary link port?  The reason
> > > should probably be spelled out in the code comment.
> > 
> > IIRC it was because you may have something in the middle with only one
> > port (the primary). I'll add a comment here explaining that.
> 
> Hm, I'm wondering if it wouldn't be more straightforward to also set
> the remote member on secondary links to avoid all this special casing?
> Any downside to that?

I think it is useful to distinguish between primary and secondary links
as we do when we establish DP tunnels. Granted we could rename them to
"primary" and "secondary" instead of "remote" and "dual_link_port".  Or
alternatively have two remotes and then link_nr or something like that.
I'll try and see if it simplifies the code.

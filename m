Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E89C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfBKIwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:52:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:15669 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfBKIwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:52:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 00:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="132633095"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 11 Feb 2019 00:52:04 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 10:52:03 +0200
Date:   Mon, 11 Feb 2019 10:52:03 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 15/28] thunderbolt: Deactivate all paths before
 restarting them
Message-ID: <20190211085203.GV7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-16-mika.westerberg@linux.intel.com>
 <20190211063555.2bozvqen2jmskox4@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211063555.2bozvqen2jmskox4@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:35:55AM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:25PM +0300, Mika Westerberg wrote:
> > We can't be sure the paths are actually properly deactivated when a
> > tunnel is restarted after resume.
> 
> Why can't we be sure?  Please provide proper reasoning.

IIRC the reason was that when you suspend, then reconfigure parts of the
topology and resume, establishing the tunnel again went wrong. I'll
update the changelog with a better reasoning.

> > So instead of marking all paths as
> > inactive we go ahead and deactivate them explicitly.
> 
> This seems like a bad idea if the root partition is on a Thunderbolt-
> attached drive, the system is waking from hibernate and the EFI NHI
> driver has already established a tunnel to that drive.  It would seem
> more appropriate to discover tunnels already existing on resume from
> system sleep and then attempt to establish any others that might be
> missing.

That's what we do in the patch following, no? We discover the EFI
created paths and use that information to re-establish tunnels upon S3
resume and also when they are torn down.

> > @@ -183,8 +183,15 @@ int tb_tunnel_restart(struct tb_tunnel *tunnel)
> >  
> >  	tb_tunnel_info(tunnel, "activating\n");
> >  
> > +	/* Make sure all paths are properly disabled before enable them again */
> 
> This isn't proper English, s/enable/enabling/.

Thanks, I'll fix it up.

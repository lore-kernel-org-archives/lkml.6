Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B52C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FF220842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfBLSeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:34:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:53818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfBLSeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:34:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 10:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="114372092"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 12 Feb 2019 10:34:16 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Feb 2019 20:34:15 +0200
Date:   Tue, 12 Feb 2019 20:34:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 16/28] thunderbolt: Discover preboot PCIe paths the
 boot firmware established
Message-ID: <20190212183415.GI7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-17-mika.westerberg@linux.intel.com>
 <20190212174942.if2ene44f5m5mern@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212174942.if2ene44f5m5mern@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:49:42PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:26PM +0300, Mika Westerberg wrote:
> >  		/* dword 0 */
> >  		hop.next_hop = path->hops[i].next_hop_index;
> >  		hop.out_port = path->hops[i].out_port->port;
> > -		/* TODO: figure out why these are good values */
> > -		hop.initial_credits = (i == path->path_length - 1) ? 16 : 7;
> > +		hop.initial_credits = path->hops[i].initial_credits;
> >  		hop.unknown1 = 0;
> >  		hop.enable = 1;
> [...]
> > @@ -78,6 +78,74 @@ static void tb_pci_init_path(struct tb_path *path)
> >  	path->weight = 1;
> >  	path->drop_packages = 0;
> >  	path->nfc_credits = 0;
> > +	path->hops[0].initial_credits = 7;
> > +	path->hops[1].initial_credits = 16;
> 
> I guess Andreas' algorithm (the last hop in the path is assigned
> 16 and all the ones before are assigned 7) was reverse-engineered
> from Apple's driver.  The fact that this algorithm works for paths
> of arbitrary length could indicate that Apple indeed does establish
> tunnels between non-adjacent switches.

We do it as well for DP and DMA paths in subsequent patches. For those
there are NULL ports in the middle which get assigned different amount
of credits. PCIe paths on the other hand only need two hops when we
daisy-chain them in this patch series.

> Also, why are these good values?  (You've deleted the comment.)

To be honest, I don't know all the details. Credits are used for flow
control to make sure receiving port always has enough buffers before
sending port can send more packets (assuming the path is using flow
control). I don't know where 7 and 16 came but they seem to work pretty
well for PCIe path so I kept using them.

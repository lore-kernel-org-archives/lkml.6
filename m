Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05E2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfBLMva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:51:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:9890 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLMv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:51:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 04:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="274418848"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 12 Feb 2019 04:51:25 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Feb 2019 14:51:25 +0200
Date:   Tue, 12 Feb 2019 14:51:25 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 12/28] thunderbolt: Add functions for allocating and
 releasing hop IDs
Message-ID: <20190212125125.GG7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-13-mika.westerberg@linux.intel.com>
 <20190210121353.fw7gj4pm7ce3flvf@wunner.de>
 <20190211083043.GT7875@lahna.fi.intel.com>
 <20190212124333.hgrnm6owtuqzp4iu@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212124333.hgrnm6owtuqzp4iu@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:43:33PM +0100, Lukas Wunner wrote:
> On Mon, Feb 11, 2019 at 10:30:43AM +0200, Mika Westerberg wrote:
> > On Sun, Feb 10, 2019 at 01:13:53PM +0100, Lukas Wunner wrote:
> > > If there are two Macs at the ends of the daisy-chain with Thunderbolt
> > > devices in-between, the other Mac may already have established tunnels
> > > to some of the devices and therefore has occupied hop entries in the
> > > devices' path config space.  How do you ensure that you don't allocate
> > > the same entries and overwrite the other Mac's hop entries, thereby
> > > breaking its tunnels?
> > 
> > If the other Mac has enumerated the device (set the upstream port,
> > route, depth) then the other Mac cannot access the device. You get an
> > error (we deal with that in the later patch in the series when we
> > identify XDomain connections). The Hop ID allocation is only relevant in
> > a single domain.  Crossing one needs to have protocol such as we have in
> > case of ThunderboltIP to negotiate Hop IDs used in the link between two
> > domains.
> 
> Understood now, thanks.  (Well, in part at least.)
> 
> It looks like there's a race condition currently in tb_switch_configure()
> wherein two machines on the daisy chain may write the config simultaneously
> and overwrite each other's changes.  Isn't there some kind of synchonization
> mechanism available to prevent such an outcome?

AFAICT that's expected. The host that first enumerated the device wins.

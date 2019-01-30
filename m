Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1990C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8920882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfA3JhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:37:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:14777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfA3JhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:37:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 01:37:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="316091199"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 30 Jan 2019 01:37:05 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Jan 2019 11:37:05 +0200
Date:   Wed, 30 Jan 2019 11:37:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/28] thunderbolt: Enable TMU access when accessing port
 space on legacy devices
Message-ID: <20190130093705.GF7875@lahna.fi.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-4-mika.westerberg@linux.intel.com>
 <20190129215858.c2yws2ce76d7qm62@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129215858.c2yws2ce76d7qm62@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:58:58PM +0100, Lukas Wunner wrote:
> On Tue, Jan 29, 2019 at 06:01:18PM +0300, Mika Westerberg wrote:
> > +	if (enable)
> > +		value |= BIT(20);
> 
> Can we have a macro for this bit?

Sure.

> > +int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
> > +{
> > +	int ret;
> > +
> > +	ret = tb_port_enable_tmu(port, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __tb_port_find_cap(port, cap);
> > +
> > +	tb_port_enable_tmu(port, false);
> > +
> > +	return ret;
> > +}
> 
> Would there be a downside to setting the TMU bit on all ports all the time
> (e.g. on switch enumeration)?

You mean turn it on once and keep it like that? Quick experimentation
with a couple of LR devices did not show any side-effects so I guess we
could just turn it on once during the enumeration in affected devices.

Main reason it is now in cap.c is because we only need it to be enabled
during the cap walk and that allows keeping both workarounds in the same
file close to the place where it is used.

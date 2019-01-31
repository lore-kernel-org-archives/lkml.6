Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED964C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5A2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfAaIx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:53:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:48988 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbfAaIx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:53:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 00:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="142997580"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 31 Jan 2019 00:53:53 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 31 Jan 2019 10:53:52 +0200
Date:   Thu, 31 Jan 2019 10:53:52 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/28] thunderbolt: Enable TMU access when accessing port
 space on legacy devices
Message-ID: <20190131085352.GS7875@lahna.fi.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-4-mika.westerberg@linux.intel.com>
 <20190129215858.c2yws2ce76d7qm62@wunner.de>
 <20190130093705.GF7875@lahna.fi.intel.com>
 <20190131082649.vat2epdhmuh4itt7@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131082649.vat2epdhmuh4itt7@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 09:26:49AM +0100, Lukas Wunner wrote:
> On Wed, Jan 30, 2019 at 11:37:05AM +0200, Mika Westerberg wrote:
> > On Tue, Jan 29, 2019 at 10:58:58PM +0100, Lukas Wunner wrote:
> > > On Tue, Jan 29, 2019 at 06:01:18PM +0300, Mika Westerberg wrote:
> > > > +int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = tb_port_enable_tmu(port, true);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = __tb_port_find_cap(port, cap);
> > > > +
> > > > +	tb_port_enable_tmu(port, false);
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > Would there be a downside to setting the TMU bit on all ports all the time
> > > (e.g. on switch enumeration)?
> > 
> > You mean turn it on once and keep it like that? Quick experimentation
> > with a couple of LR devices did not show any side-effects so I guess we
> > could just turn it on once during the enumeration in affected devices.
> 
> I guess I'm confused because I thought TMU is used for clock synchronization
> across the daisy-chain, so I would expect it to be available only on ports
> of type TB_TYPE_PORT, not on adapters of any type.  Yet a code comment in
> the current implementation of tb_port_find_cap() talks about TMU on DP out
> adapters?

DP out adapters include TMU capability. We don't use it in Linux because
it is not really needed for legacy hardware AFAIK.

> This patch says that the bit that's being modified is used for "access"
> to the TMU.  So apparently the bit is not about enablement of clock
> synchronization, but only about granting access to the TMU?  (For whom?)

LR has the thing disabled which makes port space capability walk to
fail. That's why we had the offset hack previously. Access here is for
the SW CM (tb.c).

> Doesn't TMU synchronization need to be enabled on all devices on the
> daisy chain for Thunderbolt to function?  (BTW in MacBooks with dual
> Alpine Ridge, e.g. MacBookPro13,3, the two controllers' TMU in and out
> pins are wired together, presumably this allows for clock synchronization
> across Thunderbolt chips in the same machine.)

For legacy hardware I don't think we need to do anything for the TMU
(with the exception of the workaround during cap walk on LR/ER). For
TBT 3 hardware it is taken care by the firmware.

> > Main reason it is now in cap.c is because we only need it to be enabled
> > during the cap walk and that allows keeping both workarounds in the same
> > file close to the place where it is used.
> 
> I was only wondering whether the bit should be set all the time
> because I was worrying that clock synchronization would otherwise
> not be enabled.  And if tb_port_find_cap() is called frequently,
> setting the bit only once provides for a small performance improvement.
> OTOH it would then be necessary to restore the bit when coming out of
> (runtime or system) suspend.  I guess I don't have a strong opinion
> on this because I don't fully grasp what the bit is for.

OK.

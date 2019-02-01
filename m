Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39662C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A006218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfBASgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:36:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:15905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBASgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:36:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 10:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="121315528"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2019 10:36:17 -0800
Date:   Fri, 1 Feb 2019 10:36:17 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Initialize "bank" when we find a fatal error in
 mce_no_way_out()
Message-ID: <20190201183616.GA24278@agluck-desk>
References: <20190201003341.10638-1-tony.luck@intel.com>
 <20190201095553.GC31854@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201095553.GC31854@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:55:53AM +0100, Borislav Petkov wrote:
> On Thu, Jan 31, 2019 at 04:33:41PM -0800, Tony Luck wrote:
> >  		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
> > +			m->bank = i;
> 
> So conceptually this write belongs in...
> 
> >  			mce_read_aux(m, i);

Really? That function starts with the comment

	/*
	 * Read ADDR and MISC registers.
	 */

and the name is pretty descriptive that it is "reading auxiliary" information.

> 
> ... this function, i.e., in mce_read_aux() because it gets the bank
> number passed in already. And our calling pattern when populating struct
> mce is:
> 
> 	mce_gather_info()
> 	mce_read_aux()

Only two exising uses:

1) in machine_check_poll()

	mce_gather_info(&m, NULL);
	for (each bank) {
		m.bank = i;
		mce_read_aux(&m, i);
		...
	}

2) in __mc_scan_banks

	// mce_gather_info() already done in do_machine_check
	for (each bank) {
		m.bank = i;
		mce_read_aux(m, i);
		...
	}
> 
> so it'll be more robust if we moved it there.

It would be redundant to move it there for both
existing uses.

> Also, that argument "i" of mce_read_aux() is not very telling and it
> should be "bank" but that would complicate the stable backporting so if
> you feel like it, you could do a second, cleanup patch ontop to fix that
> too.

Agreed that "bank" is clearer than "i". But also agreed that should
be a separate patch for another day.

-Tony

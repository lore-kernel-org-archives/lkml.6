Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF9220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF9220C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeGQKuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:50:22 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:41948 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbeGQKuV (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 17 Jul 2018 06:50:21 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 12:18:26 +0200
Received: from suselix (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 17 Jul 2018 11:18:07 +0100
Date:   Tue, 17 Jul 2018 12:18:05 +0200
From:   Andreas Herrmann <aherrmann@suse.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Message-ID: <20180717101805.ctr3u3vy4gciggw3@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com>
 <20180717085039.kqxwbkgruhj5qxtx@suselix>
 <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
 <20180717091152.l4ixicbp6imvqtsr@suselix>
 <CAJZ5v0hu6d26Qu1d-NRoO8RXic2ooTEfXzcmJyRGPSOsH6OznA@mail.gmail.com>
 <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717093620.ym6phfmr3rfvsxyo@suselix>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:36:20AM +0200, Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
> > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > >>
> > > >> [cut]
> > > >>
> > > >> >
> > > >> > On balance before this commit users could use pcc-cpufreq but had
> > > >> > already suboptimal performance (compared to say intel_pstate driver
> > > >> > which can be used changing BIOS options).
> > > >>
> > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
> > > >
> > > > I think this is because of (in intel_pstate_init()):
> > > >
> > > >         /*
> > > >          * The Intel pstate driver will be ignored if the platform
> > > >          * firmware has its own power management modes.
> > > >          */
> > > >         if (intel_pstate_platform_pwr_mgmt_exists())
> > > >                 return -ENODEV;
> > > >
> > > 
> > > OK, because of the "Proliant" entry, right?
> > > 
> > > So it looks like we have an issue there.  We find the entry and we
> > > look for _PSS.  It is not there, so we assume that the firmware is
> > > expected to control performance, which is not the case.

> FYI, there is another BIOS setting on those systems. It's called
> "Collaborative Power Control" (AFAIK enabled by default).
> 
> Only if this is disabled, firmware is (alone) in control of
> performance. (And of course in this case neither pcc-cpufreq nor
> intel_pstate will be loaded).

To clarify:

(i)  When "Dynamic Power Savings Mode" is enabled _PSS objects are
     missing (in fact they seem to be renamed to "XPSS").
     pcc-cpufreq driver evaluates PCCH header and loads.

     Same when "Collaborative Power Control" is disabled. No _PSS but
     XPSS objects. pcc-cpufreq driver fails to evaluate PCCH header,
     no cpufreq driver is loaded.

(ii) There are _PSS objects when "OS Control Mode" is selected.

     (But I think when "Collaborative Power Control" is disabled there
     are no _PSS objects either and the "OS Control Mode" selection
     does not matter.)

> > > It looks like we also should look for the presence of the PCC
> > > interface in there.
> > >
> > > I can provide a patch for that, will you be able to test it?
> > 
> > Yes, I can test it.
> > 
> > > >> It should be initialized before pcc-cpufreq (according to their
> > > >> respective initcall levels), so in theory intel_pstate should be used
> > > >> by default on the affected systems anyway.
> > > >
> > > >> What BIOS settings need to be changed for that?
> > > >
> > > > Already answered in other mail.
> > > 
> > > Indeed.
> > 
> > 
> > Andreas
> > 

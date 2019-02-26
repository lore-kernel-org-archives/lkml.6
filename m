Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91498C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EE4217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfBZUAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:00:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:41542 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbfBZUAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:00:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 12:00:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="323605617"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2019 12:00:14 -0800
Date:   Tue, 26 Feb 2019 11:53:27 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Xu, Tao3" <tao3.xu@intel.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/cpufeatures: Enumerate user wait instructions
Message-ID: <20190226195327.GA192131@romley-ivt3.sc.intel.com>
References: <1547673522-226408-1-git-send-email-fenghua.yu@intel.com>
 <1547673522-226408-6-git-send-email-fenghua.yu@intel.com>
 <CALCETrWCJAzRj7BUBX=O2qdHXucNWz=z0uEQ5asskTbw8CGW5w@mail.gmail.com>
 <20190221192424.GA158428@romley-ivt3.sc.intel.com>
 <3E5A0FA7E9CA944F9D5414FEC6C712209D877F3A@ORSMSX106.amr.corp.intel.com>
 <CALCETrVJsCAWYSnUE+Ju_VmZfZBUBwUq-uFjV9=Vy+wddtJVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVJsCAWYSnUE+Ju_VmZfZBUBwUq-uFjV9=Vy+wddtJVCw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 11:45:35AM -0800, Andy Lutomirski wrote:
> On Thu, Feb 21, 2019 at 2:57 PM Yu, Fenghua <fenghua.yu@intel.com> wrote:
> >
> > > From: Fenghua Yu [mailto:fenghua.yu@intel.com]
> > > On Wed, Feb 20, 2019 at 10:37:27PM -0800, Andy Lutomirski wrote:
> > > Or to simplify the situation, how about we still use zero as global max wait
> > > time (i.e. no limitation for global wait time) as implemented in this patch
> > > set? User can still change the value to any value based on their usage. Isn't
> > > this a right way to take care of any usage?
> >
> > Plus, if scheduler timers works, umwait will be forced time out by timer in HZ anyway.
> 
> Indeed.  But, on some configs, the scheduler timer intentionally will
> *not* fire.
> 
> >
> > Only for case without scheduler timer, sysadmin may need to set a small max umwait time to force timout. But in this case (real time), I doubt user app really wants to call umwait to save power with long latency of waking up from umwait. So likely in this case, user app won't call umwait and there is no usage to set a small value for max umwait time.
> 
> I don't really know why an application would use umwait at all.  About
> the only legitimate use I can think of is to treat it as a somewhat
> power-saving variant of REP NOP.  What I want to avoid is the case
> where it works dramatically differently on NO_HZ_FULL systems as
> compared to everything else.  Also, UMWAIT may behave a bit
> differently if the max timeout is hit, and I'd like that path to get
> exercised widely by making it happen even on default configs.
> 
> So I propose setting the timeout to either 100 microseconds or 100k
> "cycles" by default.  In the event someone determines that they save
> materially more power or gets materially better performance with a
> longer timeout, we can revisit the value.

OK. I will set the default umwait max time value to 100K cycles.

Thanks.

-Fenghua

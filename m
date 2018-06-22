Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D950E24962
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D950E24962
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFVWm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:42:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:38604 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeFVWmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="239849725"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2018 15:42:24 -0700
Date:   Fri, 22 Jun 2018 15:41:54 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
Message-ID: <20180622224154.GD18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-3-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806221334150.2402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806221334150.2402@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:59:44PM +0200, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Thomas Gleixner wrote:
> > The whole thing is simply:
> > 
> > handle_ac()
> > {
> > 	if (user_mode(regs)) {
> > 		 do_trap(AC, SIGBUS, ...);
> > 	} else {
> > 		disable_ac_on_local_cpu();
> > 		WARN_ONCE(1);
> > 	}
> > }
> > 
> > That wants #AC enabled as early as possible so the kernel gets as much
> > coverage as it can. If it trips in the kernel it's a bug and needs to be
> > fixed and we can them fix ONE by ONE.
> 
> That said, #AC is just yet another badly defined and hastily bolted on
> (mis)feature. This should have been:
> 
>   Bit A:	   Enable #AC if CPL < 3
>   Bit B:	   Enable #AC if CPL == 3
> 
> But that would have been too useful and would allow sensible use of #AC
> without creating software trainwrecks.
> 
> Aside of that the spec says:
> 
>   31 Disable LOCK# assertion for split locked access.
> 
> Can you pretty please make sure that this bit enforces #AC enable? If 31 is
> ever set and such an access happens then the resulting havoc will takes
> ages to decode.
> 
> That bit is also mentioned in the SDM with ZERO explanation why it exists
> in the first place and why anyone would ever enable it and without a big
> fat warning about the possible consequences. Can this pretty please be
> fixed?

The bit 31 already exits on all processors. Hardware always sets its value
as zero after power on. It has been legacy for 20 years. It was added for
one customer 20 years ago. Now Intel hardware design team doesn't expect
anyone to set the bit.

Currently Linux kernel doesn't define this bit and doesn't set this bit.

Thanks.

-Fenghua

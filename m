Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982CAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16B249AD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C16B249AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeFVXSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:18:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:18093 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbeFVXSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:18:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 16:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="61474460"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2018 16:18:43 -0700
Date:   Fri, 22 Jun 2018 16:18:13 -0700
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
Message-ID: <20180622231813.GE18979@romley-ivt3.sc.intel.com>
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

The two bits would be ideal.

So I will do SIGBUG for user and WARN/disable for kernel in the next version.

Thanks.

-Fenghua

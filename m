Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB03C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593762146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593762146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeIMAWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbeIMAWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B16B9AFC4;
        Wed, 12 Sep 2018 19:16:52 +0000 (UTC)
Date:   Wed, 12 Sep 2018 21:16:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v6 2/3] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
In-Reply-To: <alpine.DEB.2.21.1809122112480.1473@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1809122115520.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121107070.15880@cbobk.fhfr.pm> <alpine.DEB.2.21.1809122112480.1473@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Thomas Gleixner wrote:

> >  	case X86_BUG_SPECTRE_V2:
> > -		return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> > +		mutex_lock(&spec_ctrl_mutex);
> > +		ret = sprintf(buf, "%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
> >  			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
> >  			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
> > +			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
> >  			       spectre_v2_module_string());
> > +		mutex_unlock(&spec_ctrl_mutex);
> 
> The mutex for this printing is overkill. It's a read after all and if there
> is a concurrent SMT control fiddling going on then you have a chance of
> getting the wrong information as well. 

Yeah; I was just happy to be able to stick second use of it there, with 
the first one being basically useless as well :)

> I'll zap it.

Absolutely feel free to. Thanks,

-- 
Jiri Kosina
SUSE Labs


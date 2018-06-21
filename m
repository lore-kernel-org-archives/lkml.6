Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41A6C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CB22520
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1CB22520
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbeFUXFc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:05:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:31739 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933446AbeFUXFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:05:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 16:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="59940484"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2018 16:05:30 -0700
Date:   Thu, 21 Jun 2018 16:05:02 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621230501.GC18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
 <20180621221006.GC2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621221006.GC2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:10:06AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> > The control knob for firmware is to choose continuing firmware execution
> > by disabling #AC split lock (default) or stopping firmware execution
> > by enabling #AC for split lock. Stopping firmware execution may be useful
> > in hard real time system to identify any split lock issue on the platform.
> 
> Having the option only allows broken firmware to continue to exist.
> Limiting people in how they can use their machines.

But in a real case, when I enable #AC for split lock in kernel, reboot
hits #AC because of split lock in firmware code and firmware handles #AC
as fatal error and stops continuing to run.

It will take long time/forever for firmware to fix the split lock issue.
Before the firmware issue is fixed, reboot or S4 cannot run if the feature
is enabled by kernel.

And if unlucky, I'm afraid the patch set even has no chance to be merged to
upstream if maintainer's test machine has firmware split lock issue and the
machine simply cannot reboot or go to S4 if the feature is enabled.

For those reasons, the current patches just don't trust firmware and
disable #AC for split lock for firmware by default and allow sysadmin to
enable it for firmware via the control knob.

So is it ok to still keep the control knob and disable #AC for split lock
for firmware by default?

Thanks.

-Fenghua

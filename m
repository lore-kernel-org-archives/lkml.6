Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E601C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063E208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeIYNUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:20:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:38320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbeIYNUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:20:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 00:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="265474645"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2018 00:14:18 -0700
Date:   Tue, 25 Sep 2018 15:11:43 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v2 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20180925071143.GF11769@yi.y.sun>
References: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com>
 <1537514712-62434-3-git-send-email-yi.y.sun@linux.intel.com>
 <CY4PR21MB0773F63A6367C5C1CE26F5ADDC120@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR21MB0773F63A6367C5C1CE26F5ADDC120@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-21 17:02:54, Michael Kelley (EOSG) wrote:
> From: Yi Sun <yi.y.sun@linux.intel.com> Sent: Friday, September 21, 2018 12:25 AM
> > +
> > +#define pr_fmt(fmt) "hv: " fmt
> 
> Other Hyper-V messages use "Hyper-V: " as the prefix, not "hv: ".  Take
> a quick look at 'dmesg' output for reference.
> 
Will modify this. Thanks!

> > +
> > +#include <linux/kernel_stat.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/log2.h>
> > +#include <linux/gfp.h>
> 
> Some of these #includes look like they might be leftovers from
> some other code.  Please check and see whether kernel_stat.h,
> debugsfs.h, log2.h, and gfp.h are actually needed.
> 
Sure, I will check them.

> > +static void hv_qlock_wait(u8 *byte, u8 val)
> > +{
> > +	unsigned long msr_val;
> > +
> > +	if (READ_ONCE(*byte) != val)
> > +		return;
> > +
> > +	/*
> > +	 * Read HV_X64_MSR_GUEST_IDLE MSR can trigger the guest's
> > +	 * transition to the idle power state which can be exited
> > +	 * by an IPI even if IF flag is disabled.
> > +	 */
> > +	if (ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)
> 
> I can't see a case where this test is actually needed.  hv_qlock_wait()
> can only get called if the flag is set when hv_init_spinlocks() is run, and
> the flag value doesn't change after it is set.
> 
Yes, it is redundant. Will remove it.

> > +		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
> > +}
> 
> Michael

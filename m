Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5794BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A9921524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A9921524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732816AbeITHkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:40:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:33655 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeITHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:40:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 18:59:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,396,1531810800"; 
   d="scan'208";a="265074941"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2018 18:59:18 -0700
Date:   Thu, 20 Sep 2018 09:56:44 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelly@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/3] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Message-ID: <20180920015644.GE11769@yi.y.sun>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
 <1536830005-37260-3-git-send-email-yi.y.sun@linux.intel.com>
 <alpine.DEB.2.21.1809131307110.1473@nanos.tec.linutronix.de>
 <20180914090440.GB11769@yi.y.sun>
 <alpine.DEB.2.21.1809141232260.1473@nanos.tec.linutronix.de>
 <20180917125452.GC11769@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917125452.GC11769@yi.y.sun>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On 18-09-17 20:54:52, Yi Sun wrote:
> On 18-09-14 12:42:33, Thomas Gleixner wrote:
> > On Fri, 14 Sep 2018, Yi Sun wrote:
> > > > > +static void hv_notify_long_spin_wait(void)
> > > > > +{
> > > > > +	u64 input = spin_wait_info | 0x00000000ffffffff;
> > > > 
> > > > What? The result is always 0x00000000ffffffff .....
> > > > 
> > > Oh, sorry for such error.
> > > 
> > > > > +	spin_wait_info++;
> > > > > +	hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT, input);
> > > > > +}
> > > > > +
> > > > > +static void hv_qlock_kick(int cpu)
> > > > > +{
> > > > > +	spin_wait_info--;
> > > > 
> > > > Looking at the above this is completely pointless and I have no idea what
> > > > that variable is supposed to do.
> > > > 
> > > Per Microsoft Hypervisor Top Level Functional Specification, the input
> > > parameter of HVCALL_NOTIFY_LONG_SPIN_WAIT is defined as below:
> > > 
> > > SpinwaitInfo – Specifies the accumulated count the guest was spinning.
> > > 
> > > So, it is increased when guest is spinning and reduced when spinlock is
> > > released.
> > 
> > But that's a global variable, so it might be incremented and decremented by
> > several CPUs at once. I don't have the spec and have no time to study it
> > either, but global does not make any sense to me. The spin wait info comes
> > from a single guest CPU and the wakeup is targeted at that guest CPU as
> > well. So why global? It might be defined that way, but then you really want
> > to explain it proper.
> > 
> > Thanks,
> > 
> > 	tglx
> > 
> Let me check this more. Will reply to you later. Thanks!
> 
> BRs,
> Yi Sun

I have got the details from Microsoft.

Notify_Long_Spin_Wait hypercall should be called after a specific times
spinning which can be got through CPUID. When hypervisor receives this,
it will try to ensure that all vcpus are scheduled. 

Notify_Long_Spin_Wait is a standalone feature which should be split out
as a new patch set.

So I would like split it into a new patch set and submit it after PV
Hyper-V Spinlock patch set merged.

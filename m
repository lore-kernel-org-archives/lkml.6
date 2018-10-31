Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E66C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ECA2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8ECA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeJaLE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:04:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:42689 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbeJaLE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:04:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 19:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="82861110"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2018 19:08:57 -0700
Date:   Wed, 31 Oct 2018 10:06:10 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgross@suse.com" <jgross@suse.com>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181031020610.GD15378@yi.y.sun>
References: <1539954835-34035-1-git-send-email-yi.y.sun@linux.intel.com>
 <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <CY4PR21MB07737AA8E3F7E7353D42F5C8D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR21MB07737AA8E3F7E7353D42F5C8D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After syncing with Hyper-V team, we have got answers as below.

On 18-10-24 16:53:00, Michael Kelley wrote:
> From: Yi Sun <yi.y.sun@linux.intel.com>  Sent: Friday, October 19, 2018 6:14 AM
> > 
> > The HvNotifyLongSpinWait hypercall (HVCALL_NOTIFY_LONG_SPIN_WAIT)
> > is used by a guest OS to notify the hypervisor that the calling
> > virtual processor is attempting to acquire a resource that is
> > potentially held by another virtual processor within the same
> > Virtual Machine. This scheduling hint improves the scalability of
> > VMs with more than one virtual processor on Hyper-V.
> > 
> > Per MSFT TLFS, the retry number (SpinWaitInfo) is sent to hypervisor
> > only when the retry number exceeds the recommended number. If
> > recommended number is 0xFFFFFFFF, never retry.
> 
> The HvNotifyLongSpinWait hypercall should be understood to be
> advisory only.  As you noted, it is a scheduling hint to the
> hypervisor that some virtual CPU in the VM holds a spin lock.  Even
> though Linux knows which vCPU holds the spin lock, the hypercall
> does not provide a way to give that information to Hyper-V.  The
> hypercall always returns immediately.
> 
> The "retry number" is a bit mis-named in the Hyper-V Top Level
> Functional Spec (TLFS).  It is essentially a threshold value.  Hyper-V is
> saying "don't bother to advise me about the spin lock until you have
> done a certain number of spins."  This threshold prevents
> over-notifying Hyper-V such that the notification becomes somewhat
> meaningless.   It's not immediately clear to me why the hypercall passes
> that value as an input, but maybe it lets the Hyper-V scheduler prioritize
> among vCPUs based on how many times they have spun for a lock.  I
> think we were told that current Hyper-V implementations ignore this
> input value anyway.
> 
> I believe the description of the sentinel value 0xFFFFFFFF in the
> Hyper-V TLFS is incorrect.  Because it is the max possible threshold
> value, that value in the EBX register just means to not ever bother to
> notify.   The description should be "0xFFFFFFFF indicates never to notify."
> The value does *not* indicate anything about retrying to obtain the
> spin lock.
> 
You are right. 0xFFFFFFFF only indicates never to notify. We should not
break the spin loop.

> >  static bool __initdata hv_pvspin = true;
> > 
> > +bool hv_notify_long_spin_wait(int retry_num)
> 
> retry_num should probably be declared as unsigned int.  You
> don't want it to be treated as a negative number if the high
> order bit is set.
> 
Yes, thanks!

> > +{
> > +	/*
> > +	 * Per MSFT TLFS, the SpinWaitInfo is sent to hypervisor only when
> > +	 * the retry number exceeds the recommended number.
> > +	 *
> > +	 * If recommended number is 0xFFFFFFFF, never retry.
> > +	 */
> > +	if (ms_hyperv.num_spin_retry == HYPERV_SPINLOCK_RETRY_NEVER)
> > +		return false;
> > +
> > +	if ((0 == retry_num % ms_hyperv.num_spin_retry) && retry_num)
> 
> I don't know if the "%" function is right here.  Your implementation will
> notify Hyper-V on every multiple of num_spin_retry.   The alternative is to
> notify once when the threshold is exceeded, and never again for this
> particular attempt to obtain a spin lock.  We should check with the Hyper-V
> team for which approach they expect to be used.
> 
We should send the notification on every multiple of the recommended
number.

> > +		hv_do_fast_hypercall8(HVCALL_NOTIFY_LONG_SPIN_WAIT,
> > +				      retry_num);
> 
> The Hyper-V TLFS seems to be inconsistent on whether the input parameter
> is 32-bits or 64-bits.   In one place it is typed as UINT64, but in another place
> it is shown as only 4 bytes.  Need to clear this up with the Hyper-V team as
> well.
> 
It is 32-bits.

> > +
> > +	return true;
> 
> I don't see a need for this function to return true vs. false.  Any calling code
> should not change its behavior based on num_spin_retry.   This function will
> either notify Hyper-V or not notify Hyper-V, depending on whether the number
> of attempts to obtain the spinlock meets the threshold.  But calling code will
> do the same thing regardless of whether such a notification is made. 
> 
You are right. I will change it to 'void'.

> Michael

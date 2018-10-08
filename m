Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34216C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E704F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E704F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJHPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:25:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:9979 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeJHPZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:25:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 01:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="270412773"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga006.fm.intel.com with ESMTP; 08 Oct 2018 01:15:03 -0700
Date:   Mon, 8 Oct 2018 16:12:23 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        sthemmin@microsoft.com, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com
Subject: Re: [tip:x86/hyperv] x86/hyperv: Enable PV qspinlock for Hyper-V
Message-ID: <20181008081223.GG11769@yi.y.sun>
References: <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com>
 <tip-aaa7fc34c003bd8133a49f7634480cef6288ad55@git.kernel.org>
 <0005fc50-4415-87a0-1954-fb15a1f8bd0b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0005fc50-4415-87a0-1954-fb15a1f8bd0b@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-02 13:38:55, Juergen Gross wrote:
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
> 
> What if interrupts are enabled? Won't a kick happening here just
> interrupt and then the following rdmsr result in a hang?
> 
> I believe the correct way would be to:
> 
> - disable interrupts before above READ_ONCE() and restore them
>   after the rdmsrl()
> 
> - return early if in_nmi()
> 
> similar as the kvm specific variant is doing it.
> 
> 
> Juergen

Thank you for the suggestion! That is a possible case. I will submit
a new version in soon.

BRs,
Yi Sun

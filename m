Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE96C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC04217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC04217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeHVDV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 23:21:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:25777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeHVDV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 23:21:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 16:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,271,1531810800"; 
   d="scan'208";a="74643959"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2018 16:59:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8B8BE301B91; Tue, 21 Aug 2018 16:59:08 -0700 (PDT)
Date:   Tue, 21 Aug 2018 16:59:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180821235908.GW12066@tassilo.jf.intel.com>
References: <20180821211528.8575-1-eduval@amazon.com>
 <20180821220937.GV12066@tassilo.jf.intel.com>
 <20180821230522.GA10816@u40b0340c692b58f6553c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821230522.GA10816@u40b0340c692b58f6553c.ant.amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:05:22PM -0700, Eduardo Valentin wrote:
> On Tue, Aug 21, 2018 at 03:09:37PM -0700, Andi Kleen wrote:
> > On Tue, Aug 21, 2018 at 02:15:28PM -0700, Eduardo Valentin wrote:
> > > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > > and with a model not known by family PMU drivers,
> > > user gets a kernel message log like the following:
> > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > > 
> > > The "unsupported .. CPU" part may be confusing for some
> > > users. Rewording the messages on the failure path to:
> > > [ 0.667154] Performance Events: unknown p6 PMU on CPU model 85: !X86_FEATURE_ARCH_PERFMON: no PMU driver, software events only.
> > 
> > Are you sure users even know what ARCH_PERFMON is?
> > 
> > Maybe it is confusing (why exactly?), but it doesn't seem to me that your
> > new message is any better.
> 
> Yeah, the part that says "unsupported CPU" is the confusing part,

That makes sense.

> I get people thinking that the specific reported CPU model is not
> supported by the kernel :-)
> 
> > 
> > If you refer to VMs not exposing the PMU perhaps that should be explicitely mentioned.
> > 
> > Of course the real fix is to always expose the PMU, not improve the error messages...
> 
> I agree that best is simply to enable PMU. But it does not hurt to improve the error messaging, does it?
> 
> Any suggestions there, given that the initial attempt seams to make it even worse :-)

Perhaps just say

"CPU does not support PMU"

which is really what the problem is here.

The other option would be to move this message after the big model switch,
but would need to be very careful that it doesn't have any unintended
side effects. 

-Andi

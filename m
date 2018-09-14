Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF46FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036792086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gjfAVmVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036792086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeINFMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 01:12:43 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:3866 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeINFMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 01:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1536883256; x=1568419256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OFWloyO2g1TgyImSaHJqrt3pC/wHYmXCjI84dkMpiu8=;
  b=gjfAVmVhFPPQ9sbWhnljdHniis/xI9Mk3rjL+zcI2QsLIQccjpFY1vP3
   IJdv8sPnFwhNimvv9QZQpKuN8MHXxmlM23GwbYQkcSDT146tBh1WPSfBu
   vbJ5YFiU41PKmsQLYyVVjXTQmzJLH6gtevm2H6xBI9IuUgoTJMdXap81I
   Y=;
X-IronPort-AV: E=Sophos;i="5.53,371,1531785600"; 
   d="scan'208";a="357071189"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 00:00:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8E00nTM045399
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Sep 2018 00:00:51 GMT
Received: from EX13D05UWB001.ant.amazon.com (10.43.161.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 00:00:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB001.ant.amazon.com (10.43.161.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 00:00:50 +0000
Received: from localhost (10.55.160.43) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Sep 2018 00:00:50 +0000
Date:   Thu, 13 Sep 2018 17:00:50 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andi Kleen <ak@linux.intel.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Jia Zhang" <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180914000050.GI16020@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180823150732.11249-1-eduval@amazon.com>
 <20180905085212.GS24124@hirez.programming.kicks-ass.net>
 <20180905155317.GA20320@u40b0340c692b58f6553c.ant.amazon.com>
 <20180905214707.GM27886@tassilo.jf.intel.com>
 <20180906072149.GE24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180906072149.GE24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

On Thu, Sep 06, 2018 at 09:21:49AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 05, 2018 at 02:47:07PM -0700, Andi Kleen wrote:
> > On Wed, Sep 05, 2018 at 08:53:17AM -0700, Eduardo Valentin wrote:
> > > On Wed, Sep 05, 2018 at 10:52:12AM +0200, Peter Zijlstra wrote:
> > > > On Thu, Aug 23, 2018 at 08:07:32AM -0700, Eduardo Valentin wrote:
> > > > > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > > > > and with a model not known by family PMU drivers,
> > > > > user gets a kernel message log like the following:
> > > > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > > > > 
> > > > > The "unsupported .. CPU" part may be confusing for some
> > > > > users leading to wrong understanding that the kernel
> > > > > does not support the CPU model.
> > > > 
> > > > Send them back to first grade, such that they might learn to read?
> > > > 
> > > 
> > > :-)
> > 
> > I think it's a valid concern, I guess Eduardo actually has real people
> > who got confused.
> 
> But it is really easy to confuse real people; as real people are mostly
> clueless.  There is only so much you can do for the semi illiterate
> masses. Should we dumb down everything to baby talk just to cater to
> them?
> 
> The string is clearly prefixed by the subsystem, if you get confused by
> that your reading comprehension really is rock bottom.
> 
>   [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> 

Once again, the confusing part is the "unsupported CPU".

> Heck, it even mentions "no PMU driver", how much clues do you need?
> Also, the proposed alternative:
> 
>   [ 0.667154] Performance Events: CPU does not support PMU: no PMU driver, software events only.
> 
> Looses out information on which CPU family we failed on. Nor does it


Maybe keeping the CPU family and rephrasing the unsupported part?

> mention the most likely reason for this error: virt crap.
> 
> I'd not mind a warning like:
> 
>   [] Performance Events: Your crappy virt solution is lying about it's CPU model, it doesn't have a (matching) PMU.
> 

Well, I would be OK if the kernel spits out a message saying that vPMU is disabled or something.
That would be more accurate than unsupported CPU.

> 
> 

-- 
All the best,
Eduardo Valentin

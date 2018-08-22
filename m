Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A570208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fZwsdkaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A570208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeHWAXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:23:42 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:51149 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeHWAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1534971433; x=1566507433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zQ9PhjyQopjQ/c9sxh+lXJJS7x+awHkBruSQZ/TNQ9Y=;
  b=fZwsdkaR2/UIPuTBLi2aa2MRXUMu38BrYOixAlffYwl0PaRa3VVDd2qT
   QnXvkeyKErf0Cos8GVQc7o+tMK7Zj/Zq5MlcZbM+QcYzLYYMHa1ofgbiG
   yMV54azhjl9AcsfPqTlhBHBaysIr9umRWah1FZKEUUqf1eOMxg19UGNua
   U=;
X-IronPort-AV: E=Sophos;i="5.53,275,1531785600"; 
   d="scan'208";a="353483326"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2018 20:57:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7MKv2ab049996
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 22 Aug 2018 20:57:08 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 20:57:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 22 Aug 2018 20:57:07 +0000
Received: from localhost (10.55.160.46) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 22 Aug 2018 20:57:07 +0000
Date:   Wed, 22 Aug 2018 13:57:07 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf/x86/intel: make error messages less confusing
Message-ID: <20180822205707.GA16015@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180821211528.8575-1-eduval@amazon.com>
 <20180821220937.GV12066@tassilo.jf.intel.com>
 <20180821230522.GA10816@u40b0340c692b58f6553c.ant.amazon.com>
 <20180821235908.GW12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180821235908.GW12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Tue, Aug 21, 2018 at 04:59:08PM -0700, Andi Kleen wrote:
> On Tue, Aug 21, 2018 at 04:05:22PM -0700, Eduardo Valentin wrote:
> > On Tue, Aug 21, 2018 at 03:09:37PM -0700, Andi Kleen wrote:
> > > On Tue, Aug 21, 2018 at 02:15:28PM -0700, Eduardo Valentin wrote:
> > > > On a system with X86_FEATURE_ARCH_PERFMON disabled
> > > > and with a model not known by family PMU drivers,
> > > > user gets a kernel message log like the following:
> > > > [ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.
> > > > 
> > > > The "unsupported .. CPU" part may be confusing for some
> > > > users. Rewording the messages on the failure path to:
> > > > [ 0.667154] Performance Events: unknown p6 PMU on CPU model 85: !X86_FEATURE_ARCH_PERFMON: no PMU driver, software events only.
> > > 
> > > Are you sure users even know what ARCH_PERFMON is?
> > > 
> > > Maybe it is confusing (why exactly?), but it doesn't seem to me that your
> > > new message is any better.
> > 
> > Yeah, the part that says "unsupported CPU" is the confusing part,
> 
> That makes sense.
> 
> > I get people thinking that the specific reported CPU model is not
> > supported by the kernel :-)
> > 
> > > 
> > > If you refer to VMs not exposing the PMU perhaps that should be explicitely mentioned.
> > > 
> > > Of course the real fix is to always expose the PMU, not improve the error messages...
> > 
> > I agree that best is simply to enable PMU. But it does not hurt to improve the error messaging, does it?
> > 
> > Any suggestions there, given that the initial attempt seams to make it even worse :-)
> 
> Perhaps just say
> 
> "CPU does not support PMU"
>

Ok.
 
> which is really what the problem is here.
> 

Fair enough.

> The other option would be to move this message after the big model switch,
> but would need to be very careful that it doesn't have any unintended
> side effects. 

I will simply remove those messages with CPU model details and on
the failure path build the message to look like:
[    0.666785] Performance Events: CPU does not support PMU: no PMU driver, software events only.


> 
> -Andi
> 

-- 
All the best,
Eduardo Valentin

Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A64ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182ED206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182ED206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeINToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:44:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:52481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINToq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:44:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 07:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,373,1531810800"; 
   d="scan'208";a="232910534"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2018 07:27:33 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8A5BD301376; Fri, 14 Sep 2018 07:27:33 -0700 (PDT)
Date:   Fri, 14 Sep 2018 07:27:33 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel-owner@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
Message-ID: <20180914142733.GB27886@tassilo.jf.intel.com>
References: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
 <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
 <20180914085409.GA27886@tassilo.jf.intel.com>
 <529b2498-0515-e33c-ebcc-af2a5ca7d974@linux.intel.com>
 <b82d59b2-71bf-2c91-869c-0068760c9ed3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82d59b2-71bf-2c91-869c-0068760c9ed3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 08:39:36AM -0400, Liang, Kan wrote:
> 
> 
> On 9/14/2018 5:22 AM, Alexey Budankov wrote:
> > 
> > Hi Andi,
> > 
> > On 14.09.2018 11:54, Andi Kleen wrote:
> > > > > In principle the LBRs need to be flushed between threads. So does
> > > > > current code.
> > > > 
> > > > IMHO, ideally, LBRs stack would be preserved and restored when
> > > > switching between execution stacks. That would allow implementing
> > > > per-thread statistical call graph view in Perf tools, fully based
> > > > on HW capabilities. It could be advantageous for some cases, in
> > > > comparison with traditional dwarf based call graph.
> > > 
> > > This is already supported when you use LBR call stack mode
> > > (perf record --call-graph lbr)
> > 
> > Which kernel versions does it make sense to try?
> > 
> 
> The optimization for LBR call stack has been merged into 4.19.
> commit id: 8b077e4a69bef5c4121426e99497975860191e53
> perf/x86/intel/lbr: Optimize context switches for the LBR call stack

I think he mean support for LBR call stack in general. This has been there 
for a long time (since Haswell) Any reasonable kernel version should
support it.

The commit Kan pointed out just optimize it for cases when it is not
needed, like switch to kernel, because we only use LBR call stack
for ring 3.

-Andi

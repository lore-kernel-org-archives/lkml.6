Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F0BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAA20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DAA20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeINOHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:07:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:52469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINOHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:07:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 01:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="257194662"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2018 01:54:09 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 74EB4301376; Fri, 14 Sep 2018 01:54:09 -0700 (PDT)
Date:   Fri, 14 Sep 2018 01:54:09 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     linux-kernel-owner@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel/lbr: Optimize context switches for LBR
Message-ID: <20180914085409.GA27886@tassilo.jf.intel.com>
References: <1536869331-63561-1-git-send-email-kan.liang@linux.intel.com>
 <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dec78c67-0631-c4a7-95e1-4b931ce9ecd7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In principle the LBRs need to be flushed between threads. So does
> > current code.
> 
> IMHO, ideally, LBRs stack would be preserved and restored when 
> switching between execution stacks. That would allow implementing 
> per-thread statistical call graph view in Perf tools, fully based 
> on HW capabilities. It could be advantageous for some cases, in 
> comparison with traditional dwarf based call graph. 

This is already supported when you use LBR call stack mode
(perf record --call-graph lbr)

This change is only optimizing the case when call stack mode is not used.

Of course in call stack mode the context switch overhead is even higher,
because it not only writes, but also reads.

-Andi

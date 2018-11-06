Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5667EC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2545F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeKFJc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:32:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:46280 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeKFJc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:32:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 16:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="101784857"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 05 Nov 2018 16:10:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D17B730508C; Mon,  5 Nov 2018 16:10:37 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:10:37 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181106001037.GQ6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3799078.YBnU1OB0PF@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > - PMU triggers interrupt and PEBS stores RIP etc.
> > > - code continous to execute, possibly changing the stack
> > 
> > I dont think the code continues to execute.. the stack is ok
> 
> Are you sure about this? I mean, isn't that the whole reason why we need PEBS? 
> Generally, if you are sure about this, can you point me to some documentation 
> on this to allow me to understand it better?

Milian is right.

There is a execution window from PEBS capturing registers to actually triggering
the PMU, and if there is stack manipulation in that window
the PEBS state might be out of sync with the real stack.

The right RIP/RSP to use for the stack unwinding is always the data
in the PMI's exception frame on the stack.

Probably would need to modify perf to report those too in addition
to the PEBS registers.

Of course it would still mean that the stack unwinding may not exactly
match the sample RIP, but at least it should be consistent.

-Andi

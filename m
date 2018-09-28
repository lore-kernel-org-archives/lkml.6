Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C34C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5141F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeI2DMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:12:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:1537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeI2DMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:12:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 13:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="76963986"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 28 Sep 2018 13:45:56 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A2AF0300B51; Fri, 28 Sep 2018 13:45:56 -0700 (PDT)
Date:   Fri, 28 Sep 2018 13:45:56 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928204556.GB32651@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <e89ec139-1a97-803e-343c-76eedf244d65@linux.intel.com>
 <alpine.DEB.2.21.1809281542180.2004@nanos.tec.linutronix.de>
 <0feb9867-0040-0306-a95b-4b6df1818312@linux.intel.com>
 <alpine.DEB.2.21.1809281932040.1432@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809281932040.1432@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Right now we have a single knob, which is poorly documented and that should
> be fixed first. But some googling gives you the information that allowing
> unprivilegded access is a security risk. So the security focussed sysadmin

Ah only if google could simply answer all our questions!

> will deny access to the PMUs no matter what.

It's not like there is or isn't a security risk and that you
can say that it is or it isn't in a global way.

Essentially these are channels of information. The channels always exist
in form of timing variances for any shared resource (like shared caches
or shared memory/IO/interconnect bandwidth) that can be measured.

Perfmon counters make the channels generally less noisy, but they do not cause
them.

To really close them completely you would need to avoid sharing
anything, or not allowing to measure time, neither of which is practical
short of an air gap.

There are reasonable assesments you can make either way and the answers
will be different based on your requirements. There isn't a single
answer that works for everyone. 

There are cases where it isn't a problem at all.

If you don't have multiple users on the system your tolerance
should be extremely high.

For users who have multiple users there can be different tradeoffs.

So there isn't a single answer, and that is why it is important
that this if configurable.

-Andi


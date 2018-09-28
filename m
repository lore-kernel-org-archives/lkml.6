Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B52C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579F20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2579F20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeI1Xs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:48:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:19238 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeI1Xs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:48:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 10:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="77203532"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2018 10:23:40 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9A539300B51; Fri, 28 Sep 2018 10:23:40 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:23:40 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        LKML <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928172340.GA32651@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There's also been prior discussion on these feature in other contexts
> (e.g. android expoits resulting from out-of-tree drivers). It would be
> nice to see those considered.
> 
> IIRC The conclusion from prior discussions (e.g. [1]) was that we wanted
> finer granularity of control such that we could limit PMU access to
> specific users -- e.g. disallow arbitrary android apps from poking *any*
> PMU, while allowing some more trusted apps/users to uses *some* specific
> PMUs.
> 
> e.g. we could add /sys/bus/event_source/devices/${PMU}/device, protect
> this via the usual fs ACLs, and pass the fd to perf_event_open()
> somehow. A valid fd would act as a capability, taking precedence over
> perf_event_paranoid.

That sounds like an orthogonal feature. I don't think the original
patchkit would need to be hold up for this. It would be something
in addition.

BTW can't you already do that with the syscall filter? I assume
the Android sandboxes already use that. Just forbid perf_event_open
for the apps.

-Andi


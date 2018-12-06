Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE86214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE86214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLFPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:44:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:44:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75A6C30DDBC5;
        Thu,  6 Dec 2018 15:44:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6BAF56C1FC;
        Thu,  6 Dec 2018 15:44:26 +0000 (UTC)
Date:   Thu, 6 Dec 2018 16:44:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
Message-ID: <20181206154425.GA21381@krava>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air>
 <20181205124538.GA19343@krava>
 <20181205163838.GA3836@krava>
 <alpine.DEB.2.21.1812051208580.29892@macbook-air>
 <20181205183326.GE3836@krava>
 <alpine.DEB.2.21.1812061033180.2368@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812061033180.2368@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Dec 2018 15:44:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:35:28AM -0500, Vince Weaver wrote:
> On Wed, 5 Dec 2018, Jiri Olsa wrote:
> 
> > On Wed, Dec 05, 2018 at 12:11:19PM -0500, Vince Weaver wrote:
> > > On Wed, 5 Dec 2018, Jiri Olsa wrote:
> > > 
> > > > On Wed, Dec 05, 2018 at 01:45:38PM +0100, Jiri Olsa wrote:
> > > > > On Tue, Dec 04, 2018 at 10:54:55AM -0500, Vince Weaver wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > I was able to trigger another oops with the perf_fuzzer with current git.
> > > > > > 
> > > > > > This is 4.20-rc5 after the fix for the very similar oops I previously 
> > > > > > reported got committed.
> > > > > > 
> > > > > > It seems to be pointing to the same location in the source as 
> > > > > > before, I guess maybe triggered a different way?
> > > > > 
> > > > > nice.. yep, looks the same
> > > > > 
> > > > > > 
> > > > > > Unfortunately this crash is not easily reproducible like the last one was.
> > > > > 
> > > > > will check
> > > > 
> > > > what model are hitting this on?
> > > 
> > > Haswell.  6/60/3.
> > > 
> > > While I can't deterministically trigger this, the fuzzer usually hits it
> > > within an hour or two.  Is there any debug or printk messages I can
> > > add that would help figure out what's going on?
> > 
> > I can't see how we could end up with that config other than
> > some corruption.. the only way I see could be that we touch
> > cpu->events array without checking its active_mask bit
> > 
> > but that does not explain why the crash happened in the same
> > place as before
> 
> Maybe it is a corruption issue.  I had applied my own debug patch that 
> would dump some info if data->callchain was NULL.
> 
> But my debug code didn't trigger this time because it looks like 
> data->callchain was "1" rather than "0".
> 
> [27764.840179] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> [27764.840179] PGD 0 P4D 0 
> [27764.840180] Oops: 0000 [#1] SMP PTI
> [27764.840180] CPU: 1 PID: 18687 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #125
> [27764.840180] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014

actually, you could try that patch from my previous email?

thanks,
jirka

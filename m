Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D2AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA67208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt67o6FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA67208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeK0Xdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbeK0Xds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:48 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3415214F1;
        Tue, 27 Nov 2018 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322160;
        bh=DGI/ccSioq583E+qajWCYDWxSOCUVST0oK6kbutEZqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt67o6FRonBIAsvExrItmlKkXJY+jyJrlwMSYaLUJXWWGPkvt4zoNAJ5NHEZt+Cct
         PwEq+qmWrJRIeM0w3vMpWy32BpUI0mxkvBJw4iTzcYng0iRN9pZmkA9uQmjFhPDuR7
         rq0nfdvUgJqJhL4oxpSdAPWmLRgIMNNCoEcSLXs8=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 511834111D; Mon, 26 Nov 2018 12:27:26 -0300 (-03)
Date:   Mon, 26 Nov 2018 12:27:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Message-ID: <20181126152726.GA5518@kernel.org>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
 <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
 <20181126145004.GO2113@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126145004.GO2113@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 26, 2018 at 03:50:04PM +0100, Peter Zijlstra escreveu:
> Now, I'm not saying this patch set is useless; but I'm saying most
> people should not need this, and it is massive overkill for the needs of
> most people.

So, the comparision is sort of with kernel modules, that can come and go
while you're profiling/tracing, if that happens, then samples, in post
processing, are not resolvable, and that is the case for kernel modules
right now. Sure, you're right, that doesn't happen so frequently, so
nobody hollered (thankfully that is now verbotten ;-)) at us so far.

You need to have the load-kernel-bin/unload-kernel-bin events recorded,
and you need to somehow match those addresses to some symtab/src(for
people that want to have src mixed up with assembly) and you need that
jitted code, with timestamps of when it was loaded and it was unloaded.

People doing post processing analysis of weird problems need all those
details.

Now I don't know how frequently those binary blobs gets loaded/unloaded
in the brave new world of eBPF, but for completeness sake, we need those
load/unload events and we need to grab a copy of the raw jitted binary,
etc.

- Arnaldo

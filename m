Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62219ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CDA20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7k/pKwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CDA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeJ0DQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJ0DQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:16:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3117020848;
        Fri, 26 Oct 2018 18:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540579088;
        bh=7xnAamRb1BqS3LPH+pN93yAoPOEnz578jiiNWDaMYM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7k/pKwnjCTngQxilg9/rZYEMnhzmXEonZs4p3or2lbDHr0uCmicSuzmvrQpz7tIt
         5+ARXgkrlNiGjYOFYyW4FGXubp8ZltfbvJZwmUdCAGDf8/s7iPWZDB7+6/bN1Vh++J
         OATnt89gY5Ouoy6cqr03NgPRIsx8TlGxPZtH5otE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C7739142C5F; Fri, 26 Oct 2018 15:38:05 -0300 (-03)
Date:   Fri, 26 Oct 2018 15:38:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: A concern about overflow ring buffer mode
Message-ID: <20181026183805.GD3353@kernel.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026.104513.2239058788450235574.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addind a few folks to the CC list, Wang implemented the backwards ring
buffer code.

Em Fri, Oct 26, 2018 at 10:45:13AM -0700, David Miller escreveu:
> Since the last time I looked deeply into perf I notice that
> perf top now uses a new ring buffer mode by default.
> 
> Basically, events are written in reverse order, and when fetching
> events the tool uses an ioctl to "pause" the ring buffer.
> 
> I understand some of the reasons for pursing this kind of scheme but I
> think there may be a huge downside to this design.
> 
> Yes, if the tool can't keep up with the kernel, we'd rather see newer
> rather than older events.
> 
> However, pausing the ring buffer during the fetch is going to
> virtually guaratee that we lose critical events that impact
> interpretation of future events in a non-recoverable way.
> 
> The thing is, the new scheme causes events to be lost even if the tool
> can keep up with the kernel.
> 
> Any event that happens while the tool is fetching the ring entries
> will be lost forever.  The kernel simply skips queuing up the event
> and increments a lost counter.  During a kernel build, I typically see
> 9 or so events lost each fetch.
> 
> Ok, if this is just a SAMPLE then fine, it's not a big deal.
> 
> But what if the lost event is a FORK or an EXEC or the worst one to
> lose, an MMAP?

Right, we can't lose those, so for using this, we need something like
the intel_pt tooling code does, i.e. add an extra event to the mix, a
software event, "dummy", that then gets used to track just the
PERF_RECORD_!SAMPLE metadata events and then this one never gets paused.

The intel pt motivation is different, but the technique perhaps will
allow for using the backward code while not losing metadata events.

wdyt? Wang?

- Arnaldo
 
> Now we can't even match up events properly and we get tons of those
> dreaded "Unknown" symbols and DSOs.  The output looks terrible and the
> tool becomes useless.
> 
> And yes this happens frequently.
> 
> I think the overwrite ring buffer mode should be seriously
> reconsidered.  The "I'd rather see new than old events" part is fine,
> but the "pause" part is not.  You can't turn event recording off on

> the kernel side while you fetch some events, because it means that
> critical events that allow us to properly interpret future events will
> be lost.

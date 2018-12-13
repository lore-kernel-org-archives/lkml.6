Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD94C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED65920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8lWDLMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED65920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeLMKFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:05:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YBeeqTd12/azfcgbMg0da5T4t/CPIDB12EmV7eINdMs=; b=J8lWDLMWgNMG5iPAa9sXwWBr9
        7J3MxM+rDZLuOpNLkuHET+66iOghUrdU7fJWedrhRNmW5NCgCBtj69DIQAYVgsS6rl84y/wq5tC16
        Q/JdU0qm8PPE4f1/Mivxz+55igg4sxmxKDpU5GqwXJ7hAxcQlc6sR2m4uXdGJzUOXEPFysYdMVEAM
        9rbZFZLPcRXkEOckupN5zUWPoZOkZEcAZFHakzoK1rI+seNxAIIVCTobin7qy84HSSz70o1FbaAuJ
        gFuVGHXDtSlWHNupF4N0Ug16smd+wP9pULw4FDYk9Zk77QJRk40TNwt2BVowlLo5+UPAYk3P0NYpY
        PvyFqxDyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXNrz-0007hE-O7; Thu, 13 Dec 2018 10:05:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48C6D207261ED; Thu, 13 Dec 2018 11:05:25 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:05:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181213100525.GB5307@hirez.programming.kicks-ass.net>
References: <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
 <20181213003938.GD24195@altlinux.org>
 <20181212202639.1978ec88@vmware.local.home>
 <20181213100149.GF5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213100149.GF5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:01:49AM +0100, Peter Zijlstra wrote:
> One, very big maybe, would be to add a new tracepoint type that includes
> a might_sleep() and we very carefully undo all the preempt_disable and
> go sleep where we should. That also gives the tracepoint crud the
> information it needs to publish the capability to userspace.

Note that this includes handling fun things like the buffer getting
closed while we wait.

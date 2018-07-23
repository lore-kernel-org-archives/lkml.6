Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591AD20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJrshOPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591AD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbeGWQwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:52:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbeGWQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o5Bugp841NREIV4/ykjwr6H1MLopdgd+Q8++SdaZpzs=; b=fJrshOPbu8q9oNDx0zQkpZj29
        X+z9ETw2fV30unKND65DdiWRr2Q9xk4pVlXk/aRy0gf6DwChu4hl4KNynjyRNnWo/27H0+uVoqnul
        JlS3fXelM06rqMB8Fs1vXkQeDcuVV+XOFnel7nsXYzk/lr0hqZX1ckMVdPdXgv5zptiMp0moCWeLu
        S/Yk0y0l2mM//eGna6x/SGRn6OggngUkf/8vkD+BJl2Opu+sFwTBNAFukWi+72WMt+MbLGE0KscgX
        l3viIKiL42QZrhNYPPpn5jOglPwyt8+ij1o/RoVIiCD4QoX7zfGTcY6XcqU59H0ksyie1zFV/iQ7f
        pAl//bISw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhd6x-00084o-0z; Mon, 23 Jul 2018 15:50:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 959382026873F; Mon, 23 Jul 2018 17:50:56 +0200 (CEST)
Date:   Mon, 23 Jul 2018 17:50:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com
Subject: Re: [PATCH 1/4] x86/perf/intel: Introduce PMU flag for Extended PEBS
Message-ID: <20180723155056.GF2494@hirez.programming.kicks-ass.net>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
 <20180723151603.GC2458@hirez.programming.kicks-ass.net>
 <8e17eba6-6fed-f283-ee33-47db333398e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e17eba6-6fed-f283-ee33-47db333398e2@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:43:56AM -0400, Liang, Kan wrote:
> > So I like PEBS_ALL.. what I don't like is that it seems to be mutually
> > exclusive with PEBS Load Latency.
> 
> Right, MSR_PEBS_ENABLE:32-35 is model specific.

Doesn't mean they couldn't have avoided conflicting bits.

> For Atom,
>   Goldmont and earlier platform, they are reserved.
>   Goldmont Plus, 32-34 are for fixed counter, 35 is reserved.
> For Core,
>   from Nehalem to latest 8th, 32-35 are for Load Latency.

Seems rather unfortunate to me. Because PEBS_ALL is good, but since they
took conflicting bits, we'll have yet another variant when/if (I hope
they do) they bring it to Core :/



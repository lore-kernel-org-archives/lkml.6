Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71605208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnvuqsWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71605208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeHGAlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:41:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbeHGAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZDeQV45wBPGxf9IX1oHSM0bvRICXX//DmgOYyUTSZJo=; b=rnvuqsWwe1LDtrJpq9hYmRNwN
        nycAY/M0LnakmDY+jwqumtJIiY1XS9p/cgOJ2Agbhhllsz7Zsjt7TVLZ7vX7ADBFtabYVek3EV183
        eSEComPBG+Rb/5K+4oNwO/NvYqeHRVKNeS7LLltYAlmFIzfO0r1Xu/MF/DV1K0SKSBXE9mUCtUEaI
        OfiA2/SVUqLXZQE9be9j/R4VLZu9kdh99TNdSoqXKGp4dEzjFlSmUwHFT+dHYNZ70eQ+hbUI28qTU
        pVm7pjfVHhh4fYzRPU8q+tse6zKQr82YGejMz0h4aDzL4TGRZM0Ok+LXP33Rjrs1/r1q1C3t7yUOr
        cKqaKM8Ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmo0v-0004Rz-GK; Mon, 06 Aug 2018 22:30:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B91E2058A228; Tue,  7 Aug 2018 00:30:08 +0200 (CEST)
Date:   Tue, 7 Aug 2018 00:30:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fubo Chen <fubo.chen@gmail.com>
Cc:     jpoimboe@redhat.com, Ingo Molnar <mingo@kernel.org>,
        bhole_prashant_q7@lab.ntt.co.jp,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries
 (mk-II)
Message-ID: <20180806223008.GW2494@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
 <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
 <CAJAFBLDtRUwYhMaOrgHer4eTvjWL2jC-fy0GGv+Pjd8q3wgywA@mail.gmail.com>
 <20180806154235.GO2494@hirez.programming.kicks-ass.net>
 <CAJAFBLCt574QmeP5N9D-d+Sc67BWQ5E2C=LhqFVvUpchC4O3PQ@mail.gmail.com>
 <20180806180423.GC2476@hirez.programming.kicks-ass.net>
 <CAJAFBLA2WigOMxuWXxZvHVwuGtvYr3_b4gpNbdGzry-=AVxjqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAFBLA2WigOMxuWXxZvHVwuGtvYr3_b4gpNbdGzry-=AVxjqA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:28:18PM -0700, Fubo Chen wrote:
> Do you think the patch below is sufficient to suppress the sparse warning?

Why would I want to make the code ugly to supress it?

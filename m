Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA87C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA4720869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJ1FqehN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA4720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeIDLep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:34:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46228 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDLeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tjQr0loCECd7Hf5Qij1AnOaRFEaLe98L3QErOMYKV2E=; b=jJ1FqehNdx7Azhn4G1EmvUrQk
        7NUIkaFQo2Tq4296Ih9eWeHRU8j3KzWz+eRWMPsDEFWjJp/wJlCrWyqwwDR7LPlFAYO4LH4fEAukM
        IlS07Od5NgriNQdwM9MT53H4c6xPvE7KHEgF+zJWP3sXW0gSkkIc3lLyom0I8sfJN5czHF2hK3hCb
        uWO7DbimJjZ5FWi3oYZjUrvJwd8NDcTjCga7kJH0XBGi26HONfR3EOKmGaWI57sMWL4RS49eGvDuI
        Xff3/jM7xq320fEcKwJQfl0TLzs5ca4+FOM8XPOjTUNSNXQCrh45KyiJ/S7LpAzIyNEiSS6/2NM2M
        FbtKYmh/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fx5UC-0004oG-Ks; Tue, 04 Sep 2018 07:10:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEBD5203C09CE; Tue,  4 Sep 2018 09:10:49 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:10:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904071049.GY24124@hirez.programming.kicks-ass.net>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 07:45:48PM -0700, Stephane Eranian wrote:
> Hi Arnaldo, Jiri,
> 
> A few weeks ago, you had asked if I had more requests for the perf tool.

I have one long standing one; that is IP based data structure
annotation.

When we get an exact IP (using PEBS) and were sampling a data related
event (say L1 misses), we can get the data type from the instruction
itself; that is, through DWARF. We _know_ what type (structure::member)
is read/written to.

I would love to get that in a pahole style output.

Better yet, when you measure both hits and misses, you can get a
structure usage overview, and see what lines are used lots and what
members inside that line are rarely used. Ideal information for data
structure layout optimization.

1000x more useful than that c2c crap.

Can we please get that?



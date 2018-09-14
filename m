Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFBECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47E020881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cceObBz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47E020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeINQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:29:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EDqV7I68fZIzt+sf0o3AMGjwVBQHajms74yT5v7MaAM=; b=cceObBz0hdtGSVG4vsztaXk52
        mFp8udfc1VRMj9UIvUOfN29zPSJWdmDODAGAt+4aLMLao1tKbrLzaN0AdSg4TGPHVqJGlIpwx5/ci
        fP0HMSVUc89lvpm0HIHJnt5SDA6FDPJ583XKXpUw4YCVVOLZ9Q5THm2fEk0C1HKtB0cpkTYNcXGDj
        zaLZRiV5JzTPIwXOFVhdTULFbiCrsqKWLab0vCZaBiQ3l55BMIiUZY0gtL7bJtGH50C9tEbknUbij
        o0E8V6GT+NK1quy3Lvm5WJ2nbeQdvEy4HhuS6r6DTJQaOMrrN6puVlYqEEUvDOT0BjwSsXM8s41C3
        +kun5aSnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0m4P-00028m-KB; Fri, 14 Sep 2018 11:15:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68E8D202C1A09; Fri, 14 Sep 2018 13:15:28 +0200 (CEST)
Date:   Fri, 14 Sep 2018 13:15:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914111528.GH24124@hirez.programming.kicks-ass.net>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
 <20180914094022.GB96351@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914094022.GB96351@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 11:40:22AM +0200, Ingo Molnar wrote:
> In fact keeping the files separate has scalability advantages for 'perf report' and similar 
> parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
> beginning.

Also writing to different files from different CPUs is good for record,
less contention on the inode state (which include pagecache).

Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A370BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528C920852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YjnK6m/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528C920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934853AbeFRKvM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeFRKvL (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HvvtE0oL6ZXY644p24VNzVtN62SiRSsos2ZZ3Q2Dpdw=; b=YjnK6m/NKzfw5PkWcpxC2bCWX
        R0cjzoOz7HvwIjHOuXtYHHa2x6Mc2Baas4ex+qioEkcwK7yXl/ree7KA2vivjmN+qV8fJo0+WhtuD
        Kzl1t8otx/C1I5k4T/8D7WlrWDi6AT1DlDC2O4N9+bJqmX/5ua24ufiO3I/VI9Zy2Rz/8aeO3J4Tg
        IRSXw9W1DQmCARZ+lbvlT6XfwZuCzC07hRDnq4OIAQpJHC2u2KqxSsbZFUCH/Grsr9CdudKUkGSoi
        6vatP6j5ARON3okDCRjDT/vNWgM/H+6wWxFlFVODKRZol1gmo7nzD1pBEmpC6n+eSo00JXJkbOjuQ
        SaSf8dqfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUrkW-0001SI-MK; Mon, 18 Jun 2018 10:51:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C85B52029FA11; Mon, 18 Jun 2018 12:51:02 +0200 (CEST)
Date:   Mon, 18 Jun 2018 12:51:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, yao.jin@linux.intel.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Linux Kernel Mailing List <Linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Will Deacon <will.deacon@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf/core: Use sysctl to turn on/off dropping
 leaked kernel samples
Message-ID: <20180618105102.GJ2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <1529057003-2212-2-git-send-email-yao.jin@linux.intel.com>
 <20180615113608.6m74sm7gpl5p6oqe@lakrids.cambridge.arm.com>
 <CA+55aFwRC6gszsHsGcOonV5SHDb7SxWKWbMQsTZ7KD85G_SnLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwRC6gszsHsGcOonV5SHDb7SxWKWbMQsTZ7KD85G_SnLQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 10:27:27AM +0900, Linus Torvalds wrote:
> On Fri, Jun 15, 2018 at 8:36 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > At least for sampling the GPRs, we could do something like below
> > unconditionally, which seems sufficient for my test cases.
> 
> Ack.
> 
> The PEBS case may need checking, but maybe PEBS doesn't even have this issue?

Sadly PEBS is susceptible as well, but the proposed patch actually works
for that as well.

Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB166ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ECD20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKW+PrfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ECD20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJYIxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:53:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42806 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeJYIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=adEBDHKYdQvd4UOGGDtM5RwesL4q02oJi3yLtZBTT/s=; b=WKW+PrfWXilIeIzhMkYGTp0Sj
        w3/xVuICRsX3/3lvoTqh+2TALTM2Q06BVjsRi7D5/66RRWaRozhzLSM9MEj/BXz+loWSGW75YMnhK
        vzSYhcleqPmLos9HTWL+4jentiW4bqlOGkBXboGzqm/3ncg+kI8umrkfOc+bFEsRdKQUipvkVVaDx
        Ba6pqhNCPtQsJGaRkyYxNPpuxUBPRGN0WYApm8EZsoi3xflLGluvd3Ks4shnl4s0fHrFy/kfw6CyI
        CO6D70JXtDmrUnBTUx1lQVd53Q3n1iz2M9ln/WHtKPgCKg0NWI1uKFabidNmNnqS4e6XlZyB3eIVe
        fCsPMOB6w==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFTQl-0002Sa-2k; Thu, 25 Oct 2018 00:23:19 +0000
Received: by worktop (Postfix, from userid 1000)
        id 911626E0675; Thu, 25 Oct 2018 02:23:12 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:23:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181025002312.GS3109@worktop.c.hoisthospitality.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQEp9SLQuAonW7-c9HzH4bSgUyJGJ5ZZNXHy-0phHvvZQ@mail.gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:30:52PM -0700, Stephane Eranian wrote:
> Hi,
> 
> On Wed, Oct 24, 2018 at 8:12 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > To calculate the physical address, perf needs to walk the pages tables.
> > The related mapping may has already been removed from pages table in
> > some cases (e.g. large PEBS). The virtual address recorded in the first
> > PEBS records may already be unmapped before draining PEBS buffers.
> >
> > Add a munmap callback to notify the PMU of any unmapping, which only be
> > invoked when the munmap is implemented.
> >
> The need for this new record type extends beyond physical address conversions
> and PEBS. A long while ago, someone reported issues with symbolization related
> to perf lacking munmap tracking. It had to do with vma merging. I think the
> sequence of mmaps was as follows in the problematic case:
> 1.   addr1 = mmap(8192);
> 2.   munmap(addr1 + 4096, 4096)
> 3.   addr2 = mmap(addr1+4096, 4096)
> 
> If successful, that yields addr2 = addr1 + 4096 (could also get the
> same without forcing the address).

That is actually a different problem. And you're right, we never did fix
that.

I agree with you that Kan's Changelog is somewhat cryptic; it took me at
least 3 times reading and looking at what the patches actually do to
understand :/

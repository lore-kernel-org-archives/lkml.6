Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959342186A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kRukPkmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbfBDKyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:54:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbfBDKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pUrx6wfid1IKHu9u5b5TVOQK3l1CnvqPpfB4Y3+K5nk=; b=kRukPkmY0vhymkziwpVS95fPU
        qFp+B1KV73WyiVHaQyRAKoX7SJJZ4JJadLRgaGBg8E3wfkDNYEZrVGuS5O0321YoDWL+UvNITM7z7
        L1R/iioSJlaB+4l2WJgTowKkzWLBOATRH+7/wPIbGfQUuQf8buEYJsXe8cNLVssoeyZt+8DS3WtsO
        BVDBTzIwhEXvmtfiVOx/uCEFOWUr02YeWo5L7g/9Og85iQ2+AXqpJOLGL3gDU96ThrvX3kzi68WaP
        HIUKMsc/w8IIo/a+PJFtFDiYb4B02lCbqzMkhygDpyzinwfIYxlnUwMydSDd7ZhxQjCQx0Yzb94mR
        ZeYxYgoUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqbtC-0000ms-SV; Mon, 04 Feb 2019 10:54:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 863CE202A2A0F; Mon,  4 Feb 2019 11:54:09 +0100 (CET)
Date:   Mon, 4 Feb 2019 11:54:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, acme@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20190204105409.GA17550@hirez.programming.kicks-ass.net>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
 <20190201100358.GD31552@hirez.programming.kicks-ass.net>
 <20190201103600.uflrwzgwj2tadhey@kshutemo-mobl1>
 <20190201124348.GC31534@hirez.programming.kicks-ass.net>
 <9fbb7bd3-b150-1ed1-bf03-c44d789172d0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbb7bd3-b150-1ed1-bf03-c44d789172d0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:16:51AM -0500, Liang, Kan wrote:

> > 	if (p4d_large(*p4d)) {
> 
> This one looks like x86 specific?

> > 	if (pud_large(*pud)) {

> > 	if (pmd_large(*pmd)) {

Kirill did indeed note that p*_large() isn't universally availale (but
there's definitely !x86 archs that have them). He also said it would
probably make sense to have them universally available and might help
clean up mm/gup.c a little.

A quick grep shows that: ARM, PowerPC, S390, Sparc and x86 have
'pmd_large'.

Anyway; it probably makes sense (and shouldn't be too hard) to fix up
all architectures to provide this.

Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3F926F3A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdQ25RaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3F926F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeFZTnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:43:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeFZTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=54R+9wFOYau/w3DgLhKJEhUoJVjkBUgWckARfHnq7Vo=; b=OdQ25RaXQSKGcbGTxMF83DLzW
        1yb9AMq96sSpeUkn9+nvKPDlIg2nrKk199PQbpTR/4kHEIgxmvivRfNOKo1jxQGlHDP9DXLrWdl1C
        s3OZCq4100sZLqp2Ru8ia2DW2ykCsaEJWYZHcaE2ZCHN4k5MP9jhGG1WxhVANtxxRWZ+jR80yP/U6
        Ayo+Wrg1qyg8ObLLt7F7eaBMXgJlnooViyiLgoLlBWxOmLn+DG0cxkkh8P1FaHo8Gi2rLlkE/hdYY
        LI6DUvvkscK8j2jEROpNdX/WTyb5rm9IcE2hwbQvH2PeJ7sFMfnZKWIP5Qv+aYAbjOkrQoRD+Unwb
        wxpwWB4hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXts8-0005VJ-Eb; Tue, 26 Jun 2018 19:43:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10B782029FA0A; Tue, 26 Jun 2018 21:43:27 +0200 (CEST)
Date:   Tue, 26 Jun 2018 21:43:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Allan Xavier <allan.x.xavier@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
Message-ID: <20180626194327.GP2494@hirez.programming.kicks-ass.net>
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
 <20180626164338.GH2458@hirez.programming.kicks-ass.net>
 <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
 <20180626184405.hsbuuq5eo7qzicoi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626184405.hsbuuq5eo7qzicoi@treble>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:44:05PM -0500, Josh Poimboeuf wrote:
> On Tue, Jun 26, 2018 at 07:31:18PM +0100, Allan Xavier wrote:

> > Is there a particular concern you're trying to address by having the logic there
> > instead?
> 
> Thanks for the patch and the excellent problem description.  I think the
> concern is that the overlap might cause other unforeseen issues (now or
> in the future).

Yeah, overlapping symbols are just really weird and unfortunate, I've no
idea what the GCC people were thinking.

Note how find_symbol_containing() already more or less assumed !overlap.

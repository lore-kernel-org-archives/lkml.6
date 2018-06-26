Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0AC25733
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VLDtGLEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0AC25733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeFZQnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:43:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeFZQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ucawCfoed3gfJu1QW+VJlAeRXaj78QkFJIcggY8x7g8=; b=VLDtGLEaMWTT5+VtW2a1X+/Yf
        mQIBUBwkTK/dImPojUjxB2HW7GdAv+0RXfg8RW513qfDG/5OHf6LC63GtN0QKaasJIYM3kQBkZfpP
        u8deXCLIZvMHI36HFHqfkJW6EjzopgvyiyoYzm9H09Pxjg9JHA/EpMjdpRvvhpCykMYnVwlEF3p0Z
        /kTO82A39elObSjH9OiyUP+itaKf673dBJFJzEgA+sKiyxTxaOANGKBO5xIqPKyJvM+G3eXwSPHqu
        20tbkJx9dMHMUHi1l+NkDVU5P1PutzIx0OdJGXBIoqd4eW6BoADzuhxjY+imXw/Dq+04m+8WvwcVD
        fsnLupK5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXr47-0003UI-Qf; Tue, 26 Jun 2018 16:43:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 691582029F1D9; Tue, 26 Jun 2018 18:43:38 +0200 (CEST)
Date:   Tue, 26 Jun 2018 18:43:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
Message-ID: <20180626164338.GH2458@hirez.programming.kicks-ass.net>
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626162045.25516-1-allan.x.xavier@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:20:45PM +0100, Allan Xavier wrote:
> 0000000000000500 g     F .text  0000000000000034 nmi_panic
> 0000000000000528 l     F .text  000000000000000c nmi_panic.cold.7
> 
> This doesn't happen with -freorder-functions in the first example as the
> symbols don't overlap. 

Urgh and I don't suppose we can 'fix' the overlap in read_symbols() ?

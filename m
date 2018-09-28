Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900B1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500932175D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZ4zo6ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500932175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeI1OPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:15:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47628 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeI1OPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lbbs0f8GVStNqJJcPc/rYaCrM+U5BqzWJW+4ASykth8=; b=KZ4zo6ie3OBTGAAFXur+MtQjR
        O+g/e61uPviLgbPHObJTAOc7mfpOzzRhNIAECTAEsf1v9czf06qH3EFDfUng/9qxXEA3v2kxjtnoV
        anJ3SAP9dWwusrxovVlwbLokyl0ETgZMb2lQtInE1pwklJNNJ7NutCMx9VRBW+beSHsNEUNYn1t8h
        ChvHNRlXkFyGWjnHsR61jcAAuB7VCwSPuNYC7oCMl8eD6tCP2IsrBg21f4e92g4aXNeOHjr3GaPfq
        ytWHMZnBQz2bH1CKWRZo3LKrAtPL33gAMK/aD8SiOogwBVCgwRXPJ3LKw5v40HTraCAdaPkU0x/fN
        wSTFJEpCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5nZV-0003UB-5x; Fri, 28 Sep 2018 07:52:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D47F21070936; Fri, 28 Sep 2018 09:52:19 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:52:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Message-ID: <20180928075219.GH3439@hirez.programming.kicks-ass.net>
References: <20180924211236.4149482-1-songliubraving@fb.com>
 <9489EF78-07EA-41AC-8A4D-F3FD3359C826@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9489EF78-07EA-41AC-8A4D-F3FD3359C826@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 07:23:20AM +0000, Song Liu wrote:
> Hi Peter,
> > #ifdef CONFIG_UPROBE_EVENTS
> > +PMU_FORMAT_ATTR(ref_ctr_offset, "config:63-24");
> 
> I guess you meant this part? This is for uprobe only, so I put
> it here. 

Ah,.. right you are.

You seem to have the bitfield backwards, does that mean we should write
the bits in backwards too? Seems a tad loopy if you ask me.

Did you instead mean: "config:24-63" ? Also, why 40 bits? 32 seems like
a much more natural amount.

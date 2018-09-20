Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A1DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341A5214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z9xMGLCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341A5214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeITNnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:43:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeITNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vZ6XA8wugt+A3IS38Z21yu7WL3GbJVf0Gsr/DnwoCqo=; b=z9xMGLCnzgayydrYpWZq7phof
        na8jJQugfnF/Lj2/5qT/+UFOHlm59i78dI26RONNBBsUs0ICSsKawRlWXLSWrNZ7izEmjTU26r1xY
        +mKcaxAq8BPp02r/qVlpr0r98ZQlbB4W5JOPvdeYlNJc6oUJdyCDAVNv8jUZXAsVTTTnB6Xy7wIFc
        s21gzlRqkre146RfSbSD0iEr8+jt8DT4NbxWq0Vae1VnpL2A9hM0NaLkul4QXxu2XompUTlOw6TNV
        gFaFKRGyc/Iwf9a+y+dcJdd5axriVKfp3TfxzvgggeJRJ7rnvI2JQg6SYJqueC7GHx/QG4WeXlNQT
        bmIrVf2zQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2ttR-00009W-R0; Thu, 20 Sep 2018 08:00:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F35DF201EC168; Thu, 20 Sep 2018 10:00:53 +0200 (CEST)
Date:   Thu, 20 Sep 2018 10:00:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/speculation: Provide application property based
 STIBP protection
Message-ID: <20180920080053.GM24124@hirez.programming.kicks-ass.net>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
 <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:35:30PM -0700, Tim Chen wrote:
> This patch provides an application property based spectre_v2
> protection with STIBP against attack from another app from
> a sibling hyper-thread.  For security sensitive non-dumpable
> app, STIBP will be turned on before switching to it for Intel
> processors vulnerable to spectre_v2.

Why does that non dumpable thing make sense? Why not use the same
prctl() we already use for SSBD?


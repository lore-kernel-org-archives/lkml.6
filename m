Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB372073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nu+3NcQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB372073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeIEMU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:20:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=spSW9CKH/pSMgZh28Hnk8qV1dn+fO84v+Oblx+8OxH8=; b=Nu+3NcQIiTfY1q4mUzAPJq2W2
        gSAySAZwI5cYJ4DqjBhjobjWHaEkOGWyil5zjctOaxSOIOHbRiFNlrMQFBm6g+1Eq5bAYpicPX/Iz
        kNZEoPxHPJHjPHqo3yGtPx7NdeZK0DYAo42ZndQWI8SN3wey41AwnFwh8VLCdOGNNuxdIxIZkaPQr
        k3nIhc8CYk0RL5XeJICvcHmBAQ7JjJMakA4ArvdIzr6XVW4Bv1mU1mJ+7lzfLmxgqv8X3tQ/+ewie
        wg/hT8yUldInZ669t+4peyrINqw+pHxsF7l/eco0o+XnoAMSMn2c/NPATM+zi/hXV3EYgBoYzCUeB
        9G91xG8cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxSb0-0003B9-J6; Wed, 05 Sep 2018 07:51:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C49D420191BFE; Wed,  5 Sep 2018 09:51:24 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:51:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Message-ID: <20180905075124.GM24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:40:57PM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Current ptrace_may_access() implementation assumes that the 'source' task is
> always the caller (current).

Note that now you 'fixed' the new user, this is still true. Which makes
me think you do not in fact need this patch, right?

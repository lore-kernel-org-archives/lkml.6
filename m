Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D19C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCEP3ah6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803E02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeIGSn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:43:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50926 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeIGSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZfK8dX3D58eppSN/DmSc5PPPSn9tdw1V8syjGmb4464=; b=ZCEP3ah6l1IsWltfUzF/2dlRo
        sBd/PAPcrad3wlvqSiXEtPoU4TbA8tvwTOZpmD9+ZtoWU4gZp1u5wEar9la4voevVxrpOXPQQARzQ
        w+wPvrfAVcHr2uNGqFczHl3CpXtO0OU+QEc7msFC4nSdtGsbJCUiEjSXooQn1eCIsXQE22V/oY/xh
        pXetBIhGn4RE39po+TOb4s6GuQzOjDa3Cp1LaJ1AU5DPlYU2/UAXNvHTFqxB0aidmx/LVvqo3+9HJ
        MQjvoqXt23PCD/dzqz/J1uSj5BCiG4zIBSCtG9kYp9451yngSKJolZ7g40zFgTTBJeGpYWq3wjHZL
        2qB3MPfvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyHLI-0001cJ-67; Fri, 07 Sep 2018 14:02:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E4B52024DB84; Fri,  7 Sep 2018 16:02:34 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:02:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907140234.GG24106@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
 <20180907073448.GL24106@hirez.programming.kicks-ass.net>
 <20180907094148.2444acc6@gandalf.local.home>
 <20180907134532.GD24106@hirez.programming.kicks-ass.net>
 <20180907095533.5b5febc2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907095533.5b5febc2@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:55:33AM -0400, Steven Rostedt wrote:
> On Fri, 7 Sep 2018 15:45:32 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Yes really, we should not muck with the IRQ state from NMI context.
> 
> Right, and we didn't. Your patch didn't change anything, but allow for

It does, it kills lockdep before we get to mucking with the IRQ state.

> printk_nmi_enter/exit() to be traced by ftrace, but that's wrong to
> begin with because it ftrace_nmi_enter() hasn't been called yet.

That's a second bug :-) A better solution might be to inline that
function as well. A direct OR instruction is still way faster than a
CALL+RET.

Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344E1256A1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QS9kGyD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344E1256A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeFYJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:22:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46700 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754753AbeFYJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pZpuGCAqa9fPwHqUmnsy91+PnI9rtLAf81BB5Twlms0=; b=QS9kGyD7C3FA+6h7n2DYYSAfp
        IERye8td9xD2YXbjb/+eofMOsogh7cvPJTwseogpjUmVBktXdWo0LD4XiqAjimIGanDVP3nkI+orZ
        WwJ7tsEGd61JLlookWKChKdXJkYD1RIrg6wdumunqwfBn4fZj5KBddIhS6S55pVWajFXaxTBPZl00
        g5cY68CDF36AqdMyx/GyfDfXUrU0TS4PYcfhYctSUHcaFZgGfbJibh9RijaFvxRUbTKwPSw/3Z9Jg
        /ErZzfV6wZe3hp0NJF++dg5rKAR2wRPKOcY/e/1Er4n+cpSp6QfDGLj6iJRWk4pU3EWGs4kSYPJcI
        r2FOo+r0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXNhe-0006hw-CK; Mon, 25 Jun 2018 09:22:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A7872029F1D7; Mon, 25 Jun 2018 11:22:29 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v12 01/11] x86: text_poke() may access uninitialized
 struct pages
Message-ID: <20180625092229.GW2494@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-2-pasha.tatashin@oracle.com>
 <20180625081429.GS2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251038190.8650@nanos.tec.linutronix.de>
 <20180625090915.GV2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806251112460.8650@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:18:02AM +0200, Thomas Gleixner wrote:
> On Mon, 25 Jun 2018, Peter Zijlstra wrote:
> > On Mon, Jun 25, 2018 at 10:39:24AM +0200, Thomas Gleixner wrote:
> > > On Mon, 25 Jun 2018, Peter Zijlstra wrote:
> > > > I'm not entirely sure this is right.. Because not only do we need the
> > > > whole fixmap stuff working, we also need #DB and the IPI handlers set-up
> > > > and working.
> > > 
> > > IPI? That's early UP boot why would you need an IPI?
> > 
> > Because the way this is called is from __jump_label_transform() ->
> > text_poke_bp() -> text_poke() -> text_poke_early().
> > 
> > And if you look at text_poke_bp(), you'll note it relies on #DB and
> > on_each_cpu() IPIs.
> 
> on_each_cpu() resolves to a direct call on the current CPU and as there is
> no other CPU it does not matter. #DB might be a different story, haven't
> looked yet.

It _should_ all work.. but scary, who knows where this early stuff ends
up being used.

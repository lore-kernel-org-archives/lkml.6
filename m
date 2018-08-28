Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FEB208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TSyykS2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FEB208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeH1Lq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:46:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeH1Lq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ibUG6AyIP1Sjh3cP6N9Vl92upGvt2SPPokxX6BkcXvk=; b=TSyykS2Cz9SYWsFdAvFqpFYb/
        MppOBWkzKj+cKzPdiU4Jzu1n8kif1P7Klq23bSwP81Q4aVTn9Nq10cMZBh492r7EjBWfI8Ra+F3bm
        WsVzbpv8dJS/U9OzCDf1cGY03Uhcc9IQ624NqqZioJ8zmSQHMjOns1SCSNGcW14esk3TEuqabuNKK
        RfWzW67OFedanJebEcx/oyz/vGDVL6MAd4fu0TX1d8aBWQK4ckDhJrLs19Y6B5sINc9M4QGFIgeo2
        JFnCfA8OglToCiBZyboYLOPih10Hrg3xgoWEDpg/6flQo7nO4n/lbjaU2a6eUUwgsw1a/+HD1JlRS
        2VS98HMNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuYrW-0004lO-KT; Tue, 28 Aug 2018 07:56:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A95832024D705; Tue, 28 Aug 2018 09:56:28 +0200 (CEST)
Date:   Tue, 28 Aug 2018 09:56:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternatives: lockdep-enforce text_mutex in
 text_poke*()
Message-ID: <20180828075628.GH24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1808280853520.25787@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 08:55:14AM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> text_poke() and text_poke_bp() must be called with text_mutex held.
> Let's put proper lockdep anotation in place instead of just mentioning
> the requirement in comment.

Thanks Jiri!

> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

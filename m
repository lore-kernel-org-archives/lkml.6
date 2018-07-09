Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D85D20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrF05CIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D85D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeGIOqu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:46:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56834 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeGIOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=32flinJ3yG8X+kSb57Cozxm1ee32GFnyMLSe3vMf6gY=; b=JrF05CIA0obcCve/p93SUuD+I
        ZohPHepcYjrQ4uteQLLjI0buoh3X3U26gXt0NO0MDOgSJidR65mG5T0fETsvWkTz2eMGVbzenEq1y
        CjFKp03u78mxbksqdlwG4JbhioCbju/nfWJHGgUDqi2f3NBvy/beUmpnbom9Evj/c/qui3w9OoqTf
        aiX8uiWQ6xSt3Cc0Lx2O7eeeh/PNZy3qnvahaPtdw9ZNzXiGdlH7lByVni64XsEfA2rEW0BtAaAnx
        DgAAxJPlpVukAA8fRug0rKfJpooYh06F6q/29+ySOUz7DxYv/NrxY1/9MoJzqLOo8zklcJj9GDV/R
        3pCevZjLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcXQC-00026W-AR; Mon, 09 Jul 2018 14:45:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF95D20289CF4; Mon,  9 Jul 2018 16:45:46 +0200 (CEST)
Date:   Mon, 9 Jul 2018 16:45:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and
 alignment
Message-ID: <20180709144546.GT2476@hirez.programming.kicks-ass.net>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
 <20180709133542.GP2476@hirez.programming.kicks-ass.net>
 <6762443004f96d279cba77b7c412163769c930fe.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6762443004f96d279cba77b7c412163769c930fe.camel@synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:30:41PM +0000, Alexey Brodkin wrote:
> Hm, any thoughts on why it's "u64" for 32-bit x86?

Accident probably. It probably doesn't really matter all that much
because the kernel hard assumes 2s complement, but it is somewhat
inconsistent.

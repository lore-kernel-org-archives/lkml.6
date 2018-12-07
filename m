Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E5FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRV6L/jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB1420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbeLGJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:22:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9jv/tzLBJ2Sd5N2aLTwi6/bZCZcUyV9P0jELjak4TQU=; b=eRV6L/jgX3OGLr7LMcSsc2iBM
        dL0nwXBcNCGIt6UaDARWPHMI34DTu0AOn0msoxgSssfNkZZGHtx5Need9JDfWmL81fT/WdtGm3uJt
        B9zD75YRWbscL95bSx7EYW78uDwPkgnWQWcw9ROOjMGK2SbRBQ+P1TOX+N3FwrUPMfjF6R95yIq2I
        /q2BDiIqaKI97Dbs0l4DkSTcn5Rwv40FM74pGAmaqwsfMY/tvpu2frC3cUD+004FMBSrvaZZNdF9L
        mJGmjYCNvV2G4CIdDjtqbmGh3ozqmgRmtgOsiDbDRnl7f7Jf9sF01cb+queQDaRAnMOv69m8yemgK
        c6BUSbs+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVCLW-0007Kx-E8; Fri, 07 Dec 2018 09:22:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF8C42072617E; Fri,  7 Dec 2018 10:22:52 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:22:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 08/17] locking/lockdep: Add support for nestable
 terminal locks
Message-ID: <20181207092252.GF2237@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-9-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542653726-5655-9-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:55:17PM -0500, Waiman Long wrote:
> There are use cases where we want to allow nesting of one terminal lock
> underneath another terminal-like lock. That new lock type is called
> nestable terminal lock which can optionally allow the acquisition of
> no more than one regular (non-nestable) terminal lock underneath it.

I think I asked for a more coherent changelog on this. The above is
still self contradictory and doesn't explain why you'd ever want such a
'misfeature' :-)

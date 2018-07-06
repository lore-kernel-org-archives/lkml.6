Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9763D24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ehiQTmqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9763D24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeGFNBa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:01:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeGFNB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ir9FOYvAIuIf6CghfoVI8OGN0h11O6ek/26Resd5bCs=; b=ehiQTmqiBpeO7NX07jVlBZ4FQ
        F0K3CDSnHsOFvT+bXuyughanSf9ypGfoM1q1674mMN7xKPD1MT4mZ3nCJBPocQCwCu88oMOWy4QtQ
        nNNhgW3Hr5wtzJQiZDa4Kl997znIVsvpNR7Lyfckz6o9Wk9qJlKemG2OfF9dxlYli5PXKIGTob3ww
        +JofiCKJYwIgsiEIQET72Qs9NKPemcD/rIBNJV2N7wNmg/1gePpEF1xp9R1F+tLcErd7DD7Z7uFsZ
        FWPHVBCWhtHTMODDSoCUL3BipPZxlewEDLuUCOvmv8h89zIMt7sLXoIGOrpSIYfFnbeXgrTH6QIm3
        XC9Mz59Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbQMK-0004Or-5S; Fri, 06 Jul 2018 13:01:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EF6320291063; Fri,  6 Jul 2018 15:01:10 +0200 (CEST)
Date:   Fri, 6 Jul 2018 15:01:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706130110.GP2512@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175902.GF2530@hirez.programming.kicks-ass.net>
 <20180706114402.GB27148@guoren>
 <20180706120323.GW2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706120323.GW2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:03:23PM +0200, Peter Zijlstra wrote:
> > Ok, I'll try to implement ticket lock in next version patch.
> 
> If you need inspiration, look at:
> 

My bad, just look at the arm (not arm64) version.

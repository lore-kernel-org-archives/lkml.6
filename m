Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC671C5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688FA20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QU3P6R6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688FA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967231AbeFSVAx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:00:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeFSVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zAPi7iDWRujjwF+UPeTeerzD/koU32TebDA1ZYsnFlc=; b=QU3P6R6tDH/gQMnFpeUFfSwfb
        QI11DKgqmMyM6siVFd+XRDaWZA3W2LoJyJZK2Gv+/mbmDKBttYTRXZskNtfqtD4yx9H1nP5jNDWC1
        4Wf1rknEjop2npieNPrqUkSijmGWmK6ZrFsiNXt/1yJDK53FRbdFZ5LN+mcPi4AETsZWGT3SOmqwC
        fXughDz2MVLhjBlKPnoHricE+TaBQTvhUjkG75CAfIm4PGVCi3sPQx4K8HppIpjQPolPZCjPm6H4e
        4yThe5572UFJIavKB2C/JeEodGHIkjPGY46JUJapD5Qpy5SNgod8urYISJsUgLCadXVw9BqWz7m+7
        IbCokXChg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVNjs-0008Cn-JI; Tue, 19 Jun 2018 21:00:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A761E20298BAC; Tue, 19 Jun 2018 23:00:30 +0200 (CEST)
Date:   Tue, 19 Jun 2018 23:00:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk
Subject: Re: [PATCH v10 1/7] x86/tsc: remove tsc_disabled flag
Message-ID: <20180619210030.GJ2476@hirez.programming.kicks-ass.net>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
 <20180615174204.30581-2-pasha.tatashin@oracle.com>
 <alpine.DEB.2.21.1806191928040.10546@nanos.tec.linutronix.de>
 <20180619184654.GG2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806192110230.10546@nanos.tec.linutronix.de>
 <20180619200115.GH2494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1806192256370.10546@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806192256370.10546@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:57:35PM +0200, Thomas Gleixner wrote:

> I'm not arguing against removing it. I just refuse to accept changelogs
> which suggest that there is no functional change.

Fair enough..

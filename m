Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F03C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF020661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZgERnTxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAF020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHaQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:14:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeHaQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qY5Q/tlww02APwr/szGcOdf/zkUT24XZ5KGNKMGWr98=; b=ZgERnTxBbKCZBkfB+W+u2xkbI
        nGOvqgQKM9fbvYMGv6tqOWQjUiTeVlOkZr7VCfE8vS7pebbKbu1dZtH5n1c41vF531uvVzFju/G8S
        QTgG3Kywi2i+rEJgGKedhrWwm7Wv2PlyVdNDnZR6yAz/fZyeV3W+z5mfM3b3wS3Qp2A1mRjI1rhNq
        2F1x1nY6nGDxUJon1ymmJQhIXRZvCdSVhm2qeq/X8PztpfKpW6X2d8Bti00S4Baq+LJX6d3BWM7pM
        8eqaJlUCIq0IIZgGVFyYJVunSrv13nB747kCO5w30jEaa1URmhG8qUim6XkqdpEEFXPd1gnT/S7cm
        5SCk2ZrUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fviCE-0000et-3y; Fri, 31 Aug 2018 12:06:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F4F42024D700; Fri, 31 Aug 2018 14:06:36 +0200 (CEST)
Date:   Fri, 31 Aug 2018 14:06:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Message-ID: <20180831120636.GM24124@hirez.programming.kicks-ass.net>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
 <20180829084348.GO24124@hirez.programming.kicks-ass.net>
 <20180831102248.GA8437@linux.vnet.ibm.com>
 <20180831104115.GH24124@hirez.programming.kicks-ass.net>
 <20180831112618.GA10911@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831112618.GA10911@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 04:56:18PM +0530, Srikar Dronamraju wrote:
> This was the same in my previous posting too. Before the topology update
> happened, all the cpus would be in SMT, DIE. The topology updates can be
> disabled using a kernel parameter topology_updates=off. Its documented under
> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html as
> 
>       topology_updates= [KNL, PPC, NUMA] Format: {off} Specify if the kernel
>       should ignore (off) topology updates sent by the hypervisor to this
>       LPAR.
> 
> and is not something new in powerpc.

Doesn't mean it isn't utterly broken.

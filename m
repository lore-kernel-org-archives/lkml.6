Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546DCC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01281204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xp+EwTB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01281204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeKBV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:27:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBV1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q1tyysbFF2IqNmk3qHBoO1genF0+CHBrDY+pUjijlvk=; b=Xp+EwTB1h6azylIysylSqH0Fp
        O05K26ujcqPfEFSQygUyHcKm2I17VqH6XuBVTuq4TeBvXPtxFzHghXiauPsp4z9vZSg6eLeHhEyJv
        ErYxfvFgTNqN8PEReaQ05BSMMr/Lh1x4tFQACgmWcIe9PAouy3lGnvYosOyf/HMuQYlHUBzcJHAdp
        +i65JPmfyYDy9NE0OYA8gU+4leV6kBDEej/h1YLIzLwgeOYSqnZ6U8gJIN5yGzsvUz8X9Ujvop0p6
        9Vu5jf1zJ0VtG/ax7mIBFhi3i7HkHe3rke+kbHv4f7T2oBTape0EW+KMQDcPMG+rhcPd/bPqwU5sn
        EHvvr9IAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIYQj-0000wI-Fv; Fri, 02 Nov 2018 12:20:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86E052029F9FF; Fri,  2 Nov 2018 13:19:58 +0100 (CET)
Date:   Fri, 2 Nov 2018 13:19:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
Message-ID: <20181102121958.GL3178@hirez.programming.kicks-ass.net>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
 <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
 <20181102105003.GK3178@hirez.programming.kicks-ass.net>
 <be3f2f03-6d19-2c6a-e859-c946594e3af1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3f2f03-6d19-2c6a-e859-c946594e3af1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 12:08:53PM +0000, John Garry wrote:
> > @@ -1337,7 +1353,7 @@ void sched_init_numa(void)
> >  	int level = 0;
> >  	int i, j, k;
> > 
> > -	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
> > +	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);
> 
> Ahhhh, unfortuately this change in isolation is not fixing the crash for me.
> I'm still crashing in the same place repeatedly.

Hurm.. sadness, means my reproduces doesn't reproduce quite enough :/
I'll see if I can somehow get something better going.

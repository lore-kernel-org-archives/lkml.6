Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE85CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10C22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URHVILkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10C22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeGQQYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:24:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeGQQYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zO9+UMIBqxmeNlpvsXYpN3+fsDDSlxXpxsgnVbvVKmo=; b=URHVILkNBUQe4Wj1xmBfL5qt6
        CWKsI2P+hT7AKSHxsEyrtAmZghHwfno3yek2GIIfvqb5QbM2eJUJGztumFnrROwAxrSx3VsD63Hsa
        CIniZfTIxHiNgoF+y+J2aIcYMVFS609FfjWcgkNDjhRatAnkZaCGPa3FHSaNevHu2Ch+2Yi9aKsH5
        lvSYXt6o5VXIzPYDDqpBWRpYbmuDwmQn6fZYg+UJG8Nf8iyzhdy6PdBjnDF+gMCPNIwL4KrMkeEMC
        +hxO2dysYwXa0kLDjSg97q82g6+IdT6EGxJKEGFpXfiNIF6O9crf2Ab2dvcZlAIIS7+Vq7Lv9nPTV
        A21D2Z4Dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffSFy-0001ba-NW; Tue, 17 Jul 2018 15:51:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A2C520275F36; Tue, 17 Jul 2018 17:51:17 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:51:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        mingo@kernel.org
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for
 interrupt lines
Message-ID: <20180717155117.GJ2494@hirez.programming.kicks-ass.net>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
 <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
 <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de>
 <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
 <c4f7e808-d416-63c9-2972-fb90a5c72753@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f7e808-d416-63c9-2972-fb90a5c72753@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:48:17PM +0100, Julien Thierry wrote:
> Supporting desc->affinity_hint for NMIs shouldn't be an issue, right?

Shouldn't NMIs be strictly per cpu interrupt sources?

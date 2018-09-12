Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1291C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C42720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HEHRTcj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C42720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeILOkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:40:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeILOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tCPiEoj52G8S8pSlQy1dUhxzIukyFKQARVzfQZL0fDQ=; b=HEHRTcj/celqipeD1/wsNN7ai
        5GRrTmTGn0jRIlSyZVrglPlpUb9MQ4KykBQUx7flu/3uxEDke5y3BdG8sJeyLiQDUvDA8l+uX9C57
        6f/heRzP37066e9UG94uVge5bTqdO0//awI+2CpVtiTfQ2XEjkycGlbKwvXsYW8wdzYqSn3iGbDMI
        noX9i06a467Rl4YDkLfIrtQqH/xeQDm5oAStgFJ9uf/WEYJWBS0fkZFdzpKmxnIuHrQNdrEKQVbaZ
        icfu7FA7cXADXLSFPJ2XGTtH356XQTgECiQOX39FlF8Cp5qx17sMeHU1iovmCyGDOgi36033J4tYP
        99Zy6zwUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g01ZR-0002Jr-OD; Wed, 12 Sep 2018 09:36:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DAFC202B2E3B; Wed, 12 Sep 2018 11:36:21 +0200 (CEST)
Date:   Wed, 12 Sep 2018 11:36:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180912093621.GY24106@hirez.programming.kicks-ass.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
 <20180907113309.GU24106@hirez.programming.kicks-ass.net>
 <20180907123739.GE1719@techsingularity.net>
 <20180910094147.GH1719@techsingularity.net>
 <20180912065410.GA5352@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912065410.GA5352@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:24:10PM +0530, Srikar Dronamraju wrote:

> Kernel A = 4.18+ 13 sched patches part of v4.19-rc1.
> Kernel B = Kernel A + 6 patches (http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com)
> Kernel C = Kernel B - (Avoid task migration for small numa improvement) i.e
> 	http://lore.kernel.org/lkml/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com
> 	+ 2 patches from Mel
> 	(Do not move imbalanced load purely)
> 	http://lore.kernel.org/lkml/20180907101139.20760-5-mgorman@techsingularity.net
> 	(Stop comparing tasks for NUMA placement)
> 	http://lore.kernel.org/lkml/20180907101139.20760-4-mgorman@techsingularity.net

But that's not a fair comparison :/ You've complicated things by adding
that second patch from Mel.

Now you cannot (unambiguously) tell what the cause for the performance
difference is.

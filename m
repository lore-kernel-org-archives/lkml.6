Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BD920892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zd/plECg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BD920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeKKIaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:30:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50622 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeKKIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eeQoAGQ0E6gbxoHfSbeL90uDxTD/cfbE4k/q5ed6dk4=; b=zd/plECgaV5ikESUO/YXZaPfJ
        Q7St7aEk+/NkfrUOf6N4Px6cGuYD427eIXXqaM10SKs/XmUsPbMVBiK1dAZ0emDTt/xSOEI41Yz1a
        jqwb2NJ3/guA23rT9oWBtcflilBaiBojMiUe4aPYVvMMOzUF5QaE8/whBuKkYLC3sPDdM5wHMzSNF
        i8D+sXeocHJh+zNLK1dKcsHEugC9gk9AR003720vNvjyICL3ew1Av0w4E2Dg/zQM/uRNsYClDQtsl
        0XM24kjObu7v5bi/TGuooV41mtlN1FC3qHL9q+tEUyYaWfFHtD0FFpzTZx/2p0JYFizBXNZPa4cfx
        +VDnGDAmA==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLbyE-0000gH-Cm; Sat, 10 Nov 2018 22:43:15 +0000
Received: by worktop (Postfix, from userid 1000)
        id 8C1E36E07D5; Sat, 10 Nov 2018 14:55:24 +0100 (CET)
Date:   Sat, 10 Nov 2018 14:55:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, Tejun Heo <tj@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/2] locking/lockdep: Add support for dynamic depmaps and
 keys
Message-ID: <20181110135524.GC3339@worktop.programming.kicks-ass.net>
References: <20181109234645.10530-1-bvanassche@acm.org>
 <20181109234645.10530-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109234645.10530-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:46:44PM -0800, Bart Van Assche wrote:
> The lock validator forces to categorize multiple instances of a lock object
> as the same lock class because it requires that struct lockdep_map and struct
> lock_class_key instances are static objects. This can result in false
> positive lockdep reports that are hard to suppress in an elegant way. Hence
> add support for allocating instances of these objects dynamically.

Yeah, I think not. You completely fail to explain how what you propose
is correct.

The thing is; we rely on static objects because they provide
persistence. Their address will never be re-used.

Dynamic objects do not provide this same guarantee. And when you re-use
the key address for something else, you'll mix the chains and things
come unstuck.


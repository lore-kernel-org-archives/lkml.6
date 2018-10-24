Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700B2C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BAA20831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faq0b/TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BAA20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJXSmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:42:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6YdHeJ40st/wDoNAAH8y60ebo1dhqAW8+Uuit+CFc5U=; b=faq0b/TH5ULtPAR+Yk9y/vpf+
        xmvUsD1vfgvqNKFIvriXnw/FGCnlwYtzQcp6py5o8C9n5AEOMHrQ3Xs/VyajhuD+l3Yy2Ew0altEM
        4sE27EyVTQdhipOzw4cZmC1k6clK2sd7b3COicF3x7lPikZmGSbZqX/5pdM8BwcHjKpmri+OAZotM
        BNyK34qjO6lTwqAvWnfFcMsDhTk7UfS0eu4rgYfn73mUec+9VHbbhKS79KAUXg6s77orQQRapjIer
        28g85GCGfZdahlOOiO9y/TDrABGQD+U8VHyjlJ4342Jq1XG9D5pejjl4DAmiJ4M9i8E599iqt0/Fw
        68T1wcWww==;
Received: from [185.7.230.213] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFGC4-0007L2-AH; Wed, 24 Oct 2018 10:15:17 +0000
Received: by worktop (Postfix, from userid 1000)
        id 0EDF86E08B3; Wed, 24 Oct 2018 12:15:08 +0200 (CEST)
Date:   Wed, 24 Oct 2018 12:15:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181024101508.GP3109@worktop.c.hoisthospitality.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024085636.GB23537@techsingularity.net>
 <20181024094646.GA18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024094646.GA18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 03:16:46PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2018-10-24 09:56:36]:
> 
> > On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> > It would certainly be a bit odd because the
> > application is asking for some protection but no guarantees are given
> > and the application is not made aware via an error code that there is a
> > problem. Asking the application to parse dmesg hoping to find the right
> > error message is going to be fragile.
> 
> Its a actually a good question.
> What should we be doing if a mix of isolcpus and housekeeping (aka
> non-isolcpus) is given in the mask.
> 
> Right now as you pointed, there is no easy way for the application to know
> which are the non-isolcpus to set its affinity. cpusets effective_cpus and
> cpus_allowed both will contain isolcpus too.

The easy option is to not use isolcpus :-) It is a horrifically bad
interface.

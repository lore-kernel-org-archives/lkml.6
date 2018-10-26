Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E92C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7DA2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RtxI3C4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7DA2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZRZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:25:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJZRZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dqf5Ck5G8GYPCVzecdaI2lG/tCscd/Epzbc+OFt1exs=; b=RtxI3C4Y9eNwtNB5aJbArNPLX
        PPmMH7vhAWHJgIYsFvO0bx1BCDzhrUc7aZfj8zhW2vb2ehVnXS/BeGXNROmVnlyjK4pOGlGydS0/V
        dgJuBGAukHs0C2xcwcsKSq4e0VyIQMcfcMzqXnitSrJWJxfp6LNJmcGCHJnCxFXU7KkA0mn1vqYOY
        jci9lxiFzSNt6zBVwzNmowXG0TRNL/oXtsLau4bKLJ7HHbsp/pvnWHHsHmlX2mM1zJs6x56qTT2gF
        1xkxuH0wkqnEpONYWTSPPDcwHnEZvRG8bNKT5HQc6GySI4Hmi6+mvRd9Y5LdfxGY7Wl6zDSWNtwRr
        d5P7QE5Aw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFxoN-0000yr-UH; Fri, 26 Oct 2018 08:49:44 +0000
Received: by worktop (Postfix, from userid 1000)
        id 3C3336E07D9; Fri, 26 Oct 2018 10:42:55 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:42:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181026084255.GZ3109@worktop.c.hoisthospitality.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024100323.GO3109@worktop.c.hoisthospitality.com>
 <20181024103002.GB18466@linux.vnet.ibm.com>
 <20181025000707.GR3109@worktop.c.hoisthospitality.com>
 <20181025182317.GE18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025182317.GE18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:53:17PM +0530, Srikar Dronamraju wrote:
> > 
> > You can create multiple partitions with cpusets but still have an
> > unbound task in the root cgroup. That would suffer the exact same
> > problems.
> > 
> 
> I probably don't understand this. Even if the child cgroups has
> cpu_exclusive or sched_load_balance reset, the tasks in root cgroup has
> access to all cpus in system. Right?

The crucial word being 'access'. The root group will not impose a limit
on the affinity of tasks. So you can indeed have affinities that span
load balancing domains.

And yes, that leads to 'interesting' but specified behaviour.

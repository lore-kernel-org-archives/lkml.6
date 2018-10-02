Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C46C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A282204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyTMwi5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A282204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeJBUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:34:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbeJBUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3TjGtxWWv7Cu2Tim8v0Fbd1T2mIx4r5RGnZkBXBnxIo=; b=UyTMwi5xYB14Vw25j4SKdmgwn
        v7jdEkkvRBbmSLMs3irjA4rrEb1kxxy7DUaRZFXsQjUTTMWcClp6wcihZu+ZkqPe4iJYuoAoQktqJ
        KAXrjyMra7zyJjbXOhQcvZj2ZH12KE+J6dp+wgd6hAvLGbmXAj/N0uRi55Q+tQrzBVczlaU7FFqi3
        VnHdfbDLHgXo4eLmwqYHn9nYRwsjEWL0e8nGNUnDEzSIz6iz0inV7TM629bQ6YlXDYbS64HK/0wfG
        T3bjHMTrqjZfZp/fnH8X/bRfh8sD2A6KokhmcxFtRfqlq5LuZEx3KcK89gMCzsPcUq1IsgCvzor5p
        oTFfdn/wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7L4M-00063J-1w; Tue, 02 Oct 2018 13:50:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8910202549E7; Tue,  2 Oct 2018 15:50:32 +0200 (CEST)
Date:   Tue, 2 Oct 2018 15:50:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002135032.GF26858@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002122535.GY3439@hirez.programming.kicks-ass.net>
 <20181002125414.aufsalllqf25rwsq@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002125414.aufsalllqf25rwsq@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:54:17PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 14:25:35 (+0200), Peter Zijlstra wrote:

> > Should we explicitly mention that this ignores idle costs?
> 
> More doc shouldn't hurt so I can add a little something if you feel it's
> needed.

Yes please, every time I read that thing I wonder about idle energy.
Then I remember we talked about this and it is expressly ignored.

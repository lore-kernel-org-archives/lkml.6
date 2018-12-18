Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83433C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ACF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFkAIwfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeLRLiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:38:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeLRLiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TT+syh42ziMvnj+IZND3gsZ545VH6pAeFcJkvnqG/LM=; b=hFkAIwfySmqYqQxy745VXLJtc
        2AAHu2ia1kLMmEwczlkonIeJa5GmTCSOFVxeXldsEHZbIBcAcBKq7pPh6yh7rO4MzAxx7MqrQ1sza
        C5Zdh0FThxFP0DN+k4OxF9yZOStnKCRoDDT/uttcFvD/Uk7CT6YY4OVcgz5qRcYaXKREceWkr0Bsj
        fMORqGMBxN1lcxZ4/6LFH3cWOxI1LPVYbXKUwsyQkkkb96F2EIuAlZI+OdC2qwZzJ+fkQLq1Gyks3
        5iHgfGlpArNeH8bbi91jE1BGLPFzhgQnlgrFh67fhmM5fqME2VRk/TbD3mVJ8PCSf12M+yRxclOdJ
        Zs1Px8XTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZDhb-0007l0-Sr; Tue, 18 Dec 2018 11:38:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B413820276AC4; Tue, 18 Dec 2018 12:38:18 +0100 (CET)
Date:   Tue, 18 Dec 2018 12:38:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     zhe.he@windriver.com, acme@kernel.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, hpa@zytor.com,
        jolsa@kernel.org, jolsa@redhat.com, kan.liang@linux.intel.com,
        mingo@redhat.com, namhyung@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Avoid unnecessary reallocations of
 memory allocated in cpu hotplug prepare state
Message-ID: <20181218113818.GH15430@hirez.programming.kicks-ass.net>
References: <1545129033-21757-1-git-send-email-zhe.he@windriver.com>
 <20181218110209.GD15430@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1812181223220.1519@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812181223220.1519@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 12:25:23PM +0100, Thomas Gleixner wrote:
> On Tue, 18 Dec 2018, Peter Zijlstra wrote:
> > On Tue, Dec 18, 2018 at 06:30:33PM +0800, zhe.he@windriver.com wrote:
> > > Besides, in preempt-rt full mode, the freeing can happen in atomic context and
> > > thus cause the following BUG.
> > 
> > Hurm, I though we fixed all those long ago..
> 
> Either we missed that one or it came back somehow.
> 
> > And no, the patch is horrible; that's what we have things like
> > x86_pmu::cpu_dead() for.
> 
> Like the below?

Look familiar that ;-)

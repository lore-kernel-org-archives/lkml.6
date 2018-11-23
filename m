Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2869C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A0320864
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFVBZNWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A0320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbeKXDgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbeKXDgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:36:05 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B8B20672;
        Fri, 23 Nov 2018 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542991866;
        bh=y+u0IM2C/gDxM/1IIh5emAGQl0ILpUNWvS44IFnlkac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFVBZNWrjb//wit7f/8pu4l6lk5h2JLBgvXgeE5jAR09+vUqkzSM70RUW3OyYGVD5
         m7ke2OJUkyR5e1BLohAhiVyh3nkI70SA7Cig+KSByRdC7oeqhB/GjWPvhJBeubYLr2
         Mu8/U74u7oUHEu2MYcI5hVWl+/jS7u3C6vzlB5Zo=
Date:   Fri, 23 Nov 2018 17:51:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
Message-ID: <20181123165102.GB4855@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
 <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:22:13PM +0200, Jan H. Schönherr wrote:
> On 09/17/2018 11:48 AM, Peter Zijlstra wrote:
> > Right, so the whole bandwidth thing becomes a pain; the simplest
> > solution is to detect the throttle at task-pick time, dequeue and try
> > again. But that is indeed quite horrible.
> > 
> > I'm not quite sure how this will play out.
> > 
> > Anyway, if we pull off this flattening feat, then you can no longer use
> > the hierarchy for this co-scheduling stuff.
> 
> Yeah. I might be a bit biased towards keeping or at least not fully throwing away
> the nesting of CFS runqueues. ;)

One detail here, is that hierarchical task group a strong requirement for cosched
or could you live with it flattened in the end?

Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69CFECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A981C2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAgowdfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A981C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJSXj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSXj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:39:56 -0400
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A901F2083E;
        Fri, 19 Oct 2018 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539963200;
        bh=7LSEEMq66ibdXhb1tXPdiKlfoStYnb14mt3Dq9gOxXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAgowdfR6TaO9eY8iLmwSyhVJNiswZqLXaRgHrIImc7PIS3AaTLepWRUGC1AMUy13
         rgkDfXi9xjzHQ5g5VVNRWiLjyHgQK5hrZC0Sbmp7NGjng8fNdIggwaeu7rFjIe0joU
         mH3y1dwkOHUBlqqjlE/hMNgOANX8fp2SCtb8iEqs=
Date:   Fri, 19 Oct 2018 17:33:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20181019153316.GB15416@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20181017020933.GC24723@lerouge>
 <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
 <824154aacf8a5cbff57b4df6cb072b7d6e277f34.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <824154aacf8a5cbff57b4df6cb072b7d6e277f34.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:16:49AM -0400, Rik van Riel wrote:
> On Fri, 2018-10-19 at 13:40 +0200, Jan H. Schönherr wrote:
> > 
> > Now, it would be possible to "invent" relocatable cpusets to address
> > that
> > issue ("I want affinity restricted to a core, I don't care which"),
> > but
> > then, the current way how cpuset affinity is enforced doesn't scale
> > for
> > making use of it from within the balancer. (The upcoming load
> > balancing
> > portion of the coscheduler currently uses a file similar to
> > cpu.scheduled
> > to restrict affinity to a load-balancer-controlled subset of the
> > system.)
> 
> Oh boy, so the coscheduler is going to get its
> own load balancer?
> 
> At that point, why bother integrating the
> coscheduler into CFS, instead of making it its
> own scheduling class?
> 
> CFS is already complicated enough that it borders
> on unmaintainable. I would really prefer to have
> the coscheduler code separate from CFS, unless
> there is a really compelling reason to do otherwise.

I guess he wants to reuse as much as possible from the CFS features and
code present or to come (nice, fairness, load balancing, power aware,
NUMA aware, etc...).

OTOH you're right, the thing has specific enough requirements to consider a new
sched policy. And really I would love to see all that code separate from CFS,
for the reasons you just outlined. So I cross my fingers on what Jan is going to
answer on a new policy.


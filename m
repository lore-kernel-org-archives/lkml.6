Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3DBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF7820844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yzZHaAUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF7820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeIGPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:44:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55286 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbeIGPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zj9m3bL7/GgZO6pd5S6/GDfgJpek/j4NHkhjpGW5ueg=; b=yzZHaAUklP+KBx3mEVEfW/ZMY
        vXFpwnbTFa85MRnCiD5xEt7/JkNQRFdeVjiDTEbgwoYWKG+4KyLCo4K2uM3rL+0tcAkeNRDioOpe8
        C5QbbmQ/iF7OyOrgqdjEKvM2ayJZKh7rX49/A1CS7//fQRCcsTP3hdmZsC86biJlwipQlWGp4hPGa
        5z+iT6cMkXuvfP7TaWJHOFK25JDinH83ZOWYgj7JqIJZdYtpYMTfdJmJjy4MXP09G626dIC7khjoR
        dNxQiBI8tCDiEqi0+BUbBj1KELBV78HL2v5Kh9O4ngzC/PCs2ZkWhOMxwSMiDvInRoWNcmqc1o4In
        lL2SfuVrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyEYb-0001GO-Mh; Fri, 07 Sep 2018 11:04:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 447A3201F9C46; Fri,  7 Sep 2018 13:04:07 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:04:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20180907110407.GQ24106@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180905214303.GA30178@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905214303.GA30178@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 05:43:03PM -0400, Johannes Weiner wrote:
> On Tue, Aug 28, 2018 at 01:22:49PM -0400, Johannes Weiner wrote:
> > This version 4 of the PSI series incorporates feedback from Peter and
> > fixes two races in the lockless aggregator that Suren found in his
> > testing and which caused the sample calculation to sometimes underflow
> > and record bogusly large samples; details at the bottom of this email.
> 
> Peter, do the changes from v3 look sane to you?
> 
> If there aren't any further objections, I was hoping we could get this
> lined up for 4.20.

I suppose it looks ok, there's a few small nits, but nothing big.

I still hate psi_ttwu_dequeue(), but I don't really know what to about
that.

So yeah, grudingly acked. Did you want me to pick this up through the
scheduler tree since most of this lives there?

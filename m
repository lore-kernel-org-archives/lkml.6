Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D342081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2jvkTYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfBDMSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:18:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfBDMSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4w5nfgJzQzB7J7OBjkWwXWwU2NpaLnL33MR+V7KnNxw=; b=p2jvkTYdAkPnpy0EoVIRngRsC
        2jB4bul9vMI7PtdPGH/gb4KDMYCUWl5G/k0yiKQEq94zbg/iDSSOJd2bcP01UdB/4R/vZsrO/e4aW
        vfjv3mXFE8b9jBrQk6+itOpFgSRyB+YDaQXZb/Oc5iDVw/uxE0AeWRfbb7lTAwjHicki3LbQ+sUCy
        541MVBMlHalM1KWn1dK5PtuTX7ctajUqrY9h/joQHWG9rKwYlPlaGbxtNaI/ZaclbXIgo13l9vc/W
        CxGoyot7A5SZPXozMFeqO4dMtZKoFmJLyWMuJNWaZY8okUbd32eE8hqtyRr7kNJPwME+9Koi0zAqa
        njNHLTMRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqdCl-00050H-7k; Mon, 04 Feb 2019 12:18:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA9F92029FA06; Mon,  4 Feb 2019 13:18:25 +0100 (CET)
Date:   Mon, 4 Feb 2019 13:18:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     longman@redhat.com, mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v6 0/5] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20190204121825.GE17550@hirez.programming.kicks-ass.net>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190118161739.GE50184@devbig004.ftw2.facebook.com>
 <20190118164642.GC26615@localhost.localdomain>
 <20190204090211.GA10449@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204090211.GA10449@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:02:11AM +0100, Juri Lelli wrote:
> On 18/01/19 17:46, Juri Lelli wrote:
> > On 18/01/19 08:17, Tejun Heo wrote:
> > > On Thu, Jan 17, 2019 at 09:47:34AM +0100, Juri Lelli wrote:
> > > > Hi,
> > > > 
> > > > v6 of a series of patches, originally authored by Mathieu, with the intent
> > > > of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> > > > As originally reported by Steve [1], when hotplug and/or (certain)
> > > > cpuset reconfiguration operations take place, DEADLINE bandwidth
> > > > accounting information is lost since root domains are destroyed and
> > > > recreated.
> > > > 
> > > > Mathieu's approach is based on restoring bandwidth accounting info on
> > > > the newly created root domains by iterating through the (DEADLINE) tasks
> > > > belonging to the configured cpuset(s).
> > > > 
> > > > Apart from some minor refactoring needed to rebase the set on top of
> > > > Waiman Long's cpuset for cgroup series (now mainline), two changes worth
> > > > of notice:
> > > 
> > > Generally looks good to me but can you please ask Waiman to take a
> > > look?
> > 
> > Argh! I should have cc-ed him in the first instance.
> > 
> > Thanks for reviewing.
> > 
> > Waiman, do you see anything wrong with this series? Thanks!
> > 
> > https://lore.kernel.org/lkml/20190117084739.17078-1-juri.lelli@redhat.com/
> 
> Ping?

Basically looks OK to me; wlthough I think I prefer the callback_lock /
rq->lock ordering to be the other way around.

Waiman, you OK with this one?

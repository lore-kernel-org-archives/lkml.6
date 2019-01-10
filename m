Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EFD20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBsMHABf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfAJTrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:47:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfAJTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=us2vqTukos5xrP0a48X02kFzcYNH72RHcMba+8KaRv4=; b=nBsMHABfB4uOhR66sDZK0hnS/
        bGxGMEXpzGM0Ex+BAHjoZlYAGuJ//kchYd7xvR38SpRCw2IiFrsnUzINcwDJjd8IS0wNrUqbXlbQ8
        JNVqlb76H/9Zy+ldxvtIjJM4/4kj5zOgPukYVoiuIt0Ds208kDsNlyca8DqAmNtNiyzUUrb8hOxK9
        ivms9tQFU7cabpcN28xpL+WUqlohj82QSf//1EzaKZmyMLJm6lXPggIR9hWBuFtLR9leYrFtsdMCb
        viE6MBVom+Itn+XkgU3mtI29K8xMRMegPZxDNWQIaFdM3wyQYlxd10Md3sGgzYd2aDGfjMfuTFGjz
        k0fsdZwjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgIE-0006q0-1o; Thu, 10 Jan 2019 19:47:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE0A49844AF; Thu, 10 Jan 2019 20:47:03 +0100 (CET)
Date:   Thu, 10 Jan 2019 20:47:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110194703.GE2861@worktop.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
 <20190110152804.GH30894@hirez.programming.kicks-ass.net>
 <1547148671.83374.54.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547148671.83374.54.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:31:11AM -0800, Bart Van Assche wrote:
> On Thu, 2019-01-10 at 16:28 +0100, Peter Zijlstra wrote:
> > On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:
> > > +static bool inside_selftest(void)
> > > +{
> > > +	return current == lockdep_selftest_task_struct;
> > > +}
> > > +void lockdep_free_key_range(void *start, unsigned long size)
> > > +{
> > > +	init_data_structures_once();
> > > +
> > > +	if (inside_selftest())
> > > +		lockdep_free_key_range_imm(start, size);
> > > +	else
> > > +		lockdep_free_key_range_reg(start, size);
> > >  }
> > 
> > That is .... unfortunate. The whole reason that whole immediate thing
> > works at all is because there is no concurrency what so ever that early,
> > right?
> > 
> > Should we maybe key off of: 'system_state == SYSTEM_BOOTING' instead?
> 
> Hi Peter,
> 
> I agree that it is unfortunate that the selftests require a different code
> path. I have not been able to find any way to avoid this. Using the test
> system_state == SYSTEM_BOOTING should work and will allow to remove the
> lockdep_selftest_task_struct variable. Do you want me to make that change?

I can do it; another approach is simply using the _imm (maybe renamed to
_selftest) functions directly, and getting rid of this dynamic choice.

I'm undecided as of yet.


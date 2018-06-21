Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E59C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B521EA4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HMkr5awR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5B521EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeFUUQg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:16:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeFUUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7vB18Trb7LuGl4lIKg/xu3zHWfWIoaygPnp88cl8TuU=; b=HMkr5awRwnrw7JsFHTOuSDqdZ
        zjfH274Sq35s1SxA/vjluK/wIm1uhdG3iGRIgFqzE9rK5zd3pnYGBjA00yd1hK+rbSfVCR83MR1fA
        fRvZkUd1r7Weh+G3go+BNJrK3csxiPItZoJoTDJ7EF2fdZ+SKHLtFQ2h4zrPbMY406wEPSAlZBElk
        reJshwU7QEe7R754Tz1okfcDBfV/wZYwYMRCGsG2nkoXj2namooKIMClTgjYQpWjL0xbspKXrGOHm
        zyRrgQ3dbu+yJbmW7eGD7JRVJvxalUAmESGirOc67UKJ9xZjQjwncy0GaLnYKHpbJqFEmkRmmv0Z2
        hJ+SX+x+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW60Q-0007h7-Bp; Thu, 21 Jun 2018 20:16:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BEFC2029FA0A; Thu, 21 Jun 2018 22:16:32 +0200 (CEST)
Date:   Thu, 21 Jun 2018 22:16:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180621201632.GE27616@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
 <20180614202022.GC12217@hirez.programming.kicks-ass.net>
 <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 01:47:25PM +0300, Alexander Shishkin wrote:
> On Thu, Jun 14, 2018 at 10:20:22PM +0200, Peter Zijlstra wrote:

> > More yuck...
> > 
> > You rreally should not be calling these pmu::methods, they're meant to
> > be used from _interrupt_ not NMI context. Using them like this is asking
> > for tons of trouble.
> 
> Right, the SW stuff may then race with event_function_call() stuff. Hmm.
> For the HW stuff, I'm hoping that some kind of a sleight of hand may
> suffice. Let me think some more.

I currently don't see how the SW driven snapshot can ever work, see my
comment on the last patch.

> > Why can't you just snapshot the current location and let the thing
> > 'run' ?
> 
> Because the buffer will overwrite itself and the location will be useless.

Not if it's large enough ;-)

> We don't write the AUX data out in this 'mode' at all, only the samples,
> which allows for much less data in the resulting perf.data, less work for
> the consumer, less IO bandwidth etc, and as a bonus, no AUX-related
> interrupts.
> 
> But actually, even to snapshot the location we need to stop the event.

Maybe new methods that should only be called from NMI context? 

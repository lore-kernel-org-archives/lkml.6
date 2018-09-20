Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F6FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35821529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+tgvtpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E35821529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbeITSlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:41:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbeITSlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pZDOWT3eqL3RuZfp3WAO7P9LUaRB+kI0/TsnvZhDXVA=; b=g+tgvtpIhuyabrVkbzqZHqkt0
        2hCLV9+2lJLBAzRtN6TK3LRMNGJDd6kXJLBQlc6/rY/S9mzJp5iJEQ7PQ49EKt6xvjWQ6YltlECbC
        PY3z7nlNPdpjdCR6nCheq6Y9d0AQ2CzKbFE/jqbEIGSmDl5AhNqNqQMMNa5VUHZCigL/2qwGZ3oNi
        GTggv6RDwjeYHy0hnm0nfmegDpAENWbsF+fiBR/ZycCl6eMjWwvBjg7y157igUkxmG6MMrdgKzhZm
        8LHV+nJ1BSVyCwFbNJfoVskFY2emnoiXM8gWoVfiamHYKbHHldthI/1Iz95F8M7SD8eepFUbKh7iC
        PanQLgjmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2yWP-0002BM-1W; Thu, 20 Sep 2018 12:57:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 968A5201EC164; Thu, 20 Sep 2018 14:57:27 +0200 (CEST)
Date:   Thu, 20 Sep 2018 14:57:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
Message-ID: <20180920125727.GV24124@hirez.programming.kicks-ass.net>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-6-git-send-email-wei.w.wang@intel.com>
 <20180920123753.GT24124@hirez.programming.kicks-ass.net>
 <5BA39968.8030309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BA39968.8030309@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 08:58:16PM +0800, Wei Wang wrote:
> On 09/20/2018 08:37 PM, Peter Zijlstra wrote:
> > On Thu, Sep 20, 2018 at 06:05:59PM +0800, Wei Wang wrote:
> > >   /**
> > > + * lbr_select_user_callstack - check if the user callstack mode is set
> > > + *
> > > + * @lbr_select: the lbr select msr
> > > + *
> > > + * Returns: true if the msr is configured to the user callstack mode.
> > > + * Otherwise, false.
> > > + *
> > > + */
> > > +bool lbr_select_user_callstack(u64 lbr_select)
> > > +{
> > > +	return !!(lbr_select & LBR_USER_CALLSTACK);
> > > +}
> > > +EXPORT_SYMBOL_GPL(lbr_select_user_callstack);
> > That function is pure and tiny, wth is that an exported symbol and not
> > an inline?
> Thanks Peter for the comments.
> 
> Because this function uses the LBR_ macros which are defined in this lbr.c
> file.
> Do you think it would be OK to move all the above LBR_ macros to
> asm/perf_event.h?

Sure.

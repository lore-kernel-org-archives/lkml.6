Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFCCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5050D20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uu/7bonv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfAHStl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:49:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAHStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9EThvUedqwr9JLagw4SbqAFedU0AoJZ9CKdWwl7XKiA=; b=Uu/7bonv5ZaHGzI6QLfILzH9B
        puh54QM8wm3H7+zKWLUgPsli0zU7U2sj4ZY8gDz+g1tyBdF4Xo6U6eBGsKezYjvqnhIBZKNtC228Z
        mjGzNwbI/ic4qkyDTUSUrAuciBBzKhhlVnTGc/zIxj0ggVaOxfZAC9/mj6UxvDOOEQiDr3Y2xFdlK
        snYv0/ZvaVrjGUtmfBj9ak+edbZ/9hi+/jApT37OBk9WJn5519c4gTVbS68ifn97QoyRIfmadth1K
        Q8Y71bcS4buqpXGjXg8wnzbUs5DiONR9amO94TYHZn8ZEPRLlJxCgRPR/W8Ia9sI5WEQTS2cfzNgX
        z2sT6TyHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggwQw-0007W7-MF; Tue, 08 Jan 2019 18:49:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C99320289CC1; Tue,  8 Jan 2019 19:49:01 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:49:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org, jgross@suse.com
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for
 exclude incapable PMUs
Message-ID: <20190108184901.GA1900@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-11-git-send-email-andrew.murray@arm.com>
 <20190108104841.GD6808@hirez.programming.kicks-ass.net>
 <7300f0af-b532-5546-a6f4-fec69cb91a0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7300f0af-b532-5546-a6f4-fec69cb91a0f@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:36:33AM -0500, Boris Ostrovsky wrote:
> On 1/8/19 5:48 AM, Peter Zijlstra wrote:

> > On the various exclude options; they are as follows (IIUC):
> >
> >   - exclude_guest: we're a HV/host-kernel and we don't want the counter
> >                    to run when we run a guest context.
> >
> >   - exclude_host: we're a HV/host-kernel and we don't want the counter
> >                   to run when we run in host context.
> >
> >   - exclude_hv: we're a guest and don't want the counter to run in HV
> >                 context.
> >
> > Now, KVM always implies exclude_hv afaict (for guests), I'm not sure
> > what, if anything Xen does on x86 (IIRC Brendan Gregg once said perf
> > works on Xen) -- nor quite sure who to ask, Boris, Jeurgen?
> 
> perf does work inside guests.
> 
> VPMU is managed by the Xen and it presents to the guest only samples
> that are associated with the guest. So from that perspective exclude_hv
> doesn't seem to be needed.
> 
> There is a VPMU mode that allows profiling whole system (host and
> guests) from dom0, and this where exclude_hv might be useful. But this
> mode, ahem, needs some work.

Thanks Boris!

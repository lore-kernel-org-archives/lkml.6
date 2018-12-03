Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26BD20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r/xzab/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26BD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLCIqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:46:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeLCIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EgHySjzcZL6cfvn0IY/qIxKvTjt+dYuyKwPO5LsghnM=; b=r/xzab/p8c7PNIB3Eq2p3zrbM
        1sg7eMn3IR/BDtuytzqEztTQgg6+05RLS4iRy4ZzBFmfjO4EdTad/P3RGKkfn7f7eVJeGMSQOB+bq
        +0GTLVIpC1DLurIUNp8LA0/Y/IzdBGpvInAt2pP7Myx39sC1rZ2Wz6dfBNjrSU89ZrXETugpOy0hw
        U/cJEjOprpb++biMe+UZvk0Vz8Gb5O6OdSY/hHXfNB/vSVbYx3jidfZb8hQr62OX7S2b+EH560nXm
        mWtZnCoNEIbL+qJM5Qm6kkpeDKHpHzAWhufVCORENZzNIctnO8WBji07gjuxT/mzEJHEdkFPvr+UV
        SJuRENs3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTjri-0003II-Nd; Mon, 03 Dec 2018 08:46:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 309DB2029F883; Mon,  3 Dec 2018 09:46:05 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:46:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com, Julia.Lawall@lip6.fr
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
Message-ID: <20181203084605.GC11650@hirez.programming.kicks-ass.net>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn>
 <20181201203700.GW4170@linux.ibm.com>
 <20181203083500.GH11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203083500.GH11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 09:35:00AM +0100, Peter Zijlstra wrote:
> On Sat, Dec 01, 2018 at 12:37:01PM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 01, 2018 at 04:31:49PM +0800, Wen Yang wrote:
> > > Fix the following warnings reported by coccinelle:
> > > 
> > > kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1

Not to mention that WARN is gramatically incorrect. We're not assigning
'bool' to 0/1 but the other way around.

What crap..

> So I strongly disagree with this. Anybody that has trouble with 0/1 vs
> false/true needs to stay the heck away from C.
> 
> I would suggest we delete that stupid coccinelle scripts that generates
> these pointless warns.



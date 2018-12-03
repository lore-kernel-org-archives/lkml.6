Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C0E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3dCdXxBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C0E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLCKvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:51:32 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLCKvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZRqrzvaSqYPlyr/uF2HAY3yYSZv0lA7oKs8FpC0BNJ0=; b=3dCdXxBi2q65zAlzMuVglLaM0
        en6s3VvIzRZb0APZliQG7G18klmVMN35UzzhVRN6MPrezN1DHlh3vMsR4EDYt1ECSw6nG3gKFJAJj
        n0w6jjXEUWhXyLfPXznxRVU49cZVSmvxhVbwYFr5YSIsdyFp6h9Q3r9h1j0VfgjVzBSoUDR0TIeWv
        ZidPJ6h97bS5Jg6SGJWg2KJa4/f2/ljDxmZcFnQTOE/ILn19k3oMLdVhUQJByhc3j2bS/FM8WTXuF
        lsJHgy4tBAbAerTtC+xAPXJEPFFIN6aeXTA6j5wUaZ9JiZ2iF2xmFo8oe3guyyVu1CvxeglSphQS7
        i9x9ZZsjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTloM-0006wS-Kw; Mon, 03 Dec 2018 10:50:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26E722029F87F; Mon,  3 Dec 2018 11:50:45 +0100 (CET)
Date:   Mon, 3 Dec 2018 11:50:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
Message-ID: <20181203105045.GD11573@hirez.programming.kicks-ass.net>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn>
 <20181201203700.GW4170@linux.ibm.com>
 <20181203083500.GH11614@hirez.programming.kicks-ass.net>
 <20181203084605.GC11650@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.20.1812031016330.7942@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1812031016330.7942@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 10:20:42AM +0100, Julia Lawall wrote:
> Personally, I would prefer that assignments involving boolean variables
> use true or false.  It seems more readable.  Potentially better for tools
> as well.

Then those tools are broken per the C spec.

> But if the community really prefers 0 and 1, then the test can
> be deleted.

The C language spec, specifies _Bool as an integer type wide enough to
at least store 0 and 1.

IOW, 0 and 1 are perfectly valid valus to assign to a _Bool.

And fundamentally that has to be so. That's how computers work. 0 is
false, 1 is true.

The kernel is not the place to try and abstract such stuff, C is our
portable assembler. We muck with hardware, we'd better know how the heck
it works.



Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE91C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E123222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550069513;
	bh=hMvopVaIF8dUOqp/YyMBPMSjlf5vUS3NmUdo3t24mYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JFTBZIi/iSTlT6qi0RzVEqLWZI1E3urANoP1SsUchtKE5UbYfGi4n8zpD49oxoYUe
	 mWnpxMh0HWq0dZpFd5Fk9+ssw23PoOMfv2qKW47QZikwskqdBp4xXesAQ5cJpN1piF
	 HyJxm5+UORZB8CYYB3ftFhgTuLtvDsqj2Fb1hz+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392388AbfBMOvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfBMOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:51:51 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2946222B5;
        Wed, 13 Feb 2019 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550069511;
        bh=hMvopVaIF8dUOqp/YyMBPMSjlf5vUS3NmUdo3t24mYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxNGpBsZNSEyfVW/wcTqMr5/Xz2nYU3FHxL9dRvGv9DRyESBxo+8Cza1ECQz1S/dP
         vkLvQhBAz7TdsnJCG2NppDxGhDSglMmEc0z8/ApzBd6okAXuZ+AptQ+44ljuj7WFN3
         f0nExEtTzp20FWTTJq/ix+xu2JIiTxzkoS2VbcXY=
Date:   Wed, 13 Feb 2019 15:51:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/32] locking/lockdep: Convert usage_mask to u64
Message-ID: <20190213145147.GB8524@lenoir>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-4-frederic@kernel.org>
 <CAHk-=wiKtW+=x5zVmsxBOUnjQYQKzkfYUhE5F=eY_R=opa-vNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKtW+=x5zVmsxBOUnjQYQKzkfYUhE5F=eY_R=opa-vNA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:40:09AM -0800, Linus Torvalds wrote:
> On Tue, Feb 12, 2019 at 9:14 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > The usage mask is going to expand to validate softirq related usages in
> > a per-vector finegrained way.
> 
> So here you start explaining why you wanted that u64. Much too late,
> considering that you already changed to u64 earlier.

Yes indeed, while recutting the set I forgot a few things back. I'll re-introduce
the u64 from that patch on.

Thanks.

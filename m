Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD1EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19149222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550069811;
	bh=PlVBDsZahMCv6qTlYKTtDALN3twojT6txuJ/PL2Fm9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wg8MYufqueiqAC0gye9ZMaLiQnwLUB5fs++0gDZgAndU56bl9TupKBq1xdqRcFkxx
	 Yo1tZBs7EBR99Y5/jGET8TXF9amHy7gNgc5fUfXWsaxrQxO5r9bTKNNM7zW7JFAL+J
	 hneU6KjEIkKebP9AT2VCwce8xuE6yhkv+XM+nLbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbfBMO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfBMO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:56:49 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F27222C1;
        Wed, 13 Feb 2019 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550069809;
        bh=PlVBDsZahMCv6qTlYKTtDALN3twojT6txuJ/PL2Fm9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIpod9D/pHHazF9yZWWk6iTGFU3MRZBFDRpWzcLRSD/rq+K8n4e2FnNn+LXz4S8fh
         O28fiOX9zt3loXYGKre+Hmj+WEOjVFj2QiuAoD8+PVTSusRZgWjHw6ZUYGvB1wlNnu
         VFO+oYEWiW08cbdf6AJPCT5Cm7EQ+vvqym20SH08=
Date:   Wed, 13 Feb 2019 15:56:46 +0100
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
Subject: Re: [PATCH 02/32] locking/lockdep: Introduce struct lock_usage
Message-ID: <20190213145645.GC8524@lenoir>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-3-frederic@kernel.org>
 <CAHk-=witwrbw0mExDpGzxYic87FpGhe1gCB+nqm1woUvwPY9GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witwrbw0mExDpGzxYic87FpGhe1gCB+nqm1woUvwPY9GA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:38:42AM -0800, Linus Torvalds wrote:
> On Tue, Feb 12, 2019 at 9:14 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > +static u64 lock_usage_mask(struct lock_usage *usage)
> > +{
> > +       return BIT(usage->bit);
> > +}
> 
> More insane "u64" - and it's *incorrect* too.
> 
>     #define BIT(nr)                    (1UL << (nr))
> 
> fundamentally means that "BIT()" can only work on up to "unsigned long".
> 
> So this odd use of u64 seems to be a disease. It only uses more memory
> (and more CPU) for no obvious reason.
> 
> u64 is not some "default type". It's expensive and shouldn't be used
> unless you have a *reason* for it.

Right, I'll simply move "[PATCH 03/32] locking/lockdep: Convert usage_mask to u64"
at the first position and follow up on that to justify its use.

Thanks.

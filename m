Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DCBC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9911F24623
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLSEmGTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9911F24623
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934754AbeF1I10 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:27:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933589AbeF1I1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fiy2xpryowEaFh5QWeXWRpND0F3gPngbzBs3bNsoAF8=; b=mLSEmGTzssBlZckNhb0FqGx5b
        6birtN4bK6YgQQ/qrWLrb1oiOioWOA9gUs40Bcpqqh5lLgxKnb25xzzExR8xmfKXFGtbAOA8uMRJe
        zzilLFUyUPg9XF7GSgy9+uUqsYjpLmIG/EmweOrShO8H0IBQaSGHcBUCgU0+WrhGdBTLwHgL1sUPx
        lFLAreufcbA6goaqr3Wc25BaR8clUumkJQNVefDGHooXaSnO57J1+SOBTfNWzRgYmQhqLDnL+5Kjk
        agXyiRHVhLHPe2MirmUYXeZxdHMLFKhWL5SQdWFGWkhBTDdpHb2p+swVpIcLrWPLhI0pHYd755aiJ
        V3r9CFRsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYSGV-0002Yi-NA; Thu, 28 Jun 2018 08:26:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 100A120297645; Thu, 28 Jun 2018 10:26:53 +0200 (CEST)
Date:   Thu, 28 Jun 2018 10:26:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180628082653.GX2494@hirez.programming.kicks-ass.net>
References: <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
 <20180627094633.GG2512@hirez.programming.kicks-ass.net>
 <20180627155721.GZ3593@linux.vnet.ibm.com>
 <20180627175134.GV2494@hirez.programming.kicks-ass.net>
 <20180628051334.GG3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628051334.GG3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:13:34PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 27, 2018 at 07:51:34PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 27, 2018 at 08:57:21AM -0700, Paul E. McKenney wrote:
> > > > Another variant, which simply skips the wakeup whever ran on an offline
> > > > CPU, relying on the wakeup from rcutree_migrate_callbacks() right after
> > > > the CPU really is dead.
> > > 
> > > Cute!  ;-)
> > > 
> > > And a much smaller change.
> > > 
> > > However, this means that if someone indirectly and erroneously causes
> > > rcu_report_qs_rsp() to be invoked from an offline CPU, the result is an
> > > intermittent and difficult-to-debug grace-period hang.  A lockdep splat
> > > whose stack trace directly implicates the culprit is much better.
> > 
> > How so? We do an unconditional wakeup right after finding the offline
> > cpu dead. There is only very limited code between offline being true and
> > the CPU reporting in dead.
> 
> I am thinking more generally than this particular patch.  People
> sometimes invoke things from places they shouldn't, for example, the
> situation leading to your patch that allows use of RCU much earlier in
> the CPU-online process.  It is nicer to get a splat in those situations
> than a silent hang.

The rcu_rnp_online_cpus() thing would catch that, right? The public RCU
API isn't that big, and should already complain afaict.

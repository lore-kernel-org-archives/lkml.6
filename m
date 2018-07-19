Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URG_BIZ,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9634DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474F42084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie9qnVVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474F42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbeGSN6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbeGSN6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:58:20 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF26A20673;
        Thu, 19 Jul 2018 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532006113;
        bh=Eld0MB2d5l2hQnQhLMaf53EFD0TiAyriU6rKi9aBvNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ie9qnVVy0i0Y1/tv/22rlneY1ZLJfs1VPuu4YC+VvB4MKcXOdegVKxECGsA6CzSQs
         WgkoFZMYdnC1MQf23UZP9cBIs5EgtFA0G1y8jJKdZQS9nTkc4smlNBfwn5bJY0uvao
         aWDlw0pJsEK6R6LeGxwebB8Sh4svJP7OSxkzO1/o=
Date:   Thu, 19 Jul 2018 15:15:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180719131509.GD5595@lerouge>
References: <20180709204248.GF3593@linux.vnet.ibm.com>
 <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <20180719003205.GB5595@lerouge>
 <20180719031152.GR12945@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719031152.GR12945@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 08:11:52PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 19, 2018 at 02:32:06AM +0200, Frederic Weisbecker wrote:
> > On Wed, Jul 11, 2018 at 06:03:42PM +0100, David Woodhouse wrote:
> > > On Wed, 2018-07-11 at 09:49 -0700, Paul E. McKenney wrote:
> > > > And here is an updated v4.15 patch with Marius's Reported-by and David's
> > > > fix to my lost exclamation point.
> > > 
> > > Thanks. Are you sending the original version of that to Linus? It'd be
> > > useful to have the commit ID so that we can watch for it landing, and
> > > chase this one up to Greg.
> > > 
> > > As discussed on IRC, this patch reduces synchronize_sched() latency for
> > > us from ~4600s to ~160ms, which is nice.
> > > 
> > > However, it isn't going to be sufficient in the NO_HZ_FULL case. For
> > > that you want a patch like the one below, which happily reduces the
> > > latency in our (!NO_HZ_FULL) case still further to ~40ms.
> > 
> > That is interesting. As I replied to Paul, we are already calling
> > rcu_user_enter/exit() on guest_enter/exit_irqsoff(). So I'm wondering why
> > you're seeing such an optimization by repeating those calls.
> > 
> > Perhaps the rcu_user_* somehow aren't actually called from
> > __context_tracking_enter()...? Some bug in context tracking?
> > Otherwise it's a curious side effect.
> 
> David is working with v4.15.  Is this maybe something that has changed
> since then?

Hmm, nope I think the context tracking code hasn't changed for a while.

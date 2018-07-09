Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE75920896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qbiWpxfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE75920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGILcD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:32:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeGILb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O8efGWUQRjSlici3C8/Ci9M5fWEFfYjJoKyJmtr3UPg=; b=qbiWpxflm2ZVt2xqt1j83Z2p0y
        JYbn7mkmui+m6Tp8XX1t/eR82kjx0+xdwebadlLyE0ii5yZwmkw6bFtxxCNF3jE0GZ2qApSSfAvAS
        hxYGLNbUR6aO44Y4oUvnPlGu68uSoG5L2EK3Ey8Kfl+tW2Tu0lTakcNRc3heTP7ENTGHNb2nftbC0
        i2KS0edy6SMUUDsJDTHNoCSokTxDoYFLioX/0dmbOhok1b6dKq+3ZhmuF+lLxbbkwQE7sBsA/VPGt
        4V1WURWmDE8WaM5WLoJ/V54CCgRDNOtvgmM+VYcC+liwGsNCsXygq98Asn+66W+gYZ0gpyCzIggXK
        2927D8XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcUOa-0007qn-Le; Mon, 09 Jul 2018 11:31:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE06D2028932C; Mon,  9 Jul 2018 13:31:54 +0200 (CEST)
Date:   Mon, 9 Jul 2018 13:31:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        mhillenb@amazon.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709113154.GM2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
 <20180709104429.GI2476@hirez.programming.kicks-ass.net>
 <1531133801.18697.73.camel@infradead.org>
 <20180709110657.GL2476@hirez.programming.kicks-ass.net>
 <1531134735.18697.77.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1531134735.18697.77.camel@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 12:12:15PM +0100, David Woodhouse wrote:
> On Mon, 2018-07-09 at 13:06 +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 11:56:41AM +0100, David Woodhouse wrote:

> > > > But either proposal is exactly the same in this respect. The whole
> > > > rcu_urgent_qs thing won't be set any earlier either.

> > > Er.... Marius, our latencies in expand_fdtable() definitely went from
> > > ~10s to well below one second when we just added the rcu_all_qs() into
> > > the loop, didn't they? And that does nothing if !rcu_urgent_qs.

> > Argh I never found that, because obfuscation:
> >=20
> > 	ruqp =3D per_cpu_ptr(&rcu_dynticks.rcu_urgent_qs, rdp->cpu);
> > 	...
> > 		smp_store_release(ruqp, true);
> >=20
> > I, using git grep "rcu_urgent_qs.*true" only found
> > rcu_request_urgent_qs_task() and sync_sched_exp_handler().
> >=20
> > But how come KVM even triggers that case; rcu_implicit_dynticks_qs() is
> > for NOHZ and offline CPUs.
>=20
> I don't know that it is; I'm merely going by the empirical observation
> that with a check for rcu_urgent_qs in the vcpu_run() loop, KVM is no
> longer screwing over synchronize_sched() for 10 seconds at a time. Or
> even 1 second at a time.

It would be good to know what exactly sets that variable in your case.

> I'm all for considering a CPU in guest mode to be quiescent, and not
> waiting for it at all. But we don't do that without full NOHZ even for
> CPUs in userspace.

Doing it for guests should be easier than for userspace, since
vmenter/vmexit are (afaik) _much_ more expensive than sysenter/sysexit.

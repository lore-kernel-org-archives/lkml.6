Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E0120673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3VPY+Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E0120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeGII6q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:58:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeGII6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TWdejK2UT1oPo9yeE9FelK7Ic5NZ4j3psiUxCxck3dU=; b=W3VPY+PiVsUf0kOq90ReMfGqcp
        /6NGogHvBDIPqCZ1hm5txoWIUfkLsgXwvf++bybgjFsxwiUp7fTgBPvbcLVEPCOdlkpJND3C4yWBa
        9ronRdXO9AK+f66JiZD3P11YO8ev0BDU5T9h0/XOXGXC1V3UEoF85J0AcOoltvzG65J1icX8eqyJa
        xp8Jmw2o0PULZCcD/yO2MlhfxTgsFbDf6uZ38qgaNLYbeKosoQuNvioqX18D3r3s5zmvvA+gaolIj
        hF70JqvXEa6GAZSyJkLmqJDlsVRMCPjVRAecNT1eT7K0DPjmPv8bjNWDQhmB365n9XEj77wb6umg5
        dJXtLzFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcS0E-0005U9-RF; Mon, 09 Jul 2018 08:58:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80ABB2028932D; Mon,  9 Jul 2018 10:58:37 +0200 (CEST)
Date:   Mon, 9 Jul 2018 10:58:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     paulmck@linux.vnet.ibm.com, mhillenb@amazon.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709085837.GD2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <1530897284.18697.24.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1530897284.18697.24.camel@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:14:44PM +0100, David Woodhouse wrote:
> On Fri, 2018-07-06 at 10:11 -0700, Paul E. McKenney wrote:
> > > The preempt state is alread a bit complicated and shadowed in the
> > > preempt_count (on some architectures) adding additional bits to it li=
ke
> > > this is just asking for trouble.
> >=20
> > How about a separate need_resched_rcu() that includes the extra cache
> > miss?=A0 Or open-coding the rcu_urgent_qs_requested()?
>=20
> Peter said "touch two cachelines". He didn't say it was a cache miss.
>=20
> Given that every single cond_resched() call touches the same cache
> line, and every single rcu_all_qs() and similar will also touch it,
> it's fairly much guaranteed *not* to be a miss...

cond_resched() is a no-op for PREEMPT=3Dy, but then you're still
sprinkling that read all across.

> ... which is why I didn't really understand why he cared.

Well it also complicated the whole preemption state, and like I wrote,
TIF_NEED_RESCHED is not the only place we track preemption state in.

Stuff like preempt_enable() will (on x86) only ever look at the
preempt_count value.


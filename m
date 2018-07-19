Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URG_BIZ,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2D42084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcSiz76p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2D42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeGSOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbeGSOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:00:37 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F46020673;
        Thu, 19 Jul 2018 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532006249;
        bh=ucpRSV+cDY1Hbw7wFJeGB0/UhwRraBToGOqq2y2HYJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcSiz76p7rf7vSQ2pQx9ryON3BbvmUJX7DwxQvdzKmdFu+6ycVvUnf6qCwPetgpn3
         i12e49SB22D6UDwN5k0CahOWZre1m5236iMaeEQnZLAmV8vI9YmJPSPmMJBexn9M5L
         FCrX22tohp81hlC2kKXchekFsswNgRXGIZEF38Mc=
Date:   Thu, 19 Jul 2018 15:17:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        mhillenb@amazon.de, linux-kernel <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180719131726.GE5595@lerouge>
References: <1531169145.26547.8.camel@infradead.org>
 <20180709210532.GH3593@linux.vnet.ibm.com>
 <20180709220823.GA18045@linux.vnet.ibm.com>
 <1531319025.8759.57.camel@infradead.org>
 <20180711144303.GQ3593@linux.vnet.ibm.com>
 <20180711164952.GA29994@linux.vnet.ibm.com>
 <e21c6d7666bfbad1e1c8295559a6ddc7e4110105.camel@infradead.org>
 <20180719003205.GB5595@lerouge>
 <20180719031152.GR12945@linux.vnet.ibm.com>
 <1531981007.12620.7.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531981007.12620.7.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:16:47AM +0200, David Woodhouse wrote:
> 
> 
> On Wed, 2018-07-18 at 20:11 -0700, Paul E. McKenney wrote:
> > 
> > > That is interesting. As I replied to Paul, we are already calling
> > > rcu_user_enter/exit() on guest_enter/exit_irqsoff(). So I'm wondering why
> > > you're seeing such an optimization by repeating those calls.
> > > 
> > > Perhaps the rcu_user_* somehow aren't actually called from
> > > __context_tracking_enter()...? Some bug in context tracking?
> > > Otherwise it's a curious side effect.
> > 
> > David is working with v4.15.  Is this maybe something that has changed
> > since then?
> 
> To clarify: in 4.15 without CONFIG_PREEMPT and without NO_HZ_FULL I was
> seeing RCU stalls because a thread in vcpu_run() was *never* seen to go
> through a quiescent state. Hence the change to need_resched() in the
> first patch in this thread, which fixed the problem at hand and seemed
> to address the general case.
> 
> It then seemed by *inspection* that the NO_HZ_FULL case was probably
> broken, because we'd failed to spot the rcu_user_* calls. But
> rcu_user_enter() does nothing in the !NO_HZ_FULL case, so wouldn't have
> helped in the testing that we were doing anyway.

Oh ok, so the optimization you saw is likely unrelated to the rcu_user* things.



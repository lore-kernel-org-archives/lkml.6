Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB45EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A03218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551309284;
	bh=lIkz/CRnM9M0vo0FQiTPA9AonFhNqaDo6VfmoeZmQ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ePYZTAndv0vUbqGp2ogt812Z+HowSSou6bDYCfs3SRAO65XbCWbiyoupPrA/GvmHS
	 oXRQbjrnK6xjdXMKw8fqNugmY8Wa16k+l+4uoZRm6vLfijcT3RAESD0PNGdAjr7n09
	 E6MMpCrRQu+xwQphU1Qse10nZE+TyRcZh9Z9ab2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfB0XOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0XOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:14:42 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B936213A2;
        Wed, 27 Feb 2019 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551309281;
        bh=lIkz/CRnM9M0vo0FQiTPA9AonFhNqaDo6VfmoeZmQ8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbrYwAqV+jyhWz0z256/vO2w1qydrJ0qp7NnusPtWJKTUXy1O66p0Cr/pJzD0z2dN
         RbUB16Ws+6OKi3SUOmeMKragSU0NU5g+qduIOc7uZG+VRZWaDR9uyQyhysaV/R1gug
         KY5dIkqSGBVHYava+Ay9ncptYd2RCOS4qe/Djevs=
Date:   Thu, 28 Feb 2019 00:14:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 24/32] softirq: Uninline !CONFIG_TRACE_IRQFLAGS
 __local_bh_disable_ip()
Message-ID: <20190227231438.GF15294@lerouge>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-25-frederic@kernel.org>
 <20190227111429.6gt7vfvewmpt6xkf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190227111429.6gt7vfvewmpt6xkf@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 12:14:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-02-12 18:14:15 [+0100], Frederic Weisbecker wrote:
> > diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
> > index 240419382978..ef9e4c752f56 100644
> > --- a/include/linux/bottom_half.h
> > +++ b/include/linux/bottom_half.h
> > @@ -28,17 +28,7 @@ enum
> >  
> >  #define SOFTIRQ_DATA_INIT (SOFTIRQ_ALL_MASK << SOFTIRQ_ENABLED_SHIFT)
> >  
> > -
> > -
> > -#ifdef CONFIG_TRACE_IRQFLAGS
> >  extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
> > -#else
> > -static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> > -{
> > -	preempt_count_add(cnt);
> > -	barrier();
> > -}
> > -#endif
> 
> you are aware that a simple local_bh_disable() / spin_lock_bh() gains a
> function call. Let me look further how much code you are going to add
> here…

Indeed but as you'll find out, the function is growing beyond reasonable inlining.

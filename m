Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URG_BIZ,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3E20862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZkd/CB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B3E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbeGIKoj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:44:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jomamgINfgnhEAhe62iptklla9EUYrvVjiUu9TKEYDg=; b=QZkd/CB6eYYoay1j7h4FmH6Wb+
        cY1pq3ReKdkeYHwpqLP5xfmG6vIXBM67gLzxPRYIgnSGdFDHuCsYW6pSqc3EbfI1UoPi+9EUIva0i
        zIHZp4FN9RAhcVmSwTWj5MzzQbGWv+7z+d8XUx7iIbWpxHL1KqTo6uT05GiSeYpqavBWt+2Z0gK9B
        sXti9E+EfiWwyVvXjsaD2U/fuCKQPpgXNjmFFJ7odXIQ7elnxG3Q+Q6E9snKbCOINK6QCky7xjsgZ
        wx65V7AsagVwRINlHkfABv7X0SkaA8Rt4atxz6aNMIzTYAPb3TQa8l0vJ0RrGZXz1OZIAMZ9a7Hwl
        oKNrAufQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcTei-0006o3-0J; Mon, 09 Jul 2018 10:44:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63A252029764D; Mon,  9 Jul 2018 12:44:29 +0200 (CEST)
Date:   Mon, 9 Jul 2018 12:44:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        mhillenb@amazon.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Make need_resched() return true when rcu_urgent_qs
 requested
Message-ID: <20180709104429.GI2476@hirez.programming.kicks-ass.net>
References: <bb77e730a5ada3689650b636e1dd03ac5cc87256.camel@infradead.org>
 <20180706162905.GZ2476@hirez.programming.kicks-ass.net>
 <20180706171150.GI3593@linux.vnet.ibm.com>
 <20180709085351.GC2476@hirez.programming.kicks-ass.net>
 <1531127935.18697.57.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1531127935.18697.57.camel@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:18:55AM +0100, David Woodhouse wrote:
> > Which seems like an entirely reasonable amount of time to kick a task.
> > Not scheduling for a second is like an eternity.
>=20
> If that is our only "fix" for KVM, then wouldn't that mean that things
> like expand_fdtable() would be *expected* to take "an eternity" when
> another CPU happens to be in the guest? Because vcpu_run() would still
> loop until the task gets kicked after a second?

But either proposal is exactly the same in this respect. The whole
rcu_urgent_qs thing won't be set any earlier either.

> Of course, we can explicitly put a check into the KVM loop, but that
> brings me back to my original concern =E2=80=94 why is it OK to do it the=
re as
> a special case and not for the general case construct of
> if (need_resched) { drop_local_locks(); cond_resched(); get_local_locks()=
; }

I'm not proposing anything that would differentiate between KVM and
anything else.

I just want to keep my preemption state sane-ish, and adding random
conditions to part of it just doesn't look attractive.

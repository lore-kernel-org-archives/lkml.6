Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065C820645
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IskHqcEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfBTSIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:08:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40526 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTSIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:08:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so28260173qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pT2WI0iYdHDoEv6W67natUFu/U0PIMIh3oiHvWB9Li4=;
        b=IskHqcEIb+j0Hr9YWTsw4EwjQZ1y0epU44bLymSuQLCL8+mdGBhjBsAmMHtH/Q4yGC
         GeEpCHTWvIlLy6xN+KyKLuQ0xF9stEoModZlE3iJXxeAF1pSr+v3m5mImc/8FP4zX5nq
         J/6OuXkT+mtllSddOjoithFjgijYe21Obtzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pT2WI0iYdHDoEv6W67natUFu/U0PIMIh3oiHvWB9Li4=;
        b=e/CZccAOhHvc7H+UifB+BAGc7/OqB4EcaqDudPDMvcG8ISuEfU09clJdReZUM+H63S
         KdLf9bpOFB7rlfiPa7w4F46NwDqPkrcZrktHvjh0qwIFyfhd6dTAz2fA60OgChlWySmw
         cOlZnfaoQpSkyQtUxGqVnarHYdJtUD4TlIxnS7gnaqdtXzprRQruTJ3vuV9hNp57Hy9x
         dbFWJwL8EOIdSYO4NXleSUJe23rbKivOzJPrlvP+OQkHUDPes5OyHkWXhf8S7HZXE9tQ
         o1+Qynteox1cvYX++qS5kV6AcWA5r3qONInBF19YDMUtv+vNGdOlSOBKft1Pd5eHk4fw
         h4pQ==
X-Gm-Message-State: AHQUAubPOEmkCPGi5PcnIz2wHhA6UARooS/J/mCGQXOokwQ9wq/3sjx6
        /oGBeZ+PmtlSX3QPP4O2KJFR53tOdTo=
X-Google-Smtp-Source: AHgI3IbHWu4ookQBe4LW6YH+cyRiGfmunzr9kAgr2a/tA4FcJFa7g6q642fJNNAxDPPZUlubA6rCag==
X-Received: by 2002:aed:302f:: with SMTP id 44mr11626107qte.178.1550686133160;
        Wed, 20 Feb 2019 10:08:53 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id j66sm11831189qkj.27.2019.02.20.10.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:08:51 -0800 (PST)
Date:   Wed, 20 Feb 2019 13:08:51 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [RFC 1/5] net: rtnetlink: Fix incorrect RCU API usage
Message-ID: <20190220180851.GA97771@google.com>
References: <20190220040827.136184-1-joel@joelfernandes.org>
 <20190220040827.136184-2-joel@joelfernandes.org>
 <20190220164034.GM11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220164034.GM11787@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:40:34AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 19, 2019 at 11:08:23PM -0500, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> > 
> > rtnl_register_internal() and rtnl_unregister_all tries to directly
> > dereference an RCU protected pointed outside RCU read side section.
> > While this is Ok to do since a lock is held, let us use the correct
> > API to avoid programmer bugs in the future.
> > 
> > This also fixes sparse warnings arising from not using RCU API.
> > 
> > net/core/rtnetlink.c:332:13: warning: incorrect type in assignment
> > (different address spaces) net/core/rtnetlink.c:332:13:    expected
> > struct rtnl_link **tab net/core/rtnetlink.c:332:13:    got struct
> > rtnl_link *[noderef] <asn:4>*<noident>
> > 
> > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> 
> First, thank you for doing this!

No problem, it is my pleasure. It is just good to see these warnings/errors
show up (which I didn't anticipate when I first wrote the check) so we can
harden the kernel more fwiw.

> I was going to complain that these were update-side accesses, but it
> looks like rtnl_dereference() already handles both readers and updaters.
> 
> So looks good to me, but the maintainers of course have the final word.

Thanks!
Also my confidence level is a bit less for patches 4/5 and 5/5, could
you share your thoughts on those? The scheduler code seems to use
rcu_assign_pointer() in those where it seems a WRITE_ONCE() would just suffice.
In fact, in some cases I replaced with smp_store_release() just to be safe.
Speaking of which, do you feel those are legit uses of rcu_assign_pointer()
or would you expect rcu_assign_pointer() to be used only for RCU protected
pointers? I am hoping it is the latter since that is what the sparse check
expects (and RCU protected pointer being assigned to).

 - Joel


> 
> > ---
> >  net/core/rtnetlink.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 5ea1bed08ede..98be4b4818a9 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -188,7 +188,7 @@ static int rtnl_register_internal(struct module *owner,
> >  	msgindex = rtm_msgindex(msgtype);
> >  
> >  	rtnl_lock();
> > -	tab = rtnl_msg_handlers[protocol];
> > +	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
> >  	if (tab == NULL) {
> >  		tab = kcalloc(RTM_NR_MSGTYPES, sizeof(void *), GFP_KERNEL);
> >  		if (!tab)
> > @@ -329,7 +329,7 @@ void rtnl_unregister_all(int protocol)
> >  	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
> >  
> >  	rtnl_lock();
> > -	tab = rtnl_msg_handlers[protocol];
> > +	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
> >  	if (!tab) {
> >  		rtnl_unlock();
> >  		return;
> > -- 
> > 2.21.0.rc0.258.g878e2cd30e-goog
> > 
> 

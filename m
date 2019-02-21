Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E235C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE802084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fYBG4xnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfBUQu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:50:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38751 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfBUQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:50:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id p15so4657233qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBBhCoeKpttPaQMOknmmQ2P1Xg+jsnN0CQLcp0wpahw=;
        b=fYBG4xnlbC5DQ8gkLI0CKlqX7wWFM1sPSV7BJaovKdEVs3oP1soYWFSQj1e/iWmDXo
         JvPW4QX2V4RQdX+wZg3BQJxNCkvuUw38UEbvVbArN/nlNnp4DRx+2vyXNKa167mJd+Uh
         32433vQvRhe33BK8rLOFCNTOR1xspVl8eU69c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBBhCoeKpttPaQMOknmmQ2P1Xg+jsnN0CQLcp0wpahw=;
        b=h+2OlAPkFNwov6/26MwI6MWN7UpHbdL7Jz+TfcAJcZWuK9BErECHY3yek6NhpFdx9W
         2tkWlFgI4/ynVMrmCv1OfeOMr5ZgyUy5Ly8DRCDL4Tsub24wZHaDPxYYbA+lLkP4OvxR
         XCgZtABddUsn+QB7h+9AZcbhsNDWWLbv6GxuuPoIWJzrbEzd4/KLbRex0IkUrBkBq/Ek
         Inc2y6XeYwuCM34W+cHc1ArQAme6wp5MjppzM2OedGzG5PGoQeQGCCqfuz800JiQDXPY
         w7MXVzYvMH/5sBey8F7hyQ9X5y5hmOcINDJ5ec3cBS614KZsrL4hoo7BavYn7dyF6Gjx
         4usg==
X-Gm-Message-State: AHQUAub11gJfA0iCgo314CsIYCnNJtc2ejex+OUIFc6LMnVTcCfnlMF3
        XRc+vENYbIUwTvZBM/VAFhhHx+vs8VA=
X-Google-Smtp-Source: AHgI3IY10uCVkqNnFEIaAC9ZN6b60+ShwGhv+lAmMOyPrkK8XQTnSjgz3Rjob1zmsANREgQhCItNCg==
X-Received: by 2002:a37:32c7:: with SMTP id y190mr29874301qky.345.1550767825821;
        Thu, 21 Feb 2019 08:50:25 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id v18sm11280949qkj.13.2019.02.21.08.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 08:50:23 -0800 (PST)
Date:   Thu, 21 Feb 2019 11:50:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
Message-ID: <20190221165022.GA103806@google.com>
References: <20190220040827.136184-1-joel@joelfernandes.org>
 <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
 <20190220164242.GN11787@linux.ibm.com>
 <20190220180952.GB97771@google.com>
 <20190220182820.GO11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220182820.GO11787@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:28:20AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 20, 2019 at 01:09:52PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 20, 2019 at 08:42:43AM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 19, 2019 at 08:11:36PM -0800, Joel Fernandes wrote:
> > > > On Tue, Feb 19, 2019 at 8:08 PM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > >
> > > > > These patches fix various RCU API usage issues found due to sparse errors as a
> > > > > result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
> > > > >
> > > > > This is very early RFC stage, and is only build tested. I am also only sending
> > > > > to the RCU group for initial review before sending to LKML. Thanks for any feedback!
> > > > >
> > > > > There are still more usages that cause errors such as rbtree which I am
> > > > > looking into.
> > > > 
> > > > Looks like it got sent to LKML anyway, ;-) That's Ok since it is
> > > > prefixed as RFC.
> > > 
> > > As is only right and proper.  ;-)
> > > 
> > > I don't see an immediate problem with them, but it would be good to get
> > > the relevant developers and maintainers on CC for the next version.  I
> > > cannot claim to know that code very well.
> > 
> > Definitely will CC them next time, sorry about that. I'll stop being so shy
> > but I have some scars that are still healing ;-)
> 
> If you don't get at least a few scars, you aren't trying hard enough!  ;-)

Well said ;-) I noted this as a quote in my "famous quotes list" ;)

thanks,

 - Joel

Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6877020645
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WbT9qddU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfBTSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:09:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39494 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfBTSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:09:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so28274417qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1cWhkqKwfVl97PNcjmjtwuG+Olh/UWCMwWrW24lQqxM=;
        b=WbT9qddUPijPvnGLexnd0oc3f3xnZ7u9gZIsN6pODW5a9+CxWzPF/nFpiPu3kJ/wpm
         9wx++wrlscUDwEX2iOrkOs7mnW9bP+GndwayOmMPArQIO4RMUpSyZu9/uojnop8O/4/P
         Nf3v82PWxZkpO980hO8TH/4Eqjc7y3xCZJ2AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1cWhkqKwfVl97PNcjmjtwuG+Olh/UWCMwWrW24lQqxM=;
        b=S6lcW7YlXawi/USZpSnuDCjbDn2lvvXHhsiY1s5LRnWAPEFPJPHZov0tUX/PTNodos
         xZwlXXwnJ8bLIb6TaI11E+oROK24GzNJJI/XEDy1ds2Ng12ldLmLGvtygmz5jCtw0gyJ
         g1u+XFQV+3UOS3pjhuAL0s5XIuMgwkBQxi6tlfPsOVbY88WomZY7VfmGvyievcS8jORh
         /YRjuBP46tSLQvIBJv6pI6EOifQMUrkdVrtSfmWKWJMEjRvfYk9CM8MWKrEFrKRq/+c9
         xgg6+G97vkJw8SaGnEsDToho0LjwWV+YoNp0nzu3rLaV8mZofzCcoXf9yXoRFVU7RGOK
         Q93Q==
X-Gm-Message-State: AHQUAuZgtAejKYXaP/KGLn8YdF3X2E+JkeZgepYPfd52q+2yq+OgIsz/
        XrlJ6IQg2B4f2XGQYdwRmu/orA==
X-Google-Smtp-Source: AHgI3IZ27RUnaOjU+KMm0fqd88cEd0GXvVfhBcyzjVldiBZp2tj0TppMxcaKGX0vvlDfKxkNCQtccQ==
X-Received: by 2002:ac8:2fd1:: with SMTP id m17mr3623322qta.301.1550686194620;
        Wed, 20 Feb 2019 10:09:54 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id z41sm14068619qtz.5.2019.02.20.10.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:09:53 -0800 (PST)
Date:   Wed, 20 Feb 2019 13:09:52 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
Message-ID: <20190220180952.GB97771@google.com>
References: <20190220040827.136184-1-joel@joelfernandes.org>
 <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
 <20190220164242.GN11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220164242.GN11787@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:42:43AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 19, 2019 at 08:11:36PM -0800, Joel Fernandes wrote:
> > On Tue, Feb 19, 2019 at 8:08 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > These patches fix various RCU API usage issues found due to sparse errors as a
> > > result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
> > >
> > > This is very early RFC stage, and is only build tested. I am also only sending
> > > to the RCU group for initial review before sending to LKML. Thanks for any feedback!
> > >
> > > There are still more usages that cause errors such as rbtree which I am
> > > looking into.
> > 
> > Looks like it got sent to LKML anyway, ;-) That's Ok since it is
> > prefixed as RFC.
> 
> As is only right and proper.  ;-)
> 
> I don't see an immediate problem with them, but it would be good to get
> the relevant developers and maintainers on CC for the next version.  I
> cannot claim to know that code very well.

Definitely will CC them next time, sorry about that. I'll stop being so shy
but I have some scars that are still healing ;-)

 - Joel


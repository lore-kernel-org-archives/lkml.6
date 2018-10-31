Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F64DC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9FD2082D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f08xUURQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9FD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeJaJyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:54:23 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:38714 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeJaJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:54:23 -0400
Received: by mail-pl1-f176.google.com with SMTP id p7-v6so6408073plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZrgIeTJCWfM/yMRtRMDFPWrgHzZ/yIYWaewABwwGic=;
        b=f08xUURQ/e38kDmAvszAQGfcbPcLQD7Hs3F7pWqZzkvXXhOASeFQvYTodsvsZh7n+a
         YfrqIdyvXRTgF4JGSOoRLFNop9tUyVqsvU+ZTDaHgrMmKLwEtWTDszxgt3InY0vZJVt/
         fEHkwMjx6k6tM66iK4NIdFlJcbVixM5RL3gig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZrgIeTJCWfM/yMRtRMDFPWrgHzZ/yIYWaewABwwGic=;
        b=iycy3Bg2e4tbkXERnlTt3ifPLhlyap/jafX63bQukKGiwSlne8PSP3m4Bixi59Ynn+
         Mx/vEZQDd8AJWvRRLEuDGslvO0vhFUXEKNDoazJ9X0bkbrkV8Uk8wMxuEZdyYigiOfbq
         mCJISmf2zdFo6X5+zEYy1tftUybpdExWp1axVxIyPpA7oHzJ39Yb/i9GG2TOX3lgSixK
         3c/5eAEOrJ3uUMFeRXAoUvy0VTmlWZIvhFtH8l9CN2YUT6ti9plMEGIRytqzYwWRqkRC
         MRtMk9l7jK25XUsxNkYxtzXPtsVjL50AVaTE532+w0tGdV2NqNmuLZlRBRW/Ke/Mt/hV
         aa/A==
X-Gm-Message-State: AGRZ1gJEn+S2jzRPIjaJj9tmqtt1fDio52xbotSwlFNr85tCfnkDf/2x
        +M8L79xEZd8X1ZBUCoF9Mh77NQ==
X-Google-Smtp-Source: AJdET5cVpMyU05VjI5jlH6sz9GCTNgeQJNkwa3Ho+yChC/iySKcxDVa9w6XrsIlPvoEB7NnHcRum3A==
X-Received: by 2002:a17:902:9a44:: with SMTP id x4-v6mr1002955plv.121.1540947516062;
        Tue, 30 Oct 2018 17:58:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id p15-v6sm1779044pfj.72.2018.10.30.17.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 17:58:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:58:33 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] rcu: doc: update example about stale data
Message-ID: <20181031005833.GE224709@google.com>
References: <20181028021653.155513-1-joel@joelfernandes.org>
 <20181028172142.GN4170@linux.ibm.com>
 <20181029011631.GA261737@joelaf.mtv.corp.google.com>
 <20181030235039.GX4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030235039.GX4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:50:39PM -0700, Paul E. McKenney wrote:
> On Sun, Oct 28, 2018 at 06:16:31PM -0700, Joel Fernandes wrote:
> > On Sun, Oct 28, 2018 at 10:21:42AM -0700, Paul E. McKenney wrote:
> > > On Sat, Oct 27, 2018 at 07:16:53PM -0700, Joel Fernandes (Google) wrote:
> > > > The RCU example for 'rejecting stale data' on system-call auditting
> > > > stops iterating through the rules if a deleted one is found. It makes
> > > > more sense to continue looking at other rules once a deleted one is
> > > > rejected. Although the original example is fine, this makes it more
> > > > meaningful.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Does the actual audit code that this was copied from now include the
> > > continue statement?  If so, please update the commit log to state that
> > > and then I will take the resulting patch.  (This example was inspired
> > > by a long-ago version of the actual audit code.)
> > 
> > The document talks of a situation that could be but is not really in the
> > implementation. It says "If the system-call audit module were to ever need to
> > reject stale data". So its not really something implemented. I was just
> > correcting the example you had there since it made more sense to me to
> > continue looking for other rules in the list once a rule was shown to be
> > stale. It just makes the example more correct.
> > 
> > But I'm Ok if you want to leave that alone ;-) Hence, the RFC tag to this
> > patch ;-)
> 
> Well, I do agree that there are situations where you need to keep
> going.  But in the common case where only one instance of a given key
> is allowed, and where the list is either (1) sorted and/or (2) added
> to at the beginning, if you find a deleted element with a given key,
> you are guaranteed that you won't find another with that key even if
> you continue scanning the list.  After all, if you did find a deleted
> element, the duplicate either is not on the list in the sorted case
> or is behind you in the add-at-front case.
> 
> And in the more complex cases where persistent searching is required,
> you usually have to restart the search instead of continuing it.  Besides,
> things like the Issaquah Challenge don't seem to belong in introductory
> documentation on RCU.  ;-)

Ok, agreed. Lets drop this :)

-Joel


Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F404C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050722083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z3XnVtPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050722083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964980AbeFSWQ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:16:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44196 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935772AbeFSWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:16:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so575679plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8UWr9O3ex54iCQ0tic1OW60FxJcSug1Pyl9svIdHlI=;
        b=Z3XnVtPU94nY0v3kT5mhrKG8q2I0hJHkT2SdnB9JrcFohqq7J2YDHZf3x1vPOFTKop
         qkcXxfcDc2GeU7tYFQ32xhHcRn9bZpNI6SvCuf+0U0oK6xorpWkf8JFbPVaUokzJmFPk
         RzOlRqNkFjqwVy1HMihMkqYiW76O0NQB+3FjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8UWr9O3ex54iCQ0tic1OW60FxJcSug1Pyl9svIdHlI=;
        b=Lw7HXyL5hJtL9RUG3oiwKDAfBKFslrSujcA3XKxVSWNhAfTzIMZPq3icCmAKm37y2L
         PXPgtW92ZRq7Djtzz7tKrB/77ntGRDtu7tIFgb+DmQdGBKnomUMWlCL+Yhtwm52jYtqd
         9+3vzpG0kcxs5kwxXyrOOoQj75opVAXxXAtfhMUG2DVaQyJBzr7quAsjnRYhkYhyYVb8
         E9CPMfcSRkEjZ94sokcLvSbwMMt860kDaQS3qoljsz2BpAHZMpdQI3mM5exATauhbBNW
         SaVbCns/7h6e1hE3Tc1IYaf80XCNrCVOWYwWh+vVoqGjxECFIzRwm0w4XdfZmjaGjMBP
         ruew==
X-Gm-Message-State: APt69E1l4crexB2U/goOfVjCpwqC75J6/mUe0Hz2NJQtRBdQOCDm+0S1
        YN3PB3Yl9J0odleE4cg3NriyYg==
X-Google-Smtp-Source: ADUXVKJcrZijn+1b1cDikAxHectttZt7jr+KnQRDa+T/oCI7uLtPrX+40Nso5hYxFP+Q2ctHsNRqIw==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr20330170pli.263.1529446610897;
        Tue, 19 Jun 2018 15:16:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k12-v6sm807678pff.31.2018.06.19.15.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 15:16:50 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:16:49 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH 2/2] rcutorture: Fix rcu_barrier successes counter
Message-ID: <20180619221649.GA41539@joelaf.mtv.corp.google.com>
References: <20180619062215.221564-1-joel@joelfernandes.org>
 <20180619062215.221564-2-joel@joelfernandes.org>
 <20180619073115.GA241700@joelaf.mtv.corp.google.com>
 <20180619091223.702f05d6@gandalf.local.home>
 <20180619154139.GG3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619154139.GG3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 08:41:39AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 19, 2018 at 09:12:23AM -0400, Steven Rostedt wrote:
> > On Tue, 19 Jun 2018 00:31:15 -0700
> > Joel Fernandes <joelaf@google.com> wrote:
> > 
> > > Hi Paul,
> > > Think some more about this counter, I think you mean 'successes' as in
> > > 'successful attempts' than 'successful test' ? If so, then perhaps you can
> > > drop this patch. It wasn't clear to me what the 'successes' meant so I may
> > > have been a bit misled into changing its meaning. If on the other hand, it
> > > means 'successful test', then yes this patch would be Ok then. thanks! -Joel
> > 
> > In either case, it sounds like a comment should be added to clarify
> > what n_barrier_successes actually means ;-)
> 
> Or change the name to n_barrier_attempts.  Except that there already
> is an n_barrier_attempts, and it is incremented on each attempt.
> 
> So perhaps the original patch is on-point.  ;-)

Cool, added a comment just to clarify it and resent the updated patch.

thanks!

 - Joel

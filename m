Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F67C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152A720647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sTOi2QyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152A720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbeG0XLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:11:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36585 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389752AbeG0XLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:11:39 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so2842313plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oczDwl+rIE9M+ae0ORJEqX6A3OhoKq5Fvy9Bs2DgoIU=;
        b=sTOi2QyG1tmcZVs3E9YtNmBvBDlQxI34jKoPzBzz23xTqoFMzEq9TXPXxM793AdVBf
         dGmf+O1i9JGNFiV8qL6aGEqSVbpBiBVlBUmeveJZCmPL/ubnKWJoXVExufow4GoZhKD2
         t7up1/Evyka7DAutdwne7c1BpO0+sMWsnvLOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oczDwl+rIE9M+ae0ORJEqX6A3OhoKq5Fvy9Bs2DgoIU=;
        b=MWobINlqhW6U8LiYZZgpk9fosnnCMTzxYC6R/tqSLBqPiRdhr3Y0BPs3HrzTfTda4o
         izjIf8ouSy0UPNTxkVQ58mWKa9bP/tXxgmksprf4S5TTb8CgD2+R/Byzr7jrZNMbGjqd
         9Nrug0Dz++9OtkkYHu5SEbPSXW0nq8W6fFSGa7cYIQdC3A8TlTewksaZGEcyyohQxHLA
         A+xICpW8jiuwmqj88jsXnovOMRurSW4FgiNk1gTrJ0PdjCkQhfqd7qJy723kEb2tyUVC
         BiIAyr7hSxOmy5jZxTAV7As/KRlZMZ3nlKq+g67Vy4HgBs5tVLRuvdBsqNZ5v/yfQdJm
         SGbQ==
X-Gm-Message-State: AOUpUlErynQCxtcvwHp778VpcI/XtNXrWKMoxivc5rJAm2sF3aZ/7uqN
        BkPKbVv7D7jCP14f4LMmVzRp9mjE7I8=
X-Google-Smtp-Source: AAOMgpeBDy6YbnyZxQQkVHW9kieRkzQFeZcuuybB+FWw/yJjq1+XphKt7+vIV8yud8KFJ8NFczGP5w==
X-Received: by 2002:a17:902:8d96:: with SMTP id v22-v6mr7440688plo.176.1532728070598;
        Fri, 27 Jul 2018 14:47:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q81-v6sm12540813pfd.15.2018.07.27.14.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:47:49 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:47:49 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180727214749.GC83926@joelaf.mtv.corp.google.com>
References: <20180726235044.10195-1-joel@joelfernandes.org>
 <20180726235044.10195-3-joel@joelfernandes.org>
 <20180727122659.524dd13f@gandalf.local.home>
 <20180727185113.GA83926@joelaf.mtv.corp.google.com>
 <20180727145744.2a4464d8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727145744.2a4464d8@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:57:44PM -0400, Steven Rostedt wrote:
> On Fri, 27 Jul 2018 11:51:13 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > When I refactored the code as Peter suggested I happen to move the warning
> > out but didn't simplify it further (I had it at the back of my head to do
> > that but missed it).
> > 
> > Since its quite a simple change I can send a follow up patch doing so later,
> > or can resend this one. What do you suggest?
> 
> I'll do it myself if that's OK with you.

Yes, sure Steve. Thanks for doing it.

Regards,
- Joel

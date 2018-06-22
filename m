Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABFBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A257023D96
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NGxXt8By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A257023D96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeFVF5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:57:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36288 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeFVF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:57:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so2480680pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4CmSoGOyfjxK1VLs9xSjx7mW5J/v48ecLBzt8CKuPE=;
        b=NGxXt8ByiOtYH9eDDksGgYU6+0KFdDFuuaO3g16dzchMf+uG9v4+nSFt++a96seIdd
         v8zA+lunwD53cyv9KBKQbwDsrtK4RKqcRLfCYUBAjwQuHuymO+EBohiFcMonEGtoz/rz
         sAX67AfA0RD+7lOL6dfdQsV6n7pHwWTqJbhJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4CmSoGOyfjxK1VLs9xSjx7mW5J/v48ecLBzt8CKuPE=;
        b=ImnqNO9dx+W+9aL9N90xpm7dEA8fN2LofMEI39qzLCnYKOxqFOrTSr1n8AktHTHapC
         +ng4YYeRifi7V+9HXY7IUfXn+F1VHAxdO4bR+njXZdUXfQ00/RcEKRcENoGs6VAuxb3W
         zDRSofwb68CflsIc+6McA/ABLemrOcKxyCzBX+2S2vOs3mKzqVqoeS8dJM48Kg8jYDKZ
         qb9uYvCOKWV39uPDgRm9e4BtWHWBIc+pwp3igq/5CEYaj7T9hd979QG/aamYBwoIzODW
         Sqg/ZTkBam/omql7Iwbtr03YV07B3f1fAPKXASQh83c5gvDsUZ4PSHxkcItCssZYJJ5U
         txrw==
X-Gm-Message-State: APt69E3nzumQ+YU/5UUrKCaZ/Bj2R2MHqAUgNwwmqomKL09crFKJHdB2
        4itlni4tdRq7qZSUocY0yQrTeQ==
X-Google-Smtp-Source: ADUXVKLdF1jQ88WihSDJ3pBRHGm7EMtqROwLktGI82GOYc2Cw98q+O++/jy3bfw5jOcjzky+CTNwaA==
X-Received: by 2002:a65:4a4d:: with SMTP id a13-v6mr172704pgu.161.1529647020466;
        Thu, 21 Jun 2018 22:57:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id y23-v6sm14151342pfa.73.2018.06.21.22.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 22:56:59 -0700 (PDT)
Date:   Thu, 21 Jun 2018 22:56:59 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180622055659.GA255098@joelaf.mtv.corp.google.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620164902.GW3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Jun 20, 2018 at 09:49:02AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 21, 2018 at 01:05:22AM +0900, Byungchul Park wrote:
> > On Wed, Jun 20, 2018 at 11:58 PM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > > On Wed, Jun 20, 2018 at 05:47:20PM +0900, Byungchul Park wrote:
> > >> Hello folks,
> > >>
> > >> I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
> > >> think it's possible since the only thing we are interested in with
> > >> regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
> > >> idle or not.
> > >
> > > Please keep in mind that NMIs cannot be masked, which means that the
> > > rcu_nmi_enter() and rcu_nmi_exit() pair can be invoked at any point in
> > > the process, between any consecutive pair of instructions.  The saving
> 
> And yes, I should have looked at this patch more closely before replying.
> But please see below.
> 
> > I believe I understand what NMI is and why you introduced
> > ->dynticks_nmi_nesting. Or am I missing something?
> 
> Perhaps the fact that there are architectures that can enter interrupt
> handlers and never leave them when the CPU is non-idle.  One example of
> this is the usermode upcalls in the comment that you removed.

I spent some time tonight and last night trying to understand this concept of
never leaving an interrupt, I hope you don't mind me asking this dumb
question... perhaps I will learn something : Could you let me know how is it
possible that an interrupt never exits?

Typically an interrupt never exiting sounds like a hard-lockup. This is how
hardlock detector works: Since regular interrupts in linux can't nest, the
hardlockup detector checks if hrtimer interrupts are being handled and if
not, then it throws a splat, panics the kernel etc. So I am a bit troubled by
this interrupt never exiting concept..

Further since an interrupt is an atomic context, it cannot sleep or schedule
into usermode so how are these upcalls handled from the interrupt?

Lastly, can you point me to an example how the rcu_nmi_enter/exit() pair can go
out sync? That is they aren't paired and nested properly? In my mind they
always should be but I may be missing the usecase. I'm happy to try and
reproduce and trace this if you can let me know how to so that I can study
it better. 

Thanks a lot Paul for your help,

 - Joel


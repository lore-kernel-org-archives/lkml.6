Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA26C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4AB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bl7y2h3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4AB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeJOJ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:56:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34162 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOJ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:56:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so8504462plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DAG6do8Qbuvxl3VxASK5DL9Y/7NWoA5FaquGDm42Tx0=;
        b=bl7y2h3KoQJLFBCan8Shl5mib2K10vQrbMsGoEFQPCAw6gRYbQrXblrpTKW0Hlm3sz
         jRBi9oaIvnADEdevUdePVxYy6M7ns/etK0XTxWDmdvorsNEdxS+ZQxIANv2aZ+vhCWeu
         +mFvlmAEAs6KMaH/kBpSx4norievrrm+ZgZpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DAG6do8Qbuvxl3VxASK5DL9Y/7NWoA5FaquGDm42Tx0=;
        b=kSUmwbh7acH0KeD5WIPd4r/4Gk9faBL/U2cmkLgkht9dqXqw99lcpx0NcstCwcKY/N
         rqe/pt9w/HtZpBD3sAgNHP3qIkQ56kouLDt85lz4YIaXMnN4MB0Dam0KFuYjvVt6bPGY
         f87bThKqtVMrhsXU6R0PaMUtanCIagfMsT9rgL8jzwylLZ6dQM6/sECOiYa1tkcgNge4
         UOO0aMxELcIO4DTqVxs/luXll/DtgtGPKkco1n8O8DukIQedJFGvF+tAMBJ36bS66ZEI
         WqGkj4WdMfBozI8fCSilksOR6Hc2fc1yg6ncmrHCcTxTEC2LqhS3gjxc4yxpV4TqaV63
         rU2g==
X-Gm-Message-State: ABuFfoiC/xBMsO6W80QOEFRmo3AanEc2BE7tsvIhtJRytzRnvotvgaxj
        HiNwpi7KjlfzvqnkZnqLnAl6Uw==
X-Google-Smtp-Source: ACcGV62Vc33AnYOkOhiJUPeSo9TLudulRpEn5c4v/8a12isUmHzPeSRWIxW4fTt8MuGAu2xwlGkKtA==
X-Received: by 2002:a17:902:9896:: with SMTP id s22-v6mr14891091plp.113.1539569631208;
        Sun, 14 Oct 2018 19:13:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q2-v6sm12402174pfc.17.2018.10.14.19.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 19:13:50 -0700 (PDT)
Date:   Sun, 14 Oct 2018 19:13:49 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Message-ID: <20181015021349.GB217384@joelaf.mtv.corp.google.com>
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015020827.GA217384@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 07:08:27PM -0700, Joel Fernandes wrote:
> On Sun, Oct 14, 2018 at 04:17:31PM -0700, Paul E. McKenney wrote:
> > On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
> > > The Requirements.html document says "Disabling Preemption Does Not Block
> > > Grace Periods". However this is no longer true with the RCU
> > > consolidation. Lets remove the obsolete (non-)requirement entirely.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Good catch, queued, thank you!
> 
> Thanks! By the way after I sent the patch, I also tried Oleg's experiment to
> confirm that this is indeed obsolete.  :)
> 
> One thing interesting came up when I tried synchronize_rcu_expedited()
> instead of synchronize_rcu() in Oleg's experiment, I still saw a multiple
> millisecond delay between when the rcu read section completely and the
> synchronize_rcu_expedited returns:
> 
> For example, with synchronize_rcu_expedited, the 'SPIN done' and the 'SYNC
> done' are about 3 millisecond apart:
> [   77.599142] SPIN start
> [   77.601595] SYNC start
> [   82.604950] SPIN done!
> [   82.607836] SYNC done!
>  I saw anywhere from 2-6 milliseconds.
> 
> The reason I bring this up is according to Requirements.html: In some cases,
> the multi-millisecond synchronize_rcu() latencies are unacceptable. In these
> cases, synchronize_rcu_expedited() may be used instead,.. so either I messed
> something up in the experiment, or I need to update this part of the document ;-)

So I realized I'm running in Qemu so it could also be a scheduling delay of
the vcpu thread. So apologies about the noise if the experiment works fine
for you.

thanks,

 - Joel

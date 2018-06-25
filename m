Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31D2578C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pBl4tbPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31D2578C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755310AbeFYQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:39:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33629 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeFYQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:39:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so6312422pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07eJdvkwK+7ZIL+hMaWZ7lVgd8BCW3xW00fovHnBhzA=;
        b=pBl4tbPLaF0YPMXGetfoy4ugfvdoyGEH+HOCE/0p3D1aI4pTiT781X0ZH5RAGl4VY4
         l/wDJN3mYTsN7dPGNn1MmxE3Dtd3ZPSoL9VH7Aej8Fp2opOifmuTp/xx4PFYbHkNnrmE
         F+hyqcjlWpE6u1eEPfYk2rregPiYLnomJXJy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=07eJdvkwK+7ZIL+hMaWZ7lVgd8BCW3xW00fovHnBhzA=;
        b=e7tXIePk6+Qq+UXzJ4a5hWnP8zWmBOl95OZ8x4Bnwvwkw0WvNYxfAoRVGpyqMSYuwQ
         NpzTUVITD+y3gx5hgMd7L5ygB/lrpbwWx+7VUimg4K1ZPxfd0OOUfMg9enhcYY50bpbj
         yWjjdrutB5bv7b2ad6jp7vGPC6DKcll5BcYG5kDVJadJSu5pgnf0n+PtTmwNWK1CpuAw
         hn72QBJEP93lZ3gQ21xvb9nBekk5ObrGIlDpsD0b4+QyQDIR7aJi8xYaCpgmaRawa/aQ
         sJBGE1krSa1IzOMe5idzmidoHGdVJXyumeHbUFZqO8a/eMxRQRAboYdBMHRBaRUiA3Z0
         7z4w==
X-Gm-Message-State: APt69E0lyNhI2wB/CYqfGN4f6Opem7mbnaOg1TfL3Y0Zdof/qYRmpAtQ
        G5eY9oAtXR8E4vAk99NbL/m5Vg==
X-Google-Smtp-Source: ADUXVKJqqZtEgrLSm1x+21qGUnKOoQka9gXVVc7VfCP4lWQEVYcF7ft7eM0gVPfrwsUYBzmz1X0KMg==
X-Received: by 2002:a63:8c5:: with SMTP id 188-v6mr11213200pgi.97.1529944793393;
        Mon, 25 Jun 2018 09:39:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id a1-v6sm19298761pgu.81.2018.06.25.09.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 09:39:52 -0700 (PDT)
Date:   Mon, 25 Jun 2018 09:39:51 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625163951.GA52646@joelaf.mtv.corp.google.com>
References: <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home>
 <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625082824.GB21377@X58A-UD3R>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:28:24PM +0900, Byungchul Park wrote:
> On Fri, Jun 22, 2018 at 01:05:48PM -0700, Joel Fernandes wrote:
> > On Fri, Jun 22, 2018 at 02:32:47PM -0400, Steven Rostedt wrote:
> > > On Fri, 22 Jun 2018 11:19:16 -0700
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > > Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> > > > look at that subsystem, and it seems you can execute usermode helpers from
> > > > atomic sections with help of UMH_NO_WAIT flag.
> > > > 
> > > > Then I checked where this flag is used and it turns out its from the
> > > > mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> > > > called infact from an interrupt context (mce_notify_irq).
> > > > 
> > > > Is this the usecase you remember causing this weird transitions to userspace?
> > > 
> > > But this case still looks like it uses work queues, it just doesn't
> > > wait for the result.
> > > 
> > > I'll have to look at the code from what it looked like back in 2011, to
> > > see if there was an actual issue here back then.
> > 
> > Good point Steve. So I guess in the current kernel sources, there's no code
> > that uses UMH in IRQ context AFAICT. I'll go through the google group thread
> > Paul pointed as well to study the history of the problem a bit more.
> 
> Me too. Good discussion we had thanks to you, Joel.

No problem, thanks for the patch in the first place which triggered this
discussion.

For whatever its worth, I made some notes of what I understood from reading
the code and old posts because I was sure I would otherwise forget
everything:
http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html

Feel free to comment on that post directly (or here) if you feel something is
grossly wrong.

Again thank you and everyone for the discussion! ;-)

 - Joel


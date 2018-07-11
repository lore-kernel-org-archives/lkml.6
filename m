Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566C4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0781208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G5TAIZE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0781208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeGKGAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:00:47 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35955 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeGKGAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:00:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so8677668plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4fDXxvG1p5wf1YmPcsYkYvI2rvtVCb9wb1qxYKFpiEg=;
        b=G5TAIZE87G8inkzlkfXuZREWSP3FbaQS4pw1+itGhZCwbDyBa8TVjGqTog1s0F4FYs
         iS8wLeCpLbpGl8kOPchvNgYT3w8WUgJ8hdGccSTfPv1GC3fZrDgoIrSncZhBnfDiBCNg
         Siax7E/F8lODVHNkBGxx3p8djFQkB2jTOQF60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fDXxvG1p5wf1YmPcsYkYvI2rvtVCb9wb1qxYKFpiEg=;
        b=G4MUgCI2m14L/LNglG89TxQLXF8qIP35moVPlC9YtAPnxe6F5RxFpo680nsVvW1mXP
         kXWD9zn1ls0Sm1PCAXGkcCR+Y5/C0v5uXSKXjGoAmqSLsPEy7yZoNP0DiHHlCwgwCRjL
         4+l/PhwbstXo/xFpXVDFD/078d0cA7nQJJiQVaht0Amb3uUaHFzfVTFEgy6Aek8kyHs8
         t5FLtX+2iKGZUxsBNEvPB1UxSDrX1yJ3Wqb4DS/isBLbdt5p/jzLDnaVlcTDf9NooTZH
         hvG7qF3C4ufLpMSI4Ao2KnsjMVRVkqDYHSPyjYxsv1ucKwQkxd369VlzlTs1vQt6XPpl
         tDrQ==
X-Gm-Message-State: APt69E3g+ZHEkjmwGUpFx+spuc4Qb3IvzvtS2k1e1h3PLY+MwoIcQr9M
        BKLwYMjNgnU3wyE2/MVjSXwEew==
X-Google-Smtp-Source: AAOMgpdpNZyRtUsxecA/wMWmr8yesRLrGyFJMqj+82DQ8v3byFgoO/YPbvaFE+wpel/ujpOA8voMrg==
X-Received: by 2002:a17:902:321:: with SMTP id 30-v6mr27995985pld.122.1531288690889;
        Tue, 10 Jul 2018 22:58:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id d7-v6sm32344663pfa.51.2018.07.10.22.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:58:10 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:58:09 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180711055809.GA16473@joelaf.mtv.corp.google.com>
References: <20171116161506.19691-1-npiggin@gmail.com>
 <20180501144620.1e832a09@gandalf.local.home>
 <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
 <20180501153840.7281022a@gandalf.local.home>
 <20180501194838.GK12217@hirez.programming.kicks-ass.net>
 <20180501160059.6df6aae4@gandalf.local.home>
 <CAEi0qNkbjrdx8A4rfNCJd-1BGMUXZRbbLJEkZuVab+oprWhcDQ@mail.gmail.com>
 <20180502101214.746650bc@roar.ozlabs.ibm.com>
 <20180710214457.480826ab@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710214457.480826ab@vmware.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 09:44:57PM -0400, Steven Rostedt wrote:
> On Wed, 2 May 2018 10:12:14 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > > I have mixed feelings about this patch, I am Ok with this patch but I
> > > suggest its sent with the follow-up patch that shows its use of this.
> > > And also appreciate if such a follow-up patch is rebased onto the IRQ
> > > tracepoint work: https://patchwork.kernel.org/patch/10373129/
> > > 
> > > What do you think?  
> > 
> > I'll try to dig it up and resend. Thanks for the feedback on it.
> 
> Joel,
> 
> With your latest patches, is this obsolete?

Yes, that's right. This patch isn't needed for what I was doing (improving
the performance of the irq disable/enable path). I didn't see any performance
improvement with this patch. Instead, the patches in my series use SRCU to
improve the performance of the tracepoints.

thanks,

- Joel

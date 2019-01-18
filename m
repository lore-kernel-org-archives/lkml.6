Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54239C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Ga56qSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfARQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:10:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33738 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfARQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UnOFN8FawOKG4MkqBabtFx+IHOKdBtIu0PGwssjJfvA=; b=0Ga56qSxaXSh/7ZlTQCpMpVRp
        y9uU/6sC3tze3/qFbn5Fv+iTyxR3WaE0QcGcepL6KKO6KnqGevHNMdpqZxmYuXAuQIzBRmOeeVpv9
        OXIlVFbsgI7hu5Q3L3X9Wery0lv4mp3lmkXQR2yFpfpDI99OePNwwy6Kax83pwqmT0LuoAPSSfBkl
        TBeRBN9JGeluKesXs/6FeDpjWvpSeYKPBd0wzm1lBE04wWC0YX0+lMogI6jCa9YgrBd6rD+0ng1IE
        UjwfDsl+XjWbQEezFNIArX5TiJxCGH2PAiTbRumJhvNAIztks+2JDhEa7UFiwp2QT2vZXa92whkGn
        XoiCoY5tw==;
Received: from [89.200.44.227] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkWiJ-00043U-Rr; Fri, 18 Jan 2019 16:09:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0412983835; Fri, 18 Jan 2019 17:04:50 +0100 (CET)
Date:   Fri, 18 Jan 2019 17:04:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hugo Lefeuvre <hle@owl.eu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190118160450.GG14054@worktop.programming.kicks-ass.net>
References: <20190117224135.GC8100@hle-laptop.local>
 <20190118151941.GB187589@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118151941.GB187589@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:19:41AM -0500, Joel Fernandes wrote:
> You should document the variable names in the header comments.
> 
> Also, this new API appears to conflict with definition of 'freezable' in
> wait_event_freezable I think,
> 
> wait_event_freezable - sleep or freeze until condition is true.
> 
> wait_event_freezable_hrtimeout - sleep but make sure freezer is not blocked.
> (your API)
> 
> It seems to me these are 2 different definitions of 'freezing' (or I could be
> completely confused). But in the first case it calls try_to_freeze after
> schedule(). In the second case (your new API), it calls freezable_schedule().
> 
> So I am wondering why is there this difference in the 'meaning of freezable'.
> In the very least, any such subtle differences should be documented in the
> header comments IMO.

Also; someone was recently hating on the whole freezing thing (again,
and rightfully). I just cannot remember who; Rafael you remember?

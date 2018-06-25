Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F6C26103
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsnQ04qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F6C26103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965194AbeFYUsD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:48:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965146AbeFYUsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:48:02 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5292610E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529959681;
        bh=294uciUUEUAMkCq5233yM2QE7X16xEz5TYtKpTXjHFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NsnQ04qZwGOaJPaLY314IGAWNiwzpgU7vDQNAEfhc7QZH6EENEDyO1uhgWaz+dfha
         4OrRFdYvAQI++awOTJLk9V8F9PJU1R26gmAytzOus8aymITuoszcFzoSjZRs2DePGu
         KcD4JsFCCVyByNChUpQjx6TtDNo+SXjhoDpHGZBE=
Received: by mail-wm0-f51.google.com with SMTP id p126-v6so10755978wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 13:48:01 -0700 (PDT)
X-Gm-Message-State: APt69E0ZBIdg/kYfCbnw3EfYFE3Y1QDCmJpcoThrgqoV69ccEP1fBKAA
        71nJ/tpQu2XOMmXxEcReai4KS4dgONwS0JQYHNzXrA==
X-Google-Smtp-Source: AAOMgpd1Ng0/eAoX1tIPy4VM6LHF2QPJEqyAbw6t3Gc/LADNlMwmkqHfztw8uTWPzu8XjrAAUQ39Dcod2GSr22Up4A4=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2162147wma.21.1529959679916;
 Mon, 25 Jun 2018 13:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com> <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com> <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home> <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R> <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625162557.7140664c@gandalf.local.home> <20180625204708.GS3593@linux.vnet.ibm.com>
In-Reply-To: <20180625204708.GS3593@linux.vnet.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 13:47:45 -0700
X-Gmail-Original-Message-ID: <CALCETrVD6CxY0gDcfNfy8rNK74UZKnVvBJfiK7pLbZLiqgEbOg@mail.gmail.com>
Message-ID: <CALCETrVD6CxY0gDcfNfy8rNK74UZKnVvBJfiK7pLbZLiqgEbOg@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, joel@joelfernandes.org,
        Byungchul Park <byungchul.park@lge.com>,
        byungchul park <max.byungchul.park@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:45 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> On Mon, Jun 25, 2018 at 04:25:57PM -0400, Steven Rostedt wrote:
> > On Mon, 25 Jun 2018 09:39:51 -0700
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > > For whatever its worth, I made some notes of what I understood from reading
> > > the code and old posts because I was sure I would otherwise forget
> > > everything:
> > > http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html
> >
> > Nice write up. I may point some people to this ;-)
> >
> > Anyway "complications due to nested NMIs (yes NMIs can nest!)"
> >
> > What arch allows for NMIs to nest. Because we don't let that happen on
> > x86, and there's code that I know of that is called by NMIs that is not
> > re-entrant, and can crash if we allow for NMIs to nest. For example
> > "in_nmi()" will not show that we are in_nmi() if we allow for nesting
> > of NMIs. It has a single bit that gets incremented when we enter NMI
> > code, and cleared when we leave it.
>
> Last I checked with Andy Lutomirski, there are a number of things that,
> though not NMIs, act like NMIs and that can interrupt each others'
> handlers.  This is on x86.
>

As a straightforward example, NMI and MCE can nest inside each other.
IIRC we treat #DB somewhat NMI-ish-ly as well.

--Andy


>                                                         Thanx, Paul
>

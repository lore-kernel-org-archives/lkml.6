Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69989C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F782085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WCSw3AAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfBTNRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:17:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39461 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfBTNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:17:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so24834080wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PG/uhxa3b+MdI8LWNjKVY+NfUULqMl2h5FlcRZcEgNI=;
        b=WCSw3AASv/OptnJzNiemyockTaqni80N6zNMJKR/+vw3EqRU04Ogj4/D3HbrlkJDri
         5PHGH4JDK8dqp0IXFxSDo4arR1JrEHbPnwlgfQIUX0cN+czr72a260AjdCTK3ZHBHLhk
         IwVIc6vAcqVP7ZBuqeyJ1cz9LMlC7zXNl3DEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PG/uhxa3b+MdI8LWNjKVY+NfUULqMl2h5FlcRZcEgNI=;
        b=lbj+e6p7HOLvb95b3X69Jt99kac3ipl4XlbusUae8il3QFyr0o7SRZNvu00CgptIkS
         tce+0uAMTGe6K49z5dmwuMJ8cLnEY0cUX97drjHjSMq0Kj+JstGNiutdPMdogMEFmvG3
         3Ig6vuOJElL70zakiVRvB9BZ0VjYGtXWxGxSYPwK1MkmV1WYL55Q74Dx7I1L9M/+4z4G
         nf4x77EF0BERhb7sOHdu9bl6c3PTTPSTUvXR6VZJJlHwJB4xt1uF7OhB8vKxqLl/G0KC
         EO/yim7Qn+9wY+6eEetxNxyi7//ahsidy9iV6RLqhTZjvOgsQ6+tL+30ECcXOUJ31aRn
         AksA==
X-Gm-Message-State: AHQUAuYfHlEyunugu82YkJ3SQ3Truu74YgTjMapcL6AeYbBew0qTDC9l
        4UTsPVS1gai7dGUdH8v5yuPgJQ==
X-Google-Smtp-Source: AHgI3IZFbtOhLKHZiU8mueJdHYaVmN3EF92/5v1+s9qhWFW9mGBLlbTaYi+iCXEc4VGB2CLO35HGIQ==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr23230853wrs.98.1550668668988;
        Wed, 20 Feb 2019 05:17:48 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id n2sm31862655wrq.58.2019.02.20.05.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:17:48 -0800 (PST)
Date:   Wed, 20 Feb 2019 14:17:30 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220131730.GB3215@andrea>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220095659.GA17578@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220095659.GA17578@brain-police>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 09:57:00AM +0000, Will Deacon wrote:
> On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > > if necessary, but let us not encourage people to rely on this thing.
> > > > 
> > > > For example, the following "exists" clause can be satisfied with this
> > > > change:
> > > > 
> > > > C dep-rfi
> > > > 
> > > > { }
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	smp_store_release(y, 1);
> > > > }
> > > > 
> > > > P1(int *x, int *y, int *z)
> > > > {
> > > > 	int r0;
> > > > 	int r1;
> > > > 	int r2;
> > > > 
> > > > 	r0 = READ_ONCE(*y);
> > > > 	WRITE_ONCE(*z, r0);
> > > > 	r1 = smp_load_acquire(z);
> > > > 	r2 = READ_ONCE(*x);
> > > > }
> > > > 
> > > > exists (1:r0=1 /\ 1:r2=0)
> > > 
> > > Any objections?  If I don't hear any in a couple days, I will apply this.
> > 
> > IIUC you cannot build hardware that allows the above, so why would we
> > allow it?
> 
> Agreed. Maybe the intention was to make the dependency between the read of
> *y and the write of *z on P1 a control dependency instead? That's certainly
> allowed on arm64.

No no, I did mean dep (= addr | data).  As you remarked, control dep.
aren't going to work here.  I expanded on this in my reply to peterz.

  Andrea


> 
> Will

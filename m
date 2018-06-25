Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F9C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEC5255E7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KmGu4WE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEC5255E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFYI3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:29:33 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35583 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754080AbeFYI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:29:31 -0400
Received: by mail-wr0-f171.google.com with SMTP id c13-v6so2750282wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnr+Nr+2rMhZCwmr3I2/Y2jpho0XSbY1HRMR/OFVW1k=;
        b=KmGu4WE3+OSSCrW7ptX9spj7hN1oMPj0CdLOndxUp+Na4pvRbXIewVlRBxOeU4pK2m
         Q+7PyV5ESlruENPKQDwDKO6to2j/J4chL+zKzWTw+Rkox68BkiaZKd3dNiiC8gzcGPxw
         dX2/EENPFfKyfH7SM+jEFZ2f6V/2Y6duT4ITc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnr+Nr+2rMhZCwmr3I2/Y2jpho0XSbY1HRMR/OFVW1k=;
        b=OZ7/p2xtXDUlufc+u2bPDhpEclmz0x1dEpnsf1bC7J560pUux+RjJi1/dScvk3vJ10
         VzLwUeCYaQ73uVV3TDRR7+aIXfZ6xIXb8mZtTYKYiI5/i/kF9kZ/k16i+EwKaN3u46Rz
         Wa04oQxgdWF+3r3RvdAbHp1A/LXLTdKWlryWR6+AY8xC3YKfaGXVW1uqKAJxLTqqkvHL
         px5/ZymVr2nnuiJECkMAQpa1ZekELa5oS5EjKVoxvkJ1rRU0mTBOEVv/wfsE3WtWvzMb
         gaBEPPUNyWQk1D9vXEPDxEIcBnOI3NoaUy9DQ07jCRociwhknNtHky/kTY44yNKlBaZw
         AHyg==
X-Gm-Message-State: APt69E2S/rwELoO9rSJwSh04ZeYU0DGfBRf5aXFPCcdphpQgCYbogESx
        pOW1hQWb/3fh9IrP+ttEZAjjYA==
X-Google-Smtp-Source: AAOMgpc2ImJjKYkjE4tkNml77fco6W05cU5nfOU5zc0AK53HsYHHG/lQpUQ5x44u+q/2jGKv7vzEdQ==
X-Received: by 2002:adf:e447:: with SMTP id t7-v6mr9607079wrm.145.1529915370472;
        Mon, 25 Jun 2018 01:29:30 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id z128-v6sm10167931wmz.18.2018.06.25.01.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 01:29:29 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:29:23 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180625082923.GA5808@andrea>
References: <20180622080928.GB7601@arm.com>
 <Pine.LNX.4.44L0.1806221337440.1454-100000@iolanthe.rowland.org>
 <20180625073229.GR2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625073229.GR2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:32:29AM +0200, Peter Zijlstra wrote:
> 
> I have yet to digest the rest of the discussion, however:
> 
> On Fri, Jun 22, 2018 at 02:09:04PM -0400, Alan Stern wrote:
> > The LKMM uses the same CAT code for acquire/release and lock/unlock.
> > (In essence, it considers a lock to be an acquire and an unlock to be a
> > release; everything else follows from that.)  Treating one differently
> > from the other in these tests would require some significant changes.
> > It wouldn't be easy.
> 
> That is problematic, acquire+release are very much simpler operations
> than lock+unlock.
> 
> At the very least, lock includes a control-dependency, where acquire
> does not.

I don't see how this is relevant here; roughly, "if something is guaranteed
by a control-dependency, that is also guaranteed by an acquire".  Right? ;)

  Andrea

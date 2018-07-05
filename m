Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C09D22EC0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mMfJ42o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C09D22EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeGEPjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:39:15 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39318 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:39:14 -0400
Received: by mail-wm0-f45.google.com with SMTP id p11-v6so11633406wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YbE1+ZVIWSIRAfy1BOTmk22Yq7hjrax/v3Pc68gTU5g=;
        b=mMfJ42o0qr84dlyec0h9vBBMeqD7OKaBXosD8l1LC/NNYSiHL8McwB8k8DCykHSMbO
         +XnU93O5kWx7t/oZZ9qSJCCBVUSISxgQf6fx57GRJLfJE1a9JWy/ULPmH6j6YKJd1ZRV
         YY7U2Z1KnT5xZEs3RPqa/XbkZbPENMU7P8Rjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YbE1+ZVIWSIRAfy1BOTmk22Yq7hjrax/v3Pc68gTU5g=;
        b=rU4rhSbkJW8CLy2WFUge03b6wnqAYBalxJXFyuWZ9Mgu8kBdnagHaUgbi8IeFnxd0E
         zSG5PivvRgB9AyqaaG7UGxVQkqtyqm3SkaWkVNipgm++s6jW14u2vrZ/EjG89Kppplhw
         le/PbWKOtzLEj1LdqhzIRZIc7u/FNBOJe/ejhv8s4WV/up13JeuEHNAd5lg4RRzqJ/dQ
         RXaaDyzd6gyIW+oXo43of4FUkeK7ktuX8/PkOddG0juo01FFqAv8FMvwHFnL7yujFhHm
         iuggWkQ3MFltclprZ286DTscJusZ88WHDeapZoHv6/VEg4PKGK4ozbxYQfT47Ka+HMrw
         z0tg==
X-Gm-Message-State: APt69E0xZYkEHAWB3aSxdU2ijp6Qd6gxCpL9r8gRK2qNhnXOywjgyUGZ
        D2Yopoqf08O7YUNikTgXAMxPdw==
X-Google-Smtp-Source: AAOMgpeYU5ZsuU2shxG75U3mpBgH8kIMny1n3zRya67hLNV+/woVIonWtU1Cj8MN9zkc16ZzHOyKKA==
X-Received: by 2002:a1c:b004:: with SMTP id z4-v6mr4704349wme.70.1530805152901;
        Thu, 05 Jul 2018 08:39:12 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id j9-v6sm8477437wrr.52.2018.07.05.08.39.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:39:12 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:39:06 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705153906.GA2345@andrea>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705153140.GO3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > At any rate, it looks like instead of strengthening the relation, I
> > should write a patch that removes it entirely.  I also will add new,
> > stronger relations for use with locking, essentially making spin_lock
> > and spin_unlock be RCsc.
> 
> Only in the presence of smp_mb__after_unlock_lock() or
> smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?

There are at least two definitions of RCsc: one as documented in the header
comment for smp_mb__after_spinlock() or rather in the patch under review...,
one as processor architects used to intend it. ;-)

  Andrea
> 							Thanx, Paul
> 

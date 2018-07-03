Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76231C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E06208C2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jz5O+w4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E06208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeGCKMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:12:51 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55749 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeGCKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:12:50 -0400
Received: by mail-wm0-f42.google.com with SMTP id v16-v6so1688024wmv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsvIsU2X4nZcLBCwEmX2R352YZGtG2mi0TrjxeWYO+M=;
        b=jz5O+w4MzdyzFxZNEBtiw8AM68okZHPnkhicJSMcAeth7DRSYtIr5Ef0C68yGT9TXI
         RjYbiLehGkDeRXHHS1BXr1ZvpBuI+SE2EI8EPD9nXL1R9lCRlnBDJIkk7GQM5mJE7oe+
         R1sXaXjLsYUv0DAwJj7cxDd3/HGoAqe8HUEhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsvIsU2X4nZcLBCwEmX2R352YZGtG2mi0TrjxeWYO+M=;
        b=ZLswO+scxCYvpf4JaFG8fE4uddssBTvZjABysuUq6tl4B1SSlgydotweK6hwitkAw6
         aY3sB2VU5jo3aZOj6tjAD9vjiM5Z8gZS7tN8J5y4TtidI81aOr36j4aUiQEHjqjQBKem
         qbxCNSoCWDYSeT4VvMIayGPLHFO5nrYUzU4K3wfnMSF/524WwkHDvgxJJDveCxPUoDgq
         dml7sXoWGWtbG4PuO0pfm7rplFZC6h22nNXrKh7o1/Uu8i1gfWIWyR55wIrflAlsG3Zy
         /Wuwx9PwChxT44itF4dlB+GPWKMtSt3VXatTxJhMmpcISbaaHe09K/nNiBzYiduDu1WB
         kMvQ==
X-Gm-Message-State: APt69E2oJCgIkncdbiTI+U5SvuuTLfbvIDSFb5bTyhKEFCYwoHO5WlZ4
        0T0g6R34/lYDNpExw8OOUWkJ2w==
X-Google-Smtp-Source: AAOMgpf8MUNnxSjZM3Rl3UQtl8t4BuBJmSrc6O15LVa0+14DrS2wc1QVQFtHQGQxmQHfrDwWobZRPg==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr3538930wma.41.1530612769099;
        Tue, 03 Jul 2018 03:12:49 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id e126-v6sm1867657wmd.43.2018.07.03.03.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:12:48 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:12:41 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Message-ID: <20180703101241.GA29602@andrea>
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
 <20180628165111.GA4013@andrea>
 <20180702185415.GR3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702185415.GR3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   1) Merge the file touched by that patch into (the recently created):
> >   
> >         Documentation/atomic_t.txt
> > 
> >      (FWIW, queued in my TODO list).
> 
> Some consolidation of documentation would be good.  ;-)
> 
> Thoughts from others?
> 
> >   2) Add the entry:
> > 
> > 	F: Documentation/atomic_t.txt
> > 
> >      to the "ATOMIC INFRASTRUCTURE" subsystem in the MAINTAINERS file so
> >      that developers can easily find (the intended?) reviewers for their
> >      patch. (Of course, this will need ACK from the ATOMIC people).
> 
> If the merging will take awhile, it might also be good to put
> Documentation/core-api/atomic_ops.rst somewhere as well.

Indeed.  And let's not forget the "orphaned":

  Documentation/atomic_bitops.txt
  Documentation/core-api/refcount-vs-atomic.rst

;-)

  Andrea

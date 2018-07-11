Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF5A205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cWkJZ7PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF5A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbeGKQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:33:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbeGKQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:33:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so18801648wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5vtscayywnGERg3CvrellircN/BOYBP8Ws4wR1Z7P8=;
        b=cWkJZ7PGTD6LQsQZwKG51LBRL/0T88sq83y94Ro0BxdBt7TZNvqE8CvnkLYqv6fhWm
         pxMqMkRecrcxm2wxg4OLVJXJ797fJEswGUrGU6/LAqUHJiGYU1ddOzF2NMj42l3bDUlV
         ySSCKx3nAUrdGz4Twr2g5mbjVWZIr/ZbVO7HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5vtscayywnGERg3CvrellircN/BOYBP8Ws4wR1Z7P8=;
        b=W79eU/Q4DPkOT+LeQS4K74wE3L7UnoSQ/ITCiyWNb9P3FHxWCJH/VuagOlvn3Q0hr9
         0m7Z+xF6pH4a5dAvJA1wZNlGw6hjJMV6daLRyCKRF7iMKkzzt/56dCkzlIyiZOjPV7Cy
         HYeKjdBxRDQQlAQlTsvlWF1jUV7Sq8GrIQNSSR6gGEzTHrKkVNRKi7zflXyNwFpqtAQl
         5VAdX1sMy92fOqyR4x6YNATLYpL6frdmkusYG38rG88pIN0BUh+WVaKMs5gG6rUjKmES
         eatM8yeI959o2ENKM5pHFoAVAh8Rh/9GQ28DRLmHw/TYo04F7Hw7EOrfuU3AeamYAR2r
         fzww==
X-Gm-Message-State: APt69E3PPz2R9Tk5NSsp+UqAsGB6BCwQiDJGLwqsEKHLhcV7iZysg4gh
        Rm+EzaWVa2+f6mExglzOxW47xw==
X-Google-Smtp-Source: AAOMgpf5jGAfjacK4Y8ixj53sWXmErHcE0Q1a2HmlhVWwSJr03mga/NwvosZcizvsaR0/BnQv8JC3w==
X-Received: by 2002:adf:c4a7:: with SMTP id m36-v6mr21222305wrf.103.1531326490015;
        Wed, 11 Jul 2018 09:28:10 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r140-v6sm3245623wmd.27.2018.07.11.09.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:28:09 -0700 (PDT)
Date:   Wed, 11 Jul 2018 18:28:04 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711162804.GA15081@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180711155751.GC18477@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711155751.GC18477@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It might be simple to model, but I worry this weakens our locking
> implementations to a point where they will not be understood by the average
> kernel developer. As I've said before, I would prefer "full" RCsc locking,
> but that's not the case with architectures we currently support today, so
> the next best thing is this "everything apart from W->R in the
> inter-thread case" ordering, which isn't going to crop up unless you're
> doing weird stuff anyway afaict.

The "average kernel developer" thinks TSO or about, right?  ;-)

  Andrea


> 
> Will

Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA73C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9C4207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fRprE/gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfAXNqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:46:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35776 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfAXNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:46:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so3230269qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nc4HdoDza9fmJvgOuCX0hf9NbkYW81xcyB/LVKlSf6g=;
        b=fRprE/gK6raxN94sfNaL/fwVOH1gmmU3cObXHZ4uPbq2fDIMp6+xijYerjbXCVKmaq
         I7jqYlDZQGoz3PHvFfq6GYWI60hsxr7QDphZqahmoAuxiG0typaYQx7rxrZ1vol0+h6Z
         MeKhdynucvIraruaKaobKiKRr9nfkv+TgQoNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nc4HdoDza9fmJvgOuCX0hf9NbkYW81xcyB/LVKlSf6g=;
        b=eZHwSaVZowCRG59xafQ33tz8npHjPNLSxC7Hd6P01xaAkIFbvMx53MZbBdB26ZwqVR
         iuiSAQ2sFjWlqvXBv+mM7YBzt5bh6zF8L+JZmUg4FLb7FVMq0TQ9vOX2J2ERz9cRkZRw
         RS78LeL1rKuuqXZD9Ggo3mF++5iOym02Bt6I0Irgbg6bApzK0KrjHBIXMjeGd17xs5NN
         nx/pJVLSQlBKHJnrEecQPTJo2xbT+aMF8TVEkL9Mh4p9Es6QbRcp7EHSLIlTXOYGOlYf
         w/QvgZBePik2rS5TPPvL0rqgxSHTn6xJVz5gJKvsVlA8WZpMTYqJEWnTa7lD4VAqsFOT
         +SQA==
X-Gm-Message-State: AJcUukf4kSK7uk7lpTfZE9X2yoekHLVM+CxgsizxbeGBS/9EijVJ/R6f
        loDiSM+yUcv/Ms28KIrjueRDow==
X-Google-Smtp-Source: ALg8bN4Znnz6SmACt+1aYYICBNEky7vOUqgnRY4tlyv+jM83Z3cO9/LUhFO7giAq/lna4lOSyOtveQ==
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr5714294qki.212.1548337608061;
        Thu, 24 Jan 2019 05:46:48 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 70sm47999337qkc.52.2019.01.24.05.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 05:46:46 -0800 (PST)
Date:   Thu, 24 Jan 2019 08:46:46 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Todd Kjos <tkjos@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        ak@linux.intel.com, Johannes Weiner <hannes@cmpxchg.org>,
        jack@suse.cz, jrdr.linux@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: possible deadlock in __do_page_fault
Message-ID: <20190124134646.GA53008@google.com>
References: <201901230201.x0N214eq043832@www262.sakura.ne.jp>
 <20190123155751.GA168927@google.com>
 <201901240152.x0O1qUUU069046@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901240152.x0O1qUUU069046@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:52:30AM +0900, Tetsuo Handa wrote:
> Joel Fernandes wrote:
> > > Anyway, I need your checks regarding whether this approach is waiting for
> > > completion at all locations which need to wait for completion.
> > 
> > I think you are waiting in unwanted locations. The only location you need to
> > wait in is ashmem_pin_unpin.
> > 
> > So, to my eyes all that is needed to fix this bug is:
> > 
> > 1. Delete the range from the ashmem_lru_list
> > 2. Release the ashmem_mutex
> > 3. fallocate the range.
> > 4. Do the completion so that any waiting pin/unpin can proceed.
> > 
> > Could you clarify why you feel you need to wait for completion at those other
> > locations?
> 
> Because I don't know how ashmem works.

You sound like you're almost there though.

> > Note that once a range is unpinned, it is open sesame and userspace cannot
> > really expect consistent data from such range till it is pinned again.
> 
> Then, I'm tempted to eliminate shrinker and LRU list (like a draft patch shown
> below). I think this is not equivalent to current code because this shrinks
> upon only range_alloc() time and I don't know whether it is OK to temporarily
> release ashmem_mutex during range_alloc() at "Case #4" of ashmem_pin(), but
> can't we go this direction? 

No, the point of the shrinker is to do a lazy free. We cannot free things
during unpin since it can be pinned again and we need to find that range by
going through the list. We also cannot get rid of any lists. Since if
something is re-pinned, we need to find it and find out if it was purged. We
also need the list for knowing what was unpinned so the shrinker works.

By the way, all this may be going away quite soon (the whole driver) as I
said, so just give it a little bit of time.

I am happy to fix it soon if that's not the case (which I should know soon -
like a couple of weeks) but I'd like to hold off till then.

> By the way, why not to check range_alloc() failure before calling range_shrink() ?

That would be a nice thing to do. Send a patch?

thanks,

 - Joel


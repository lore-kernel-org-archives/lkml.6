Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2733BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B736A20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XJfpt0c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfARM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:56:20 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37915 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:56:19 -0500
Received: by mail-ed1-f44.google.com with SMTP id h50so11055446ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+3BHkjGp9zr2zQT2PFcN2GOfV8n4YxVKqjrZKzxlAU=;
        b=XJfpt0c3B9UFoOeaBDAHJewGVWH0PN1XuJZdn0Dagc5083CZc0Z/0Hrx/YTJR5GChK
         /yYmcpLiHv21s00LJtmtKfyW4zQ613K/QmqNg/XF5017sVVmxDRVcAqp8y5saFpJYEqn
         Ozocdh4nR7bI1xYZhY25qhGJMf9flQiQOrA4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+3BHkjGp9zr2zQT2PFcN2GOfV8n4YxVKqjrZKzxlAU=;
        b=De22WSQP5Sam+MVQYIqzxyZV4kqmbEk8KGxiRsx0AeRQuLHSdjlODTGu8gJZtVz+nG
         8cXEz6j/svh7hDcKYNAgF27s5LfGTflUL/+xWnDRv3bXl/88qvHs5JxiB/NyRV8CRV5b
         m7b12FP1JUsyiYZCyZKdsstFvguPqhtr+euvdPYUvtcyWlkR8q9eJJQpJF3HYkavuUwE
         V7+YxavDQOJZ+lmmDli5HPgPRK47Ew5Mwr18QINIf7vVg9tlz3UO+yjLbEm3XNcS39fn
         m71j6J8w1J6mBIfGO/8fQZ4dpEczyYVonDy5gxLrSAKQEYiNLSlCLBA1izi3OTLIjbSB
         yCwA==
X-Gm-Message-State: AJcUukfIIoV/sTdySgUjVJuFqVpR8K+WzT9SGdcrKyYM3v/wDggmEMA3
        MvkpRPjKPQk8DrDpPxKHTIVm9w==
X-Google-Smtp-Source: ALg8bN6bmKQW7QP33XCo6Co8NUg5MrxePxYtNYM7ymhFhCAsu5CozLB2LHQRDMwXB6EJDA6iD+aoIQ==
X-Received: by 2002:a17:906:881:: with SMTP id n1-v6mr14457564eje.7.1547816177931;
        Fri, 18 Jan 2019 04:56:17 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n29sm7259275edd.40.2019.01.18.04.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 04:56:17 -0800 (PST)
Date:   Fri, 18 Jan 2019 13:56:11 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 1/5] sched: convert sighand_struct.count to refcount_t
Message-ID: <20190118125611.GA8205@andrea>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elena,

[...]

> **Important note for maintainers:
> 
> Some functions from refcount_t API defined in lib/refcount.c
> have different memory ordering guarantees than their atomic
> counterparts.
> The full comparison can be seen in
> https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> in state to be merged to the documentation tree.

Just a remark to point out that that document got merged, even though
in a different location/format: c.f.,

  b6e859f6cdd1 ("docs: refcount_t documentation")

  Andrea

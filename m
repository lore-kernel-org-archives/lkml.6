Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFF7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25E21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oDZqAnBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D25E21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJQXHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:07:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40091 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:07:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so25232695edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IlPPVer3cCDM9s5XwuxYjT2m1bX7z07CSi9LKXlLqo=;
        b=oDZqAnBlZVDYDyGcir6Y6dUm1uvFYJzHXzBffZOJTkyqzxB7JuUz5XcPjyZjcZa9vP
         QkZlUs1LRgLH9dg2T0BN0VvQdFGurQBnvf2fc+lviQ73DzfhLg243sB4pincild/8MJy
         wT0J3MPMtWSaqkqAF6PsCH0kglnmRHC7ApiPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IlPPVer3cCDM9s5XwuxYjT2m1bX7z07CSi9LKXlLqo=;
        b=gDYBGSp2CvB1/tGpiLCodTNnQq9Ua5m1SQE5vRCpyX3GPtVUJadZyEdRZl85IHmakx
         yUK5DZPvZA2Z9SiWL+teKLLU3r1aJPQ+A8EYxBXjXCIKThnYCmQwxhRPTTtSyR+GbN8I
         Wl2n1/K+fIxE1rUJLDbB/8ZEo77cBy8+lrXwBDKeK45K98TBpqGBQjuM1a4fQQw3Sihd
         L5aYP94d6RLQgSajVjj1Gqw0Psw/6jbxb5u5zo+pDcV4hvQqHLq8vc9oTAxiu53rYBkU
         D3UtISEmhOvKPORtYu+A1AE1r0p2seL2dFJrt/NTts6eGoiAYWfQPxyUn9ITDvJsvB4q
         B3Wg==
X-Gm-Message-State: ABuFfogr4+ho+9TmBdADm0fPjtbGttpm9mKjqaZc2uPnxm0bNKLvEVAS
        AbfVZrP/FvMZEWwbFwJ/zBNPu22XO2/AnQ==
X-Google-Smtp-Source: ACcGV62iaAgYfA7UovSgXkNDuy6+W158mb7EYCvwSrqaLh/Sl2JSQxC7J2Na5EbvAZBcpf+Rj1hCtA==
X-Received: by 2002:a50:b322:: with SMTP id q31-v6mr874275edd.194.1539789102735;
        Wed, 17 Oct 2018 08:11:42 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id f22-v6sm6333014eda.9.2018.10.17.08.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:11:42 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:11:34 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     David Howells <dhowells@redhat.com>
Cc:     gregkh@linux-foundation.org,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fscache: Fix race in fscache_op_complete() due to
 split atomic_sub & read
Message-ID: <20181017151134.GA8966@andrea>
References: <153978619457.8478.3813964117489247515.stgit@warthog.procyon.org.uk>
 <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153978621809.8478.2198040871218302573.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Oct 17, 2018 at 03:23:38PM +0100, David Howells wrote:
> From: kiran.modukuri <kiran.modukuri@gmail.com>
> 
> The code in fscache_retrieval_complete is using atomic_sub followed by an
> atomic_read:
> 
>         atomic_sub(n_pages, &op->n_pages);
>         if (atomic_read(&op->n_pages) <= 0)
>                 fscache_op_complete(&op->op, true);
> 
> This causes two threads doing a decrement of n_pages to race with each
> other seeing the op->refcount 0 at same time - and they end up calling
> fscache_op_complete() in both the threads leading to an assertion failure.
> 
> Fix this by using atomic_sub_return() instead of two calls.

Seems a case for atomic_sub_return_relaxed()... why not?

  Andrea

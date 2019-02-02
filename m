Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B49C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50D2082C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iTGy6iTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBBShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:37:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42644 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfBBShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:37:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so11440949qtq.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbSyTxaBa6IIcdk8bp7fWTfN4Jl+3MC9AoZ9nbQ94gI=;
        b=iTGy6iTfIWKvP9SwJJCYW3i95VUl6XoQPWAZIxiPGQezVHAILhqieXt40ovOI/b3En
         r0oYiR+1yz4EHT3kRp2XlcNtO362ScqDpsVCY3gDcaGPa7U1jwGpeCUzWp5y2cJ6+k1M
         tvU8CQFNjfWFE7I+sfDMvLFkSaKCNfxgStkM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbSyTxaBa6IIcdk8bp7fWTfN4Jl+3MC9AoZ9nbQ94gI=;
        b=Wt6poCCGF8a0546VOYU53/hLkcbQ6C77dXFY2yJTEFQdAURmXOcdTZCyaeFPxvu8sh
         lnltcOZfBtXa49LoisbZoO46Zcl8uGlFdIs1hnxcq/bjrpNp5e0jR4Q8BlzLLGgUOzvS
         Ptl4VQ0C+R+75aRxbIgMdqLuNViuRiCvs6lJ1DmMpp+dntR1luGox1im31MpK37xyp+Y
         lJZ3ZI2S9hxnPgikK8dO1B/u00HiFbxpKsNQ/jtj7ubtZHdaWQGViAujnMyP9Fptw4Oy
         qbStW/DFo6hPTXjJtS7f39SCxFiTK6aClJO6trq2OaZob0ROmkFHFeP5oSbihRliAlCy
         Kc7w==
X-Gm-Message-State: AJcUuke8D/u+jTYWvOCXcrkAm/7IUHitot5SgUwaqhqmWLdbDuot3Wg4
        Hhts42YgUw8kCKcIZOIdpQd87hyw5HI=
X-Google-Smtp-Source: ALg8bN4CkCBV0Ri1iMylC71xxp7tq5eDtixosol2URg/zQPjmaZMbbhKZJJXIZ5S6qVtcHaK0K5WTA==
X-Received: by 2002:aed:31c5:: with SMTP id 63mr43795318qth.385.1549132667225;
        Sat, 02 Feb 2019 10:37:47 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id z18sm24454734qkz.96.2019.02.02.10.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 10:37:45 -0800 (PST)
Date:   Sat, 2 Feb 2019 13:37:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/wait: use freezable_schedule when possible
Message-ID: <20190202183743.GA229953@google.com>
References: <cover.1548998323.git.hle@owl.eu.com>
 <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b2ed186ed6fcacaaecd876bb66dca8fa329d8b.1548998323.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:38:05AM +0100, Hugo Lefeuvre wrote:
> Replace schedule(); try_to_freeze() by freezable_schedule().
> 
> Tasks calling freezable_schedule() set the PF_FREEZER_SKIP flag
> before calling schedule(). Unlike tasks calling schedule();
> try_to_freeze() tasks calling freezable_schedule() are not awaken by
> try_to_freeze_tasks(). Instead they call try_to_freeze() when they
> wake up if the freeze is still underway.
> 
> It is not a problem since sleeping tasks can't do anything which isn't
> allowed for a frozen task while sleeping.
> 
> The result is a potential performance gain during freeze, since less
> tasks have to be awaken.

I'm curious did you try the freezing process and see if pointless wakeups are
reduced?  That would be an added bonus if you did.

Otherwise seems like a nice change. Peter and Rafael, what do you think?

thanks,

 - Joel


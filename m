Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF852081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ld42mQ04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF852081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbeKAGrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:47:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44843 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeKAGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:47:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so6227839plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flC3YvOdR/CDAH/KjU3dU44tS/ZG6c7VBcpk4NBkqN8=;
        b=ld42mQ04PUVMlbFTSM1MOMaE0TKH4woX6E+BvqmC6LN2KN/zP0jCAaCKjSMIDsi283
         p6xKatCS7wA95mAjVI0950yQ1Q0RKoNeqInrqrofRsduIyY6gQjtOHDjHrTqroxelXeF
         sPUyOeYq2EK5QCNUzR6GgXvxilGU9ZrEJ4W3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=flC3YvOdR/CDAH/KjU3dU44tS/ZG6c7VBcpk4NBkqN8=;
        b=cAYCcTw1/m3keMwuG4LlbbOfxQXRCFju6gMWGTRHKuto+M9Dqj7A748wjLWFXSLsCT
         tKm2tA3GAiaGZy0U2s4R4J+KvcLeqSooMB6z1CGZUMDxDjQtAfVFQBuQw14pPP5l6K+X
         P4Om3J+hYz6WcpZnJVHqPU50IvXfpFwwybRESZGKSviqGtDhZrG8KP5z+ZJOyz6eGkxT
         g86z3x9wJX4gUalEkgspsz6Jo8u+56AKWlPfW4yOM8RKAMdFvLDGo/qcoTxFZgu5Dh7B
         3pLQSsP0uGcjHtABiLFqkMgVN459wHWU1bRGmrbavjDjIxJc3B5mPXfBJ6mnxA6uhgjV
         Ejgg==
X-Gm-Message-State: AGRZ1gLIPdJJUNhNnVS6t4T3UbWY5shjqTDpYhgo1hBgEWnBwfWs3M2b
        RDunGqx3uq7KVcU58EOzgMI13g==
X-Google-Smtp-Source: AJdET5ehdo3NOjE5jyfzrTzhrVDE3/n08ddTS2P++GRz1KMXuewOXi4A3lGRpns9JviICSJjLEtVyA==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr5113519plp.332.1541022477523;
        Wed, 31 Oct 2018 14:47:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id h6-v6sm36519594pgm.14.2018.10.31.14.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 14:47:56 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:47:54 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel@vger.kernel.org, timmurray@google.com,
        surenb@google.com, christian.brauner@canonical.com,
        ebiederm@xmission.com, keescook@chromium.org, oleg@redhat.com
Subject: Re: [PATCH v2] Implement /proc/pid/kill
Message-ID: <20181031214754.GA52047@google.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031143744.77677-1-dancol@google.com>
 <20181031150548.GA103404@joelaf.mtv.corp.google.com>
 <20181031173353.uob5qikkhsb5digy@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031173353.uob5qikkhsb5digy@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:33:53AM +1100, Aleksa Sarai wrote:
> On 2018-10-31, Joel Fernandes <joel@joelfernandes.org> wrote:
> > I suggest to maintainers we take this in as an intermediate solution
> > since we don't have anything close to it and this is a real issue, and
> > the fix proposed is simple.
> 
> I would suggest we wait until after LPC to see what Christian's design
> is (given that, from what I've heard, it will help us solve more
> problems than just the kill(2) issue).
> 
> I am very skeptical of adding new procfs files as an "intermediate
> solution" (procfs is the most obvious example of an interface which is
> effectively written in stone). Especially if this would conflict with
> the idea Christian will propose -- as he said, there were proposals to
> do this in the past and they didn't get anywhere because of lack of
> discussion and brainstorming before posting patches.
> 

Fine with me, thanks.


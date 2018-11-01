Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DD120657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o7V4cNuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DD120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeKBFph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:45:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34356 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeKBFpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:45:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id k1-v6so8149279pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2hqnOlv6s9A6rZST2teucNVl1VbXK5yh0Jy3qZiXvO8=;
        b=o7V4cNuj1ITnzbmDWPLcR/3PaTnkz5Z7HbvITxoOwzTd5nc6NgUO6pu7X7zDLAR7bD
         gmM23JGZBcBHvVN4i53F6oYxYxWopXPog1nH9bTecx/AAwB2Yk+2evktG/E4CwQV6dxP
         /HRHe5herSNZcTzWxBv7meR9GLh3a7H+GW1Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2hqnOlv6s9A6rZST2teucNVl1VbXK5yh0Jy3qZiXvO8=;
        b=dElOC+ST9V89H5h9KAjuUni5giy8gBKNE+FMR4qqNWi5OQxFP9VBKFmHfeg/R7Yc5/
         BBu93lj1k3m4XK75R4uX4cElFDB7mSj71PTyA4QdnOJrL9x3rnn9TTkBq3obZuZeDoDp
         7PMLCTbVAuHufmICDLMhrO4QpQW8rMXVcFq9swgFoq9zXxbwdIcssDloZpRpPrz8eLiz
         7SbEuZ8soHBCZ2feAsPoTpC3NSZR/LYfTI62Jn+Nzaa808d3SI0LwwSZ1aMlyXxsVBlb
         GRWl25XvtEJLJmJQQzEKd7O5HYnUvAwL2ZJ7YI+ifWTII+g84jg+gMf478qjLqPZ5v/Z
         ljbw==
X-Gm-Message-State: AGRZ1gIdamaR4smyaaWhpdXcYmCwPIb2JcBHD0h/DvfXnSDjFjZkTnKm
        dIi4EgmL9j/i68GIrAfpQozqkw==
X-Google-Smtp-Source: AJdET5eVuMHlisQHMcTqMbey1qIGqZC/YZxWKKw2nOjIximfo9LjQh8CrK5U8tmRhJbzIRmZx6dDOA==
X-Received: by 2002:a63:9dca:: with SMTP id i193-v6mr7905127pgd.98.1541104861770;
        Thu, 01 Nov 2018 13:41:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m20-v6sm38735079pfj.171.2018.11.01.13.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 13:41:00 -0700 (PDT)
Date:   Thu, 1 Nov 2018 13:40:59 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Daniel Colascione <dancol@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181101204059.GA102756@google.com>
References: <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
 <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
 <20181031025655.yz7lfhswk7igb3ty@yavin>
 <CAEXW_YQxWcQGZHrwhwsyu7GCk+WSap=tb0-asTsG8sTFmjE--g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQxWcQGZHrwhwsyu7GCk+WSap=tb0-asTsG8sTFmjE--g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 09:24:00PM -0700, Joel Fernandes wrote:
> On Tue, Oct 30, 2018 at 7:56 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2018-10-31, Christian Brauner <christian.brauner@canonical.com> wrote:
> >> > I think Aleksa's larger point is that it's useful to treat processes
> >> > as other file-descriptor-named, poll-able, wait-able resources.
> >> > Consistency is important. A process is just another system resource,
> >> > and like any other system resource, you should be open to hold a file
> >> > descriptor to it and do things to that process via that file
> >> > descriptor. The precise form of this process-handle FD is up for
> >> > debate. The existing /proc/$PID directory FD is a good candidate for a
> >> > process handle FD, since it does almost all of what's needed. But
> >> > regardless of what form a process handle FD takes, we need it. I don't
> >> > see a case for continuing to treat processes in a non-unixy,
> >> > non-file-descriptor-based manner.
> >>
> >> That's what I'm proposing in the API for which I'm gathering feedback.
> >> I have presented parts of this in various discussions at LSS Europe last week
> >> and will be at LPC.
> >> We don't want to rush an API like this though. It was tried before in
> >> other forms
> >> and these proposals didn't make it.
> >
> > :+1: on a well thought-out and generic proposal. As we've discussed
> > elsewhere, this is an issue that really would be great to (finally)
> > solve.
> 
> Excited to see this and please count me in for discussions around this. thanks.
> 

Just a quick question, is there a track planned at LPC for discussing this
new proposal or topics around/related to the proposal?

If not, should that be planned?

- Joel


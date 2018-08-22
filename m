Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E61C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2707A208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZUa+OhZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707A208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHVFcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:32:22 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35472 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeHVFcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:32:22 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so319185iob.2;
        Tue, 21 Aug 2018 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oif1S4ZCw+p8bjZGQ6Gq4SX5L1ike1o3EWxREXHrX4=;
        b=ZUa+OhZM7wQWN15nwjWa9j/wDKISf7iGLbsKLnPOHoJpxrtOcg3JmbDZ7yelB7qH2a
         OBMuJp5o1OMquaOG9k17Q/EoIYP+9ph7nN8b5JaVpY7H/MNBPxL3fvrN/P0LLsVWXvJV
         o18VtwozplzLRVdwQpOVFrHg6+FJ8YF24O0hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oif1S4ZCw+p8bjZGQ6Gq4SX5L1ike1o3EWxREXHrX4=;
        b=N8NA6QwHhzzRapLzqZwSR6AX7LvmRUXbCxzIvQstc4HSNZJSeBLEzzppWL0JgNXa8p
         HsacXzPDCiB/CkcS07243icDjUYJngwFO71LJF3LcGqADRqHAoWmZv86c4xFUCmrpa4Q
         uChXHbjNWKiqbVYsm1QsgDMdT9Rn+GvwFlymQv2kBIvFotzJsvjJKiKEfGuuEEepG7rG
         GtKQxRSMTAtOvUV2FNX6XbqBfiAjIYqBv0z2hM25sJ5o9MQKeNh/6+u1UE7Bsy2+vgJ4
         lGECuwZ0RhNpYQSQX4ixHiuQdi6DxANmqC5E82oR/0vWZNPL9tDm1JX5J1lZ5VQhayUa
         dHIQ==
X-Gm-Message-State: AOUpUlEbSIxFuqV/acaABr9SUi9TAjnVxHTM6tsKFHBv4AWhYaqtVEOW
        AzWsRi2iekQoyTKhU1/P+p2wi8QSswG6xz6JWDJ4SQ==
X-Google-Smtp-Source: AA+uWPzwuEZSg5EyjoUZd2bw47oizybH288KUGks1HuvC5+a5fPK0dwTOsWlZrsZU5d6GxtpmK/bgfK5DAM46EAQ2l8=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr28461912ioh.259.1534903782104;
 Tue, 21 Aug 2018 19:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161357.GB1199@bombadil.infradead.org>
In-Reply-To: <20180813161357.GB1199@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 19:09:31 -0700
Message-ID: <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.19
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 9:14 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Please consider pulling the XArray patch set.

So this merge window has been horrible, but I was just about to start
looking at it.

And no. I'm not going to pull this.

For some unfathomable reason, you have based it on the libnvdimm tree.
I don't understand at all wjhy you did that.

That libnvdimm tree didn't get merged., because it had complete
garbage in the mm/ code. And yes, that buggy shit was what you based
the radix tree code on.

I seriously have no idea why you have based it on some unstable random
tree in the first place.

But basing it on something that I independently refused to pull
because of obvious bugs from just a quick scan - that completely
invalidates this pull request.

Why?

I guess it makes this merge window easier, since now I don't even have
to look at the code, but it annoys the hell out of me when things like
that happen.

There wasn't even a mention in the pull request about how this was all
based on some libnvdimm code that hadn't been merged yet.

But you must have known that, since you must have explicitly done the
pull request not against my tree, but against the bogus base branch.

And since I won't be merging this, I clearly won't be merging your
other pull request that depended on this either.

Why the f*ck were these features so interlinked to begin with?

              Linus

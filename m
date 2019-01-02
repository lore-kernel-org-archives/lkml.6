Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E8218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TDyu69lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfABRrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:47:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38467 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfABRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:47:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so27329057otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hBUk8Mse5SprcZveZ649K7+7VQzzipNWH9bsLfG1zs=;
        b=TDyu69lZSUHU/VU7Ss2yo6UJzSknmMCUOHHR1EQDCiw2yNvY97ekNE8jOmsUl0EmTY
         61ge1HunQ8fGibGB88QKzLie1fF/v7IE7xxdbwWDImQUcORxvHSY/k4s7ZmPIVy37XLr
         xJKiRqVlBW+w2PFwTuoGxZyRC2kaI4Z6SwgLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hBUk8Mse5SprcZveZ649K7+7VQzzipNWH9bsLfG1zs=;
        b=DF89nEJeafzRKBDBhKmbtsRL93CUYfSAaZQG731TaEV9f/zTh7FtrhBUr21WmcZvDr
         7NF+sogMNKB5MlSL4ZbWpJIdM+AI5eXFZXXRG6gRm0SaUtCUmrqMDskfE7kqbDXvbJj9
         Eo7PkE3oHUOPmrVTRcar+J/tEg/PXplkoJJv7QyUYBcQHa6lyi86y5L3brzY5BYGk+Nf
         AF1K3JB3d8pyezUnHCYVZKKD8WWEQnt3FfD7bS/pSCDd/bfHTV0NoJRiN8+14D4g1Ch+
         icZViESKnG4afwRgB3LPIrU4xkFbBHsKnQnOka8w/qaxZC7Rz1C9EFEvnwuFfdjmF3Y9
         8JXw==
X-Gm-Message-State: AJcUukdZhVGpJgkxWiZmBUgayMBvF7iyrs4SeLGtTf3kI1WK2t3Eo1YU
        jpyGcLrEaKbvXzUaMaubzj4aAb3LLZ24nuXuPqLCPw==
X-Google-Smtp-Source: ALg8bN5Q0vtZNj9c9C6J/ihvx9BkDJAA+ekzmZVGE31cgguG5Qo9I8KwhxlPZUvc9TmgT+bkTPAEpmgOe2kAPhrbP5A=
X-Received: by 2002:a9d:1f3:: with SMTP id e106mr29318143ote.369.1546451272726;
 Wed, 02 Jan 2019 09:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20181203170934.16512-1-vpillai@digitalocean.com>
 <20181203170934.16512-2-vpillai@digitalocean.com> <alpine.LSU.2.11.1812311635590.4106@eggly.anvils>
 <CANaguZAStuiXpk2S0rYwdn3Zzsoakavaps4RzSRVqMs3wZ49qg@mail.gmail.com> <alpine.LSU.2.11.1901012010440.13241@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1901012010440.13241@eggly.anvils>
From:   Vineeth Pillai <vpillai@digitalocean.com>
Date:   Wed, 2 Jan 2019 12:47:43 -0500
Message-ID: <CANaguZC_d2EBmNuXtcJRcEcw8uXK234tYSXx6Uc2o9JH_vfP4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: rid swapoff of quadratic complexity
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 11:16 PM Hugh Dickins <hughd@google.com> wrote:
> One more fix on top of what I sent yesterday: once I delved into
> the retries, I found that the major cause of exceeding MAX_RETRIES
> was the way the retry code neatly avoided retrying the last part of
> its work.  With this fix in, I have not yet seen retries go above 1:
> no doubt it could, but at present I have no actual evidence that
> the MAX_RETRIES-or-livelock issue needs to be dealt with urgently.
> Fix sent for completeness, but it reinforces the point that the
> structure of try_to_unuse() should be reworked, and oldi gone.
>

Thanks for the fix and suggestions Hugh!

After reading the code again, I feel like we can make the retry logic
simpler and avoid the use of oldi. If my understanding is correct,
except for frontswap case, we reach try_to_unuse() only after we
disable the swap device. So I think, we would not be seeing any more
swap usage on the disabled swap device, after we loop through all the
process and swapin the pages on that device. In that case, we would
not need the retry logic right?
For frontswap case, the patch was missing a check for pages_to_unuse.
We would still need the retry logic, but as you mentioned, I can
easily remove the oldi logic and make it simpler. Or probably,
refactor the frontswap code out as a special case if pages_to_unuse is
still not zero after the initial loop.

Thanks,
Vineeth

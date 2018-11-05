Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C878C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B0D20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJ6BOD5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B0D20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbeKFD4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:56:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41837 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbeKFD4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:56:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so8994730ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6Oj6LMobWv0rkTof5rn6OOvXppEv/CSmsab7vzk7/0=;
        b=aJ6BOD5bAFpSuDwGt4t0l4mmxy+pJ/6vgu2RA7wyR3ictd7NuKn9euJ8h4AmX61deW
         4NPL0rRYfAaiVmhfhNSY+12YRRZcCalNo8+b3ts6EpwppZC7hJo6deOInasyftrmABMb
         CvtdKZHtowF+trV+FA1/R6R5ew3j0OqazcNAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6Oj6LMobWv0rkTof5rn6OOvXppEv/CSmsab7vzk7/0=;
        b=pbsWtklm4yzYBs/x1nFTVc5+iR/0ywSEaKtqwAwpg+u7zTQvLXvSGvFJ3uoWBIYLHU
         m3ZrdoBMGatwAPfDb7bj1QkksSYZM1n113AGgqXKEIG5aSwMieJ0TnK2MsQezeKxqAdg
         uy6YNIenH9YD7+Pk4Ll/3RTZ/XSxHZApyaIUKFOiwvGHqg3MRrGMiIC65GA+RE/H/4Ep
         bfZ9Xc29wS2/qQFCzdz/s45F3mCMGMHWdoEDuwq0PSje8gBeiA11Nh3nciTZi4qG1Gi4
         hXolhN7aSrPKMcRiaxjHt2lzvvdcFIahW7Y5DgNaWyJC6rgiPq9pybmuPoBUULjPOW3I
         Tu8Q==
X-Gm-Message-State: AGRZ1gIqHFz3RyyYWXhYr5fkY2M2A6zNG8sRG2j6e2didnSfENou0EqF
        ZtEj+lg+yuTNj4dUccdmT/ay/MX3W2mWRw==
X-Google-Smtp-Source: AJdET5eK7IteExI2d/Up4tAH8P3JgyF2nzSNuy5y/AOKsCsOXVyLumHtLUnGYhQc/AngEr2vFwkjKg==
X-Received: by 2002:a2e:9a56:: with SMTP id k22-v6mr11380664ljj.17.1541442949984;
        Mon, 05 Nov 2018 10:35:49 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1899487lfi.40.2018.11.05.10.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 10:35:49 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id u6-v6so9033626ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:35:48 -0800 (PST)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr11443510lja.148.1541442947860;
 Mon, 05 Nov 2018 10:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20181105050813.GP24195@shao2-debian> <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <4feae9c4-432d-a362-58e4-11e0cb10b24d@linux.alibaba.com>
In-Reply-To: <4feae9c4-432d-a362-58e4-11e0cb10b24d@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Nov 2018 10:35:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whr2Aio3R49TVWqW3es6heyxXDuxGHcv8Bcc=_kw4vDeQ@mail.gmail.com>
Message-ID: <CAHk-=whr2Aio3R49TVWqW3es6heyxXDuxGHcv8Bcc=_kw4vDeQ@mail.gmail.com>
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1% regression
To:     yang.shi@linux.alibaba.com
Cc:     rong.a.chen@intel.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 10:28 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> Actually, the commit is mainly for optimizing the long stall time caused
> by holding mmap_sem by write when unmapping or shrinking large mapping.
> It downgrades write mmap_sem to read when zapping pages. So, it looks
> the downgrade incurs more context switches. This is kind of expected.
>
> However, the test looks just shrink the mapping with one normal 4K page
> size. It sounds the overhead of context switches outpace the gain in
> this case at the first glance.

I'm not seeing why there should be a context switch in the first place.

Even if you have lots of concurrent brk() users, they should all block
exactly the same way as before (a write lock blocks against a write
lock, but it *also* blocks against a downgraded read lock).

So no, I don't want just some limit to hide this problem for that
particular test. There's something else going on.

                 Linus

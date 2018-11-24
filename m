Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1920645
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cyRKMs8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeKYExr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 23:53:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45867 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKYExr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 23:53:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so13081794ljd.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 10:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6GNGNjbiUxgFxx++1dKO5jnV7cHRvKFvvkRgWZwg94=;
        b=cyRKMs8qLv4Q1rBsCEvflSgXQVWFeqyl3IYw15hj74GYGrT3sqR7cx1pzFGv6PB5q9
         WtQ8JEjYh0S8WD5nyNFovt1OC3fAshRDFHkt9yAbIOxTA1sJVyAA/TCGfyTCePuQnYQf
         Wons0sqgmNlF2obcr02R8GbzwZncFzuiZxTJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6GNGNjbiUxgFxx++1dKO5jnV7cHRvKFvvkRgWZwg94=;
        b=W5MdYhCEt4DH5o506h/jeHLdIvGp+mKs9feFSo/34kllj/8L93z7VNFnN7ObWVxbtF
         tj1+cl0e9xobcYBpoeZRmdZanLQEeezHPbvYSSyM3cmfmqNAiQqZd/PYK4NoBmnq6hlr
         gzTqrdwSYFXYngVoDXpTTRHGmq4h+z/eXCTifo1z6IcQYW1dFzi49kLmXAEHwuw6/mRq
         uv01WTiBLkJDv9yg6gjzc/aiLO3SLpcPWBE9TNZ3EeTcNo+8mBysOQGL8mLMFKXlBZKm
         MaMjjHQ2ilNBWIzWHoPgxnsQWOYz3s7cXJl9/pXSGz4Z7GLhZVngMykXzio+KrVL9Pt7
         Lruw==
X-Gm-Message-State: AA+aEWYMN/DMC2R3oGLb1+g8rfmDHbzlyPgUcpNqcJhVvrlZvdGmvOeG
        1KlZJJC4bm5+OfcNqB+nXfy9M7gWyJg=
X-Google-Smtp-Source: AFSGD/VhraeJuuMYp0brq3mOuN9ySZecgQCCi9oYEiXr4nEvzWKTantNydN4mdg23DUBvajjJXR6cw==
X-Received: by 2002:a2e:94ce:: with SMTP id r14-v6mr12932233ljh.34.1543082688683;
        Sat, 24 Nov 2018 10:04:48 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b81-v6sm5653302ljb.7.2018.11.24.10.04.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 10:04:47 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 83-v6so13074584ljf.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 10:04:47 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr12546119ljh.59.1543082686922;
 Sat, 24 Nov 2018 10:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20181124173209.GZ3065@bombadil.infradead.org>
In-Reply-To: <20181124173209.GZ3065@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Nov 2018 10:04:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
Message-ID: <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
Subject: Re: [GIT PULL] XArray updates
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
>
>   git://git.infradead.org/users/willy/linux-dax.git xarray

Can you *please* make that a signed tag.

I don't trust infradead.org implicitly, so I really want signed tag
pull requests.  I may not always notice, but when I do, I abort the
pull.

The only site that doesn't need signed tags is kernel.org, which I can
ssh into and I know and trust the security model. And even there I
really prefer signed tags.

                   Linus

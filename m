Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4271BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F77218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T6pg698U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbeLTSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:35:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:56081 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLTSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:35:27 -0500
Received: by mail-it1-f196.google.com with SMTP id m62so3438992ith.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtumSwBzP2k2ql4LvJowB4lWSEg8+PLtrSCsqa/4qIg=;
        b=T6pg698UH0hUr4kZRSAnuMETvkzpYmQ1zzdoKn/KwTGUkR+3CU6gZ5FGdS4enf+X0W
         Y4qbxehoVIOqGrNyBhhZml9KOd5HG1IHKJQv8HK5NpUlTiga83EHflauZW4FssxPB4aB
         GjalL+pGXMSCBogvPapQgH0ygBJO8v9wW7kOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtumSwBzP2k2ql4LvJowB4lWSEg8+PLtrSCsqa/4qIg=;
        b=UxeWf8JD2bh+Jf0StsqGdqAFLRNIBvqz4Y7AV0oGGNnqexecjvwcQSfDISkUbqvHUx
         ZBle07M+1zfeurJ9RcWqjWnyPEPYSQUzD12aSrZN/+9xP8j4ciq020Mn47tCQeh3owrt
         zIbHt/P6slMg0NsGJGqmAAGcvqKqmXOtJQL7HbUpl7UcSYjOpwENuYvwX9HO8kNTLUJl
         +EXkZxi4/2INFMrS29fWtH09asmK7tCg5kRJPDdJccnjBv9YkKm8h4Se18v3HX/6ZgD5
         WQmyxXP94zLNNC2y8027s5vKRR1eP1i51fs009jrmFdWvpBt2dnwNPBPGDDuvjwrf5SL
         xfwg==
X-Gm-Message-State: AA+aEWaMVJ9UPikNZlpQlwHNP6SSKmy8zvxDQqMZlfJy+PkRpnufLPl8
        3pC25qcoduaanD1MjFVLyt3FhHDzLhtkzBy7PXceFg==
X-Google-Smtp-Source: AFSGD/V1aWZJ+94ttxVxY/nN5O/69LRIM/PJUKhLbkXkwTUXmgQb9X3GEoA/iNpTZuew18vfmlqaykaqcBZPJX6asTU=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr10575456itl.51.1545330926649;
 Thu, 20 Dec 2018 10:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20181127103252.20994-1-andr2000@gmail.com> <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org> <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
 <20181220173950.GA19641@infradead.org> <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
 <20181220183311.GA30801@infradead.org>
In-Reply-To: <20181220183311.GA30801@infradead.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Dec 2018 19:35:15 +0100
Message-ID: <CAKMK7uFxU9Q5u9TxxHqAgFZuQFCFDvxWHDtRLiQf+3hu_4jPcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 7:33 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 20, 2018 at 07:29:37PM +0100, Daniel Vetter wrote:
> > What we most definitely not want to end up with though is actually
> > streaming dma, because with that all the zero copy buffer sharing
> > tricks become pointless. There's pretty epic amounts of hacks to work
> > around this, I have no idea what's supposed to give here.
>
> Err, with streaming DMA buffer sharing is trivial.  The coherent DMA
> allocator is what causes all kinds of horrible hacks that can't actually
> work on various platforms.

Hm, I thought the streaming dma api is the one that causes bounce
buffers and all that fun. If you're unlucky at least.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

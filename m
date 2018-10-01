Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059182083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AOagu1ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059182083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeJAQDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:03:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38915 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeJAQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:03:01 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so10430631itc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H70Cz97l6J103ITgOrVgob8ZYlE0MLopxBm0tSP3nns=;
        b=AOagu1ze3WjkvUovo3PchzHGYKqMijolhiLf6ndqTlkAhOYJ/DBKsS+Y01kJOUe2So
         3iY8m1jxAQKy9U7saN4EnQqfFlT97YvsHjzK38D+QqKRB2S8YyAPgtlYvc81acsbsiJ/
         j+cXI3ziS9xOiMf/ie22O3nqSuOTW7f/J1ZOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H70Cz97l6J103ITgOrVgob8ZYlE0MLopxBm0tSP3nns=;
        b=OrbWvXTMMSM+WSYaoeCO1ybxpHZzMSlx1lIn1GcJ1RKAT3Ryw6cbOhVV7NygTo48vJ
         sPpOCOUJfQLO7kbVcPqvhIR/6haD12LGs/GylKdO4naWyS4t8euywNvKwLWBdyJr6qHq
         iFF0C/2XNTvYU/jhKdmCTQG0RlPAECfqHzDQkvLsOrCAbmLACXdiNp9jSvOQVeNqMe3G
         bOObI3Ab5TlUn7LcfQj9yPXqfVcvGiMHxSk7nnTLn6GB303f54l3dNdpd+SSXQEcPNlO
         q+nkVwQiqifmNHWZhOaT3M3derD2IeMVntpoKNj0BY+rvg/Wd/UwTZ95ObFaXcE8FcNl
         Saew==
X-Gm-Message-State: ABuFfoi/n25xcCVTU7o/2zWHhPQyZOsTzZAGOD2Qy9aEJy2YLbRS/s21
        4HcxIfNPmeiMT5nOzf3NpdGyV2mVr/J2lArTYIlFNA==
X-Google-Smtp-Source: ACcGV60iO7w4hpRpt5bYACxMjr7c5U9V9s1zt8b5LLD47aaSFE8giOQzoFJNqaHSMTFHrVUV2xKQKahunktr0XA3Woo=
X-Received: by 2002:a24:2744:: with SMTP id g65-v6mr5359221ita.47.1538385971058;
 Mon, 01 Oct 2018 02:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:26:10 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <153786915356.22029.14929917223689579717.stgit@localhost.localdomain>
References: <153786915356.22029.14929917223689579717.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Oct 2018 11:26:10 +0200
Message-ID: <CAJfpegsPkKb2Gfd65Yq4qo6dgyCB2Wzy10FYXhzoMbXQW67U=Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix use-after-free in fuse_dev_do_write()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:52 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> After we found req in request_find() and released the lock,
> everything may happen with the req in parallel.
>
> Keep it alive till we finish touch its memory.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Applied.

Thanks,
Miklos

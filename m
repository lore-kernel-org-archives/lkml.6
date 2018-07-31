Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466E720870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FZ794N57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466E720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeGaKXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:23:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37008 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731428AbeGaKXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:23:49 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so12285761ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y/S/8t87oaC2EBEMbM45S5rybsFc5/ycCKWIcl6QofU=;
        b=FZ794N57KPW+MibMDJfuGaObupM2wXWofMViQab5fS1rxPUgbBpPiGGVpYRQsk8olK
         5P0aotFOSs7MNH7aclSQr9CZ0NlmQ+DW3KEfje05Eq0lE/1TeOdOI5nisxytn4jc71gl
         A6DgZvU3JN/3UmvaBiazTleF36lKeDQEVGjeRFn6lrs+pEs36x1QUV+4HpUcJ/sE34wL
         8oNNJP9mgbofYDD79S1n4AyshSA995r3GSa6U1m1+oFbGRw/DrXme3PsNGOjBMYnYKH2
         /Tydjm7zn7Ba8C56q7gTyaiJLrQiSG+Yrrlu3qxpsWesIAxde85sIMudokTf+2fvIra0
         dl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y/S/8t87oaC2EBEMbM45S5rybsFc5/ycCKWIcl6QofU=;
        b=J5F8ro3m9yKAJ5vLF5SYG6RAaUfP0X9Pk1UD3sYqorn0sev+oGAh77teRUyVUbEtgx
         1judzLtz/nU9sgH+9SmwWVltWkFG8W/0dfZ9q9sYMb9K6kdOCVGlFfLe6/9LaLZpPyXI
         NGUWbXOwPL84wMB7tchU1PqJoVtqnlMGJIAUGG8/3ddJr1A4T6jD35yu02+f/oCHYxgD
         BDzv0nNuJG+XfZdZS6PzTVQdHVAgtGJX3TnmC+OOnXkEmdg7eLc3W0WGyIc8Z3Jjs2Iv
         xo/rrrKJ8aL5XnaqAWmSorgSe3/mWyp/Cwcqi1gMuUaAm8+I3ZmFRXdQfB5N2j71a6uJ
         KpSg==
X-Gm-Message-State: AOUpUlF0/UDeJBif59TAP0373eN68henldsIg/ah2OxiyzJLJMRuxcD5
        EcTnhKSq/yB7fOL8Zy8Sm1bAPZpurA2Nie0iVC8mFw==
X-Google-Smtp-Source: AAOMgpdkQ/yIjGTon1U13VuNIcigRNLD2aBuKMLU31jthWA6caSxkyZOaeKx06PQHmlX7gYXv6y+NYCGPGTy6QEK8fk=
X-Received: by 2002:a6b:b284:: with SMTP id b126-v6mr16102320iof.201.1533026674026;
 Tue, 31 Jul 2018 01:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 01:44:33
 -0700 (PDT)
In-Reply-To: <20180730203633.GC12962@bombadil.infradead.org>
References: <20180730143710.14413-1-christian@brauner.io> <20180730143710.14413-2-christian@brauner.io>
 <20180730163155.GA27761@infradead.org> <20180730203633.GC12962@bombadil.infradead.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Jul 2018 10:44:33 +0200
Message-ID: <CAB0TPYG5T_d32iwt8Lgq_nDO_COWfWBfuSzErraASSuTYGm3yQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] file: export __alloc_fd()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, rlove@google.com,
        ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:36 PM, Matthew Wilcox <willy@infradead.org> wrote:
> I'm not entirely sure I understand the binder code (... does anyone?)
> but from what I can see, it intends to open a file descriptor in the
> process which is the target of the message being sent.

You're right.

> That strikes
> me as wrong-headed; it should be allocating a struct file and passing
> that file to the other process.  When that process receives the message,
> *it* allocates a file descriptor for itself.ho

We're looking into cleaning this up (historically it was done this way
because VIVT caches made this not very efficient), and this is indeed
a very good candidate for fixing it.

>
> But I think the binder user-space API relies on this.  The userspace API
> seems to rely on passing fd numbers around ... but I'm having trouble
> figuring most of this user API out.  Perhaps Martijn can help here.

The UAPI does expect a file descriptor, but we may be able to do the
mapping from fd to struct file (and vice-versa) in the kernel driver,
so userspace wouldn't notice.

Thanks,
Martijn

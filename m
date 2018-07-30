Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C29C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5F720857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CKSNLCWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5F720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeG3XND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:13:03 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34863 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeG3XNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:13:02 -0400
Received: by mail-io0-f182.google.com with SMTP id w11-v6so11187723iob.2;
        Mon, 30 Jul 2018 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JOgEOjCmg99sfN8iOfftmv0bGK5aijQRPJvVlw1qVs=;
        b=CKSNLCWCFsOvOr323VVmAU77pbEDYTABM+sbQarX76u1C4vFsGQxj0xv2nff6/Yrvs
         ElF92XqpIJj/RiO9urr/sxDjLvkefuONVeqvtpl9lBBT4eNFNFgIIbqKsNyvp2sckDZD
         K5LslnoqyoTTswqQQ7vfeV9ha6/kKSqtGW0Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JOgEOjCmg99sfN8iOfftmv0bGK5aijQRPJvVlw1qVs=;
        b=jFXVuhGZ2/AGnggVROCn7l9g4H1NOc86m3YwOOpWhV+tjbN2IcdSgkQfRHDiFaxICy
         TH8FFUeosc7Q2WSwKZwvy4VNi9kjStKLwTDfEhrYRIX/7Vy6VgobICN6TObLkq7z+TxG
         VGv1bmMTSFoKfwnk/qcl7yP5WbHO3mVAMpSqsbAxPxhgVnXa2mG/E/hA1CeDZNK44rMo
         +dbMq96Y0UOCQsqt9qv7oR8KMCBF17PKsOVqeyThlTfdVol2LFCMW+cXtw77Tlhxdtpa
         L/ZVZs5yXDt46YRZ40/746ZjmY5Qc0BiebOX43S7wjLV1oOudwsKZmh8ttrgTBnhy25i
         gvUQ==
X-Gm-Message-State: AOUpUlETN3UZtJ6yfS+12+34HYetR1GU64Q57jpMXGPgllzh/8WPDO13
        h3shDfj0aHjLQVkTwfDrW0kJh1ZYrn4O0s4FGgrL6g==
X-Google-Smtp-Source: AAOMgpeHdYSYVldfdUMDE1hTdVA3+OeU8ToCHjVZmgfMPU1QQpDGSLMDJpdKtiP81PlBir2f5nl9KqGC/NZFPly8ItI=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr15791208ioh.259.1532986567297;
 Mon, 30 Jul 2018 14:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
In-Reply-To: <20180729220317.GB30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 14:35:56 -0700
Message-ID: <CA+55aFxeLRE3mXK=6JEPF4gpj+eb81mPyDd4KPQtqDd4=RdLNg@mail.gmail.com>
Subject: Re: [PATCHES][RFC] icache-related stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 3:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Assorted icache-related fixes for the next window; some of that is -stable
> fodder.

I don't see anything alarming in the patches, but "some of it is
-stable fodder" looks wrong.

The only one that is marked for stable is 03/16, and that seems to fix
something that came in during this merge window.

It shouldn't be stable, because as far as I can tell, it should  just
be fixed before the 4.18 release. No?

The rest looks like fine cleanups, but not stable (and certainly for
the next merge window)

Am I missing something?

             Linus

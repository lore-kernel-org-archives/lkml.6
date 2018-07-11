Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0294C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B2208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FylggPa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B2208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbeGKClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:41:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37931 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:41:18 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so22252567iog.5;
        Tue, 10 Jul 2018 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAVABbhF8XJRsBPihMY17bl9+o6JNutp1ggVaRvEsDY=;
        b=FylggPa3a2MH/JUFzORdExdelemLRHUREeYnhl3nowflxwl8UQigYMT7Jhf3YFsNMQ
         xElFg1G2wAGItOoiIyltEZyWmAcOA6cBAOJqbwvkuvYLD39x6cAXKrCTB1PGfYFnH+vB
         J9m/8UAPL9sahwHSQ3mMLSJtmSnH1+Zq/4QCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAVABbhF8XJRsBPihMY17bl9+o6JNutp1ggVaRvEsDY=;
        b=tdhSShzUFMnks9ibjZg6yoHCg09J9qUyIXAFMZJyIne43qMg976Y87Jq260/DdMEFV
         +FichRLVIegmED54udiga+2pIxvVS+eNVXh61lsUVFfyKWuGuYBoPm1Jz9zJlXOlJAZc
         rFDUSxXGDT79jhpnIao9TvwV9QY9HPO5lTS5gjHvI86FFJ5RJMCORxI3PkO+aPON0zD9
         sR/4POM3T3iEj+CWZB17LL2EEhkAO1hLkveltUA0J9OJUjuIgUHNxk39WkICMvGIliF2
         tEzadaZANAvZSFK3b5FCc1JME6aJtLBf9wYGiIFba4iG0zfUiZiusSI+OFoLi5/6q7eF
         HxPQ==
X-Gm-Message-State: AOUpUlHMoBK8ksEtGY5F126m4lbQYDCN4G0g5c+MuDVP3MdrjrkPho8B
        35Elg7LKCZ/BWmYqqAcuDEkf17Bpic6Rv3GhvWU=
X-Google-Smtp-Source: AAOMgpfX2ypa+j+FUxV0rq7srytlQKTZasrExvcgNUOYBmyuohvDm1L8BG5wBB65yb6jgSnfiXZwExSaP1dIf/NUdhE=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr23999290ion.259.1531276758351;
 Tue, 10 Jul 2018 19:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-8-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180711022206.12571-8-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 19:39:07 -0700
Message-ID: <CA+55aFzcXNLZ7__OCWDwkDgeQuC=kxzxVW-CYJ-T3MwhtXed+Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 08/42] make sure do_dentry_open() won't return
 positive as an error
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 7:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
>  cleanup_all:
> +       if (unlikely(error > 0)) {
> +               WARN_ON(1);
> +               error = -EINVAL;
> +       }

Can we please do this as

        if (WARN_ON_ONCE(error > 0))
                error = -EINVAL;


instead?

That already should do the unlikely for you, and *if* somebody can
trigger this, at least they won't be spamming the logs and making a
mess. A single warning is fine.

             Linus

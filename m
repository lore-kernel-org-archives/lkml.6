Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57FFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DEA2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DEA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeINUbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:31:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45883 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINUbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:31:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id g44-v6so9012456qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVQKIxQXIMKJcOVmEaNL/qEXJzwJ44AGT1gvY5QUhYo=;
        b=jFNAbx5YmnyHUMKD6rBInFE+SILhG7Crs9/txzgHHI/OGspj2OJtO+gISpPMga0DNH
         w996zhcEO81GG5Jtwsoy1LjdaQsGLJluDfH/YOAOn0ysDT7BQxNLjcrHnBYpvCU5YzhS
         rEdpJcws6t89ez2v6lzGsVQpGoryNviBQqgdIlXbU7k+mNQcZEXWCwFOd/k9tLNqiZgn
         ZbP3VBGl+6458dj9p3rk9ESUy2qDZFU+Vng98XqPMpVJOWCY+zTKNhCqC6a4bKN37HK6
         6bfPPeQ0tQ7pp3TkHrtbqWH1lctUTjSk5lZti4haJaXPf+BuVQxSFGKcI4c/P/pyZ0n1
         HxRA==
X-Gm-Message-State: APzg51AJnLIWVvZqX1P5OiaqrO0LFDq/1/onrskvGWCgWMtPvViWxu/y
        heAq3rXeuLbeN63rv7MnO150KL08f25PqJMIEiF9+T9p
X-Google-Smtp-Source: ANB0VdYKBwmbumDHhfFmpJC8UQ/BH8M5U7ywCy4jkVee4pdA7x0Ua4UI4MdOyqXvatBUpLCshLqD1A3n+BuwhpXpYdA=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr9298901qvm.115.1536938168703;
 Fri, 14 Sep 2018 08:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180913024049.24567-2-viro@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 17:15:52 +0200
Message-ID: <CAK8P3a1feqfJOTvQEC+tmdYToGzL0zmKLQmGzPe-UQry0AuW-g@mail.gmail.com>
Subject: Re: [PATCH 02/50] move compat handling of tty ioctls to tty_compat_ioctl()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> ioctls that are
>         * callable only via tty_ioctl()
>         * not driver-specific
>         * not demand data structure conversions
>         * either always need passing arg as is or always demand compat_ptr()
> get intercepted in tty_compat_ioctl() from the very beginning and
> redirecter to tty_ioctl().  As the result, their entries in fs/compat_ioctl.c
> (some of those had been missing, BTW) got removed, as well as
> n_tty_compat_ioctl_helper() (now it's never called with any cmd it would accept).
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

One more thing I just remembered when looking at my obsolete patches:
Your patch is fixing a couple of ioctl commands (I had identified only
TIOCVHANGUP and TIOCGPTPEER, you found a couple more)

It would be good to mark those as cc:stable@vger.kernel.org so we
can also get the fixes into older kernels. Looking through the
series again, I did not spot anything else that we need in stable,
in particular I would not bother with the compat_ptr() fixups there,
and the many cleanups of dead code and setserial wouldn't
be stable material anyway, but missing translation seems important
enough.

Looking at the changes in your patches, these are the ones
that you add in tty_compat_ioctl() that did not have a corresponding
entry in fs/compat_ioctl.c:

+       case TCSETX:
+       case TCSETXF:
+       case TCSETXW:
+       case TIOCGETC:
+       case TIOCGETP:
+       case TIOCGPTPEER:
+       case TIOCSERCONFIG:
+       case TIOCSETC:
+       case TIOCSETN:
+       case TIOCSETP:
+       case TIOCVHANGUP:

Should these all be added in a stable backport patch?

        Arnd

Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110CFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F8720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CEHyUHzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F8720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeKGN3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:29:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53220 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeKGN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 08:29:25 -0500
Received: by mail-it1-f196.google.com with SMTP id t190-v6so15402482itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 20:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TVMpBB+/DkTSAzbKQ3yKJofOCjBMw+vqbxmlxaqX54=;
        b=CEHyUHzJEVdMEAPFT0/PCRezrhZMPNt25858rx6geg59XNvxrqYoKuIkUnGG8DyGbw
         PprzOle/uxVVVyYrSNaMnLJMYp2jctdJsH6/8gADp1nUZMBBxdDWJl0E5SaDrxlJT02t
         FSH+zTdmiwLOSji1E0k/JTKz6DraZP7XGrtnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TVMpBB+/DkTSAzbKQ3yKJofOCjBMw+vqbxmlxaqX54=;
        b=oYt7s8ZCSEjrwOAm1nlJ2PJfhqXq/96unpV0p02mLajmNB0l5r7hTUxFn+pMi1RhVi
         8MY3rQQjOjpFWcu7IOrvxzcn0OdKFuKCqhasYFNMPw7JrFQx5nyAhtWkF3aiQYCR1nct
         poHiaZZGHTYNDvjnE4xbd7s5ZZSkhgdEHxuTMQ1FXsrpec/HxPRVnTk48sSn3d4v0Th5
         +pnvVAh+sYqjyktYqJPJp4T9FEaheeykkComs13kKxsws60iazRG5I6cEEDpp4Hf4r2e
         GAZwahPV27Q5kaYNOjhtQQ3C2sjfGliTR5Uq5iiejaubTqkqvDFzIGTNaxxMf003Pze+
         D2JA==
X-Gm-Message-State: AGRZ1gJ0bPR8p7umQg93eEIY9S0tMybjApyLNM8ByLl7IvDNChxW1mZy
        9ykg3N0QygR2Zg1pDeKtPrmCQxbTzAI=
X-Google-Smtp-Source: AJdET5dj0frR6FOILR9GoqDzuhpkNUJQZ8MXuKG6/cXx/aqhZOJoAEfe4reDQMpEZ5NiTl3b1Uu+sQ==
X-Received: by 2002:a02:3545:: with SMTP id y5-v6mr234718jae.7.1541563250937;
        Tue, 06 Nov 2018 20:00:50 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id f2sm1498628itb.44.2018.11.06.20.00.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 20:00:49 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id a5-v6so10963634ioq.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 20:00:49 -0800 (PST)
X-Received: by 2002:a6b:dc06:: with SMTP id s6-v6mr178399ioc.139.1541563248803;
 Tue, 06 Nov 2018 20:00:48 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com> <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 6 Nov 2018 20:00:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
Message-ID: <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     lists@nerdbynature.de
Cc:     sky@genki.is, Guenter Roeck <linux@roeck-us.net>,
        yamada.masahiro@socionext.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:58 PM Christian Kujau <lists@nerdbynature.de> wrote:
> FWIW, the issue I reported back in 2013[0] was not an ill-configured NFS
> export, but a read-only NFS export (and then a read-write exported NFS
> export, but the user compiling the kernel did not have write permission)
> and so "test -w .git" did not help in determining if the source tree can
> actually written to. And depending on the user's shell[1], this may or may
> not still be the case.

What do you mean, "depending on the user's shell"? AFAICT, it's not
really a shell-specific question, since POSIX defines '-w':

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

(I highly doubt we care about a non-POSIX /bin/sh.)

But the dash man-page you point at is correctly noting that 'test -w'
isn't sufficient for noticing a read-only mount (i.e., you have
permissions, but the mount isn't writeable). Contrary to what Guenter
said in his reply, our build isn't actually off a read-only mount --
it's just running without these write permissions, so 'test -w' will
do the right thing.

> So I'm all for the $(touch .git/some-file-here) test to decide if the
> kernel has to be modified during build.

I suppose that could work, if you do that only after checking 'test
-w'. It's important to not even try to write to the source tree when
not permitted.

On a different tangent: how about the --no-optional-locks (see
git(1))? Will this get you your "up-to-date" result without writing to
the .git directory? I've only read the documentation, but not tested
it.

Brian

> Christian.
>
> [0] https://lkml.org/lkml/2013/6/14/574
> [1] https://manpages.debian.org/unstable/dash/dash.1.en.html

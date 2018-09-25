Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D39C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFAB20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFAB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIYSOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:14:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45453 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIYSOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:14:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so12976988qtr.12;
        Tue, 25 Sep 2018 05:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojtbzqXI3SRj+RwYW3lH4Vt2p8Ofq7raDT8qoqyhBM4=;
        b=FjTVsqGS7MPeTCfC/iZldU8mEWBf5oifcYr0GaUe61qUFy1x7xWztZPV9PmiY2vwpb
         VY6C00xEcXBhAA6DPxAU+0O2JqOjZn0pqh+a6bfA+5SOGNPHw6DhRSs9ZLWh7QJR7dUH
         0b49gF9mBvnYreKoIwNjOLncGFALT6C83wfx9+OcaXJTrcVjM6bFkkomL0vBD3QFJGw6
         xwtmtE1NG7x5voZ1l0/FjMvBtJEMR1l/n0h63iPG++S8dqJhXx01VTGF8BOnjV1fCUJT
         DhF4W7nFWZFIH1LDpg+oLFKbt/nEwkVpRQXqiE21xJucj4nEh2HBMp4KaUjIrOJzdHAS
         NLKA==
X-Gm-Message-State: ABuFfog9DJA8o/hI8CCyKlaLGg/XaCWPY7rbEZoNuuMSxTAKtcvXQZfc
        0e+Zfhyj2XDeHG3nW/b9bv9bUCp2oViQhCPW2Bc=
X-Google-Smtp-Source: ACcGV61o8vuWUhK9fziAR/XtjPWDgDeMvjjNLRz//tOLrZXGYyfn7k9khval6P5U338f2JICdf4eZVFlynlDdba2qwo=
X-Received: by 2002:a0c:8834:: with SMTP id 49-v6mr504879qvl.40.1537877215131;
 Tue, 25 Sep 2018 05:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
In-Reply-To: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 14:06:38 +0200
Message-ID: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
To:     alexander.lochmann@tu-dortmund.de
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
<alexander.lochmann@tu-dortmund.de> wrote:
>
> Hi Arnd,
>
> I recently tried to disable the BUG macros on x86-32. I disabled the
> config item in 'General Setup -> Configure standard kernel features
> (expert users) -> BUG() support'.
> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
> include/asm-generic/bug.h (line 181) the code checks for the existence
> of architecture-specific variants of those macros.
> Since x86 defines its own version of BUG(), line 182 is *not* used.
> In the following, the x86 variant of BUG() is then used to define the
> BUG_ON() macro.
>
> I propose a patch that really disables both macros if the developer
> wants it.
> It undefines the respective x86 variants, and defines both macros as
> 'empty' macros.

Maybe we should update the documentation instead. Note that the
generic version is using 'while (1)' rather than 'while (0)', so this is
not an empty macro but rather one that does more than the
arch-specific one-instruction version does.

We don't really want an empty macro any more, this was used in
the past, but causes compile-time warnings and undefined behavior
for no good reason.

       Arnd

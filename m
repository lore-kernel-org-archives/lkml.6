Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4655C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C1D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoNL7Z8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C1D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbeFKSyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:54:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37028 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeFKSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:54:19 -0400
Received: by mail-it0-f68.google.com with SMTP id l6-v6so12277298iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZIXL1Sl0NaLpigQ2y1OrkZbfRyYFeYGW1Qwkl16w/g=;
        b=AoNL7Z8qCdJr/CF6PvrgxRHEqsVBJo+wcY9jxrpn9tuNBkbM+JCXUtw92arhE7rRUW
         D70mtrtUU07zY0MoEx3lA1q/LbggOIYB6rrmqTe67IFqd+BWP86z+uMY6o0TB3ILN3P7
         /jJTsXbGOuWY5yWNdsSigzlZuUrTHaggP4H/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZIXL1Sl0NaLpigQ2y1OrkZbfRyYFeYGW1Qwkl16w/g=;
        b=KEiKptVerB3shuWfLdHNRmyp8WLmTF4aEIUHBwNOX92te6gJUUbKO5QrQU0yWVqg8T
         aYKTAOA6Iazfsq9m868w1Q312kIElYYgzUFNIaHVcbWnlx+XqLhVZk/m3Hr2vv+Mg6Iu
         D8uE+PGzm/4pdtMGMQzO07YY1xTJZe+kTW4Hz0rT5xBalOKILh6dRg4krqW0SMLdM3fE
         3EU6wSEZb1rxbNq6+g9LHoPfxmK7GIvs3SZkrZbjfZoSEMLXiQO8grXxqtlVMjuFErV6
         X/7AILxInwd9oJfbiAmPB0vk9Dw54643Yxc7iGpWKzHH4d0ey1BAS7UwBPqIpd2vrfgp
         m/8g==
X-Gm-Message-State: APt69E1HEaQpSniRtcFLyQNiu7rm3kf8mKYAy9R+gHHORBZd/EajDKS4
        jE3s/0sHMPCOI927DBbWS/gPX8aazZr5fr8UIRM=
X-Google-Smtp-Source: ADUXVKKe2mTIX/GtWywFsfZMzKcFWTd/RywSA61BuaIMj3f35mEsJuKrMYddi6CXc/BPGDqXC1QyTD2O5o6bLbiX6QY=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr216765itd.16.1528743258445;
 Mon, 11 Jun 2018 11:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com> <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 11:54:07 -0700
Message-ID: <CA+55aFwEMVwijU=A7igcckkmS798m91=aEDwRpGGn7gw80ZdDA@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
To:     Matthew Wilcox <mawilcox@microsoft.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 11:21 AM Matthew Wilcox <mawilcox@microsoft.com> wrote:
>
> Argh, you used my Outlook email address, so you get top-posting

Hey, I think it's what you uise for your commit messages, I think
that's where I got it from..

> The radix tree does rely on constructors still.  One of the things on my todo list is to verify whether it actually makes sense to do that or not.

Ok, thanks.

> I don't really understand why Jaegeuk is changing f2fs now when we've just fixed the core kernel to make what he's doing perfectly legal.

I'm assuming it was based on the state when it wasn't legal yet.

             Linus

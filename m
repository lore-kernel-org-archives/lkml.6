Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F691C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CA22082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cNhARO8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CA22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJ3Cac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:30:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34978 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJ3Cac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:30:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4460866ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dbcj5wTsjO4bqYfWeSO4SAW9QD6RMUfaqt7cCbkMYNc=;
        b=cNhARO8Tbm/ZZpKglVbG/tmJbCWid6FqG5wkIv8IMOoOcuBXT9stprooY78HUJ0mEp
         q4+iC3uzrX3QTBlVoXAIUj6o9nDTk/InfUWg/bSPV73LMrfdXCGpS6IcLir8lRWBTyQG
         4twpi6f/3ovtfTUbSBr0YGPZ0wwvHw+P9bxec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dbcj5wTsjO4bqYfWeSO4SAW9QD6RMUfaqt7cCbkMYNc=;
        b=Wh0gWftbVLsPzv12+j7oYIJxfVmsn5x6m7ok+RzyV403n9s02SBCGFoXMKYZ4oYhya
         G3cx/hvEFN/crJXmDgxP7a5nZLtykVGUekOi2t0Lw+s5axxDQQ6UvaISkj+d6BGNa4+J
         gIu2fFVnhz9674SWFVyByx6YBboUiOQhHiGoo5i8VC21P9c0q10wSuTvzslZReD++v6b
         Sg8b2RBoT0qzhEW4s6siLS98H+lLzTQInktF/wnX/o5hGHC29Y2PRMG+PEzxsFUFf9Zo
         gDeSSmENRjIRxI0Xy3D59JrYx4AppwWg33P+K5HlTcd4ssyfqKxfLhpjJQE8ZaOnxlSi
         Ka1g==
X-Gm-Message-State: AGRZ1gKVM3MhmdCDU8Vhv+ifGv0Op6nE6oQflfMtIc3ADjbgV8dN4SeF
        Hj1h0JDUWr44FsdJIIzET8ybSE4wMiDN6A==
X-Google-Smtp-Source: AJdET5dH0Rn9ENXXPlg2IJfyNvXCfi8V/+VgQAp2Jcfa9oNNGzSpay3UTsu/hMRYRcZgqk1Q+xxUDg==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr11034420ljc.61.1540834854739;
        Mon, 29 Oct 2018 10:40:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t144sm445693lff.53.2018.10.29.10.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:40:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id g8-v6so5774678ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:40:53 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr9718669ljh.59.1540834853148;
 Mon, 29 Oct 2018 10:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181029144358.GA2018@kroah.com>
In-Reply-To: <20181029144358.GA2018@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 10:40:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikVF3TdzQT97HN9-pVtuaEHj2q8htSOEXfwkZOQg-ZHg@mail.gmail.com>
Message-ID: <CAHk-=wikVF3TdzQT97HN9-pVtuaEHj2q8htSOEXfwkZOQg-ZHg@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, sfr@canb.auug.org.au,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big staging and IIO driver pull request for 4.20-rc1.

Pulled,

                Linus

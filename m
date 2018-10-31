Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7537C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1CF20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K8pqyiQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1CF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbeKAD2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:28:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41881 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbeKAD2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:28:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so9708519ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fkeO5T89B0RMpAd4GhViYYvlwIvUzTPNTQcqM2cLw5A=;
        b=K8pqyiQ3GUQ/uY7qEHE2hQhzLx/LzytawBr6naQGvzA39Yhzpi4nf6WFmbwxl9sInR
         3tvnK9sYP/oGOv6FVcZRyP5hWvnTQLQQwsOoBMfylU/70UKMQIxA1uu0d8hvxejK29zn
         XQ+jMjGemGd95T03rpQABL5ONspY7nrPg1v6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fkeO5T89B0RMpAd4GhViYYvlwIvUzTPNTQcqM2cLw5A=;
        b=KwpSWoRx2AThZcYLjejoXPxPeznjZYb19RacSc3GzRCSxKxVz7RG5yZv/8SLvVB0N/
         7STerwoHk9UuTl5HhixCXexoEUw2Wx0Iw9f2VQVTapZ8+l8ySNNwjktuIMgWgpBWKtsJ
         5LVw6N+e3jyDB6BpfllXNr5uAd3c3e9f73OxqVkIabRMe6EbyMu5+h+kRgyW0H7e1KRO
         Vrj7fx93W1flxNCw04nq2s0NEiILHqAwMz7hHJ1exECN8dTg6vhwgCV5Wa3k9GP/Z3M6
         k7StlZdbGKAbWKzjTtgqbMtpOEZJ2bceIbAI/KGWQL8k84OrDaBcudeMy04dwG0+WKsU
         gkow==
X-Gm-Message-State: AGRZ1gJntIlOIsj3l46jNky+boQYkb6JHGANm5ABS/P+qKeidRYXMRDY
        4zIOOC9w27uw4U+2vjRc9Nf26xmF6fBK/g==
X-Google-Smtp-Source: AJdET5fmje6MsUeHB/s0Oq8tezAsZ9qiJUgCfw6WtuYRn5lWGBgCTqeQjUGXU7KxtJhvqUleLDMHuQ==
X-Received: by 2002:a2e:5c86:: with SMTP id q128-v6mr2963209ljb.119.1541010575789;
        Wed, 31 Oct 2018 11:29:35 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l67-v6sm4571985lfg.45.2018.10.31.11.29.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:29:35 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s15-v6so15776686lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:29:34 -0700 (PDT)
X-Received: by 2002:a2e:9f42:: with SMTP id v2-v6mr2988003ljk.80.1541010574267;
 Wed, 31 Oct 2018 11:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <1540949083.2254.62.camel@intel.com>
In-Reply-To: <1540949083.2254.62.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:29:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKa=WKrA_MCO1=6ccKZ+1tvauXJAesPbrOu17KgzNMvg@mail.gmail.com>
Message-ID: <CAHk-=wjKa=WKrA_MCO1=6ccKZ+1tvauXJAesPbrOu17KgzNMvg@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.20-rc1
To:     rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:24 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Thermal management updates for v4.20-rc1 [..]

Pulled,

                        Linus

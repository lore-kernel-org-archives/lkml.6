Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8EEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F720657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MMJUVTRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeKCBo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:44:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35400 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCBo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:44:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so2308208ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWcEFiyjbClMNHKABKV8f+u1WzFBO0mC6izv7Mf8kcY=;
        b=MMJUVTRsNhyUhJQHeDIo1xDmV2GVOY5FIz1B8vnebJ4CTVHc82WtFguIYXE3CWFSz/
         2bO8UIxvLaz+bn5DOvjHRKwz+NY+Z5vC+ywUvS5bLUo6Un+xuuKejMwMf2zBJxp00LM5
         1sFgsRUe74sBMF1Va3dg7XQYFR/Ne9EELj/E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWcEFiyjbClMNHKABKV8f+u1WzFBO0mC6izv7Mf8kcY=;
        b=HY+X88iKzzEhXgAWBtg/0DU48eapuWUOIepD7c87Ec9Gl5UfOSzGM5oKMR+9bV9hD0
         /S8+dIDRcJz8FCwlx666poGCr62dfLpC7f760A42SxOHI6M9I0qOLOEjKnplGzSdmPQF
         72KIBxW75cxrMGMDA3V6AOPjHyI9iG9MvZIJvlntd6wmqhOYvLhk89FxOtVsqH2o7x27
         TLJYNJyoJ5Fkzp3MOuYCFwWh9+a5o9d2fl2scCaT5gTPzhXzRJHbaP0xqlK4RAMOopOI
         pH7YYSbxUxUJuxGvyku2cjzFTMJdaZF3QnLtsfpKd+P4bcC8N8mIWh2v/HjT4KsT0mMg
         X8nQ==
X-Gm-Message-State: AGRZ1gLuFgZ6ULKYLHQG4wgetY01Y0GFwQUwZLKEomPU74/3V8605PQy
        FL2K2/txjNeTMYnk0WzSIgzEBU2dqfym8A==
X-Google-Smtp-Source: AJdET5cozWdwOVJ6EuLT5pnxvFxmPHJgY6XJMblD243rrg5Lv9Ti3dszQGeqaHKKWrUehVeZVsrnGw==
X-Received: by 2002:a2e:9d86:: with SMTP id c6-v6mr8014075ljj.146.1541176631596;
        Fri, 02 Nov 2018 09:37:11 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id s126-v6sm3275631lja.4.2018.11.02.09.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 09:37:10 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n3-v6so1743567lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:37:10 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr7067237lfa.106.1541176630088;
 Fri, 02 Nov 2018 09:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-cb2ea62c-8d08-467b-bea5-657b42a5acbf@palmer-si-x1c4>
In-Reply-To: <mhng-cb2ea62c-8d08-467b-bea5-657b42a5acbf@palmer-si-x1c4>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 09:36:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+Ky330NCjhqTfv=6daYvSXbRvFr1JcpSpSoHBCiKqYA@mail.gmail.com>
Message-ID: <CAHk-=wi+Ky330NCjhqTfv=6daYvSXbRvFr1JcpSpSoHBCiKqYA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 4.20 Merge Window, Part 3
To:     palmer@sifive.com
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 7:19 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
>   RISC-V: refresh defconfig

Pulled,

                  Linus

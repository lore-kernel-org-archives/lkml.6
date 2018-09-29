Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D152073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cTzHYrZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D152073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI2JTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:19:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39097 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeI2JTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:19:22 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1abd742c
        for <linux-kernel@vger.kernel.org>;
        Sat, 29 Sep 2018 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=oXj/BuY3vm6St0XzGOjzQI9Xf2k=; b=cTzHYr
        ZdzmLHHvqN5YPsQ5wmhWQFHPQzW4A6ifAWAT/xTCDygjb5qMEdoZgaAb00/uQhee
        tBq8n6MvYvbXiKtuIuhtAXdZ5/7lICTa3XdSGAafMkVhmddHl9IfnPyA8z1wmpSI
        5Meyt//GHkexgpF3cbec9dwJ6H5viaLMQoiOlSKpm/PQVEXySWts+BJ+DkEMZCPW
        BfiXYRr2e2WZ9XOqSxmoVmDA8jlUQidKpdLNphEaGeo5IgGYv9WSzjwNH5IY+f+Q
        /e+qTPPztYAmeXA8uVXcWc5EdJi+VaQJ/i+9EU8Zt7beTuy8qfOp+kpfTf2M6zJs
        FV2tf0yW0F7Mfu0w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6b2cfcae (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 29 Sep 2018 02:33:51 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id s69-v6so7021363oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 19:52:42 -0700 (PDT)
X-Gm-Message-State: ABuFfogCk8sJVOTMHjKOzKhOWb9gcMoKlXVDyvGhJkcsR3j0i5FvbhqG
        dSfDRkJFCR9NDMYQB93F7cvD+QikiNWU3CLpOFc=
X-Google-Smtp-Source: ACcGV60q45CTXRjPoZCNqsUmlzgQgqQKnamc0dw2C3SvG1elWQqj1vHJ7nG4pxXUiF8DFt2svr5SdS3AbQfLg8niWgI=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr607378oig.225.1538189562177;
 Fri, 28 Sep 2018 19:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180926135110.13061-1-Jason@zx2c4.com> <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
 <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com> <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
In-Reply-To: <CAK8P3a3riqD9kzGZHLxhYug7zO34e2icOaWddzH2JezbZKVNPg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 29 Sep 2018 04:52:30 +0200
X-Gmail-Original-Message-ID: <CAHmME9rGgnNTd84-ywcNZfRx0a3dnqUaCMoSkKHYSUPN1jZiew@mail.gmail.com>
Message-ID: <CAHmME9rGgnNTd84-ywcNZfRx0a3dnqUaCMoSkKHYSUPN1jZiew@mail.gmail.com>
Subject: Re: [PATCH] arm: support big-endian for the virt architecture
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,

On Fri, Sep 28, 2018 at 9:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> You can probably work around it by enabling ARCH_HIGHBANK,
> which is a minimal platform with no other requirements, so it
> should only add a few milliseconds to the build.

Nice hack, thanks for the suggestion. Committed here:
https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/WireGuard.git/commit/?id=56ff2eb9480e6c691a5b8d8ff1fa01090df61e1d

> Another option would be to do the testing on top of linux-next,
> which should have your fix starting on Monday. Testing on
> linux-next carries a higher risk of running into unrelated
> regressions, but also lets you find out about conflicts with
> other patches early on.

I do actually test on linux-next (and tons of other kernels too), but
I like to have things working for at least the latest mainline.

Jason

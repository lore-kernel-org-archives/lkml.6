Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51900C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED08B2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED08B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIHWQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 18:16:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40192 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 18:16:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id c126-v6so11686547qkd.7;
        Sat, 08 Sep 2018 10:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTT1OHfGPReUeTxGJCWtlUMajLL+fOKcpIN3X2LMAAg=;
        b=VK7hm7KdXwFZvMP1VdbHHVRHtU+wK7YDmnHcZ/cIV9peZjQeYIEss70fcJPLF/xGEt
         7p0MGYQV4KY18R36ylOnLB2+J7+UTakxiN96udFq+dswh8a89MaK6GcEbYW9+0fwQMGT
         puk+3Zx+kd6W+bAHvF+GENpE/Cta87kwseLfV+lejEHAa0mAlefj8IvunE6bSmQLiFST
         rfSckUd8uGyIZ4IBoU/ZuaKNVLbbLdfOQeRwm0AW8bKcL0kw1zKEhIaZAu4vPtp3Jz8U
         yIdX07dp9fCca3uE5k0F8VfR8m38OUgQiuh0iIL6qsI89F+f/C1AbggPRYQD29OERhw/
         KrFw==
X-Gm-Message-State: APzg51BDeZCDT5yltM6AIVOIiPxU0ixO5KPbaPLLmkOZ3s3Ng/KD9cP6
        NOOGZPtdN7wGFUZBUOwbsupsMQfxQCyveKkbUk8=
X-Google-Smtp-Source: ANB0VdaONqOXq/KSXtnTYk7t911DofvBYABH2rYaHDVkzyPSNhmx2vK4J6aCFtPhMjapbkfZF6g/8HOxyLEeohvNAu8=
X-Received: by 2002:a37:2941:: with SMTP id p62-v6mr9671319qkh.330.1536427807220;
 Sat, 08 Sep 2018 10:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180828142724.4067857-1-arnd@arndb.de> <20180828142724.4067857-2-arnd@arndb.de>
 <20180908081710.GA2598@piout.net>
In-Reply-To: <20180908081710.GA2598@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 8 Sep 2018 19:29:50 +0200
Message-ID: <CAK8P3a3V64f1QTOJ0qk3gOnMk=VkHPQBJZmhVsOUNDPGVrmUOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: move compat_ioctl handling into rtc-dev.c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 10:17 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 28/08/2018 16:26:31+0200, Arnd Bergmann wrote:
> > We no longer need the rtc compat handling to be in common code, now that
> > all drivers are either moved to the rtc-class framework, or (rarely)
> > exist in drivers/char for architectures without compat mode (m68k,
> > alpha and ia64, respectively).
> This doesn't apply on v4.19-rc1, can you rebase?

I must have based it  on top of another compat_ioctl.c change that I sent.

Independently, I also sent a longer series of changes to Al now, which also
need to be rebased. I'd suggest that you just keep the Kconfig change for
MIPS then (or offload that to its arch maintainers), and I'll add the RTC patch
to the series for Al instead.

        Arnd

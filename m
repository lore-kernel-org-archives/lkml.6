Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A30C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEA92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJwLfHws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEA92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeJ2MaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 08:30:01 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45234 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeJ2MaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 08:30:01 -0400
Received: by mail-qt1-f169.google.com with SMTP id l9-v6so7679747qtj.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 20:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mgQKg5cpqf/fe95yBECr7IuD+GRxZjLjv0KQk4WR33c=;
        b=jJwLfHwsxX12LlCz7xNgooeXXqEX4f8QQMK/abnKniLrTN+bpcAcAkcvhVYSyAaxpb
         mTcr36CMwwXiECn268ewbuTU0NVv+KWzsHXVvdKqmbULe8u7lNM/fWQ7tmVujcPsqTk7
         HSsWZFvYK88AitYo0vKYTiEM3Zgjd/zTXsrT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mgQKg5cpqf/fe95yBECr7IuD+GRxZjLjv0KQk4WR33c=;
        b=MGG6ASiKrXjysV2Wgm/TcO7YSNZJDBAgMP640kUMCpO4eOUOW92iTFn2NfccelUoHe
         sDfa/ZuxiwrcRl4j0ED2l+R9aqwPt9Hrnrjtqe560XywqEQFY+37mOhT4PosjsPri1Yi
         GUEwjs0j2OQgjdA9mVwaHvsgdMilv3xX2DF9/Epg5rJtophNclfaCItH2klAdwZ5GP5y
         myJYBWbpz+mLWqDByPPaIZWAeGtEHWjIzoMogzHnJvu9StCtdEMPjE4PxEEeDb9YyFKG
         HrxbD7JH0WlUGx9BRTWxeFs9sgFAogDt3SaZV2UEYKN320M5jXWjooagqTg2xX6Yrngp
         XhXQ==
X-Gm-Message-State: AGRZ1gILZQuCEGpq+Rxe8FYykrvq1Feibcs0MDRqUfZ6258+5s9O7eDD
        7ZebNMb+hFdZYB8OhG7d45j916NzC/c=
X-Google-Smtp-Source: AJdET5ceh1cVT1ezbvHTpUi5frUkzQpphM19EX7hdvg1Ig8m+ETjYe3GY6QcaPW3Lht1Dh2NG3NgKg==
X-Received: by 2002:a0c:884d:: with SMTP id 13mr11691203qvm.170.1540784589553;
        Sun, 28 Oct 2018 20:43:09 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id p31sm2879309qkh.86.2018.10.28.20.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:43:08 -0700 (PDT)
Date:   Sun, 28 Oct 2018 23:43:07 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: Cramfs: "unable to handle kernel paging request" when reading
 a file from a fuzzed FS image
In-Reply-To: <CAE5jQCdhWVVqf8en9S-3mbDBwuxk481S+hi-uvQSw6Gf6jKujQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810282336440.1498@knanqh.ubzr>
References: <CAE5jQCdhWVVqf8en9S-3mbDBwuxk481S+hi-uvQSw6Gf6jKujQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Oct 2018, Anatoly Trosinenko wrote:

> Hello,
> 
> When reading a file from a fuzzed cramfs image, unhandled kernel
> paging request occurs.

Hmmm... It doesn't show up on my test system.

> How to reproduce with kvm-xfstests:
> 1) Checkout the v4.19 tag, copy x86_64-config-4.14 to .config, perform
> `make olddefconfig`
> 2) Enable Cramfs in the config, then compile
> 3) In the `kvm-xfstests shell` perform:
> 
> root@kvm-xfstests:~# mount /vtmp
> root@kvm-xfstests:~# mount /vtmp/cramfs.img /mnt

How do I populate /vtmp? Mine is empty at this point. I imagine I should 
put the cramfs image somewhere on the host, but I'm not that familiar 
withkvm.


Nicolas

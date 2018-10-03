Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69164C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE82098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BE82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJCWnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:43:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36072 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:43:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so543821plt.3;
        Wed, 03 Oct 2018 08:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTy9mH10pGGBZxkkteDIvQMExuu/zavR1jJVhkIG9Ak=;
        b=emW8Uf8v/qRBoOax8+crNyDk4VDzoO6uVrkvjzIFm0ttrS/4eYbSaVUGmFTM+pxjhq
         Q9I4wbjvlvl6Hnp0+Oh9aSXd/8QcOd3DyNtr7g6cXBPhYo/gzaSlYbnZRVnbcmw0jy2l
         1Ljrch6bCV4g1xCkuqXPOgdn42LcJLEsT7ahtDwkd9o6ERX38zPYe00HBd46ocQB6U9K
         ov6t2m6vuFNvhHDkalOtatsLHwYGRFBsWcVkg8iwpFk6H0CbeYNIK8bMs3+U0IK3Ihjx
         PxXInHalQW2lTf6vhwYzaGWvecw1GE1aJyyA99Qewnq6/rOQuJ2Ekqdk2t6aJ354n1K1
         fheQ==
X-Gm-Message-State: ABuFfoic826KkHlFMCxXAKJqFsqBt9HFDBB5BlgeBLMkchP8iNOsAIBr
        +MMwCVzoPKNz6VBZ66R4ZBQ=
X-Google-Smtp-Source: ACcGV62Ue1Hc4oRKlU/90ONTZc+/T3P39i2c7G+QpZH9E277Vw+ei2VVyfmE+pp6P13l87Uc/hwtcQ==
X-Received: by 2002:a17:902:101:: with SMTP id 1-v6mr2287930plb.15.1538582093356;
        Wed, 03 Oct 2018 08:54:53 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m15-v6sm7198918pfk.149.2018.10.03.08.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:54:52 -0700 (PDT)
Message-ID: <1538582091.205649.20.camel@acm.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>, Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 03 Oct 2018 08:54:51 -0700
In-Reply-To: <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
         <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
         <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 08:29 +-0200, Paolo Valente wrote:
+AD4 +AFs-1+AF0 https://lkml.org/lkml/2017/2/21/791
+AD4 +AFs-2+AF0 http://algo.ing.unimo.it/people/paolo/disk+AF8-sched/results.php
+AD4 +AFs-3+AF0 https://lwn.net/Articles/763603/

From +AFs-2+AF0: +ACI-BFQ loses about 18+ACU with only random readers, because the number
of IOPS becomes so high that the execution time and parallel efficiency of
the schedulers becomes relevant.+ACI Since the number of I/O patterns for which
results are available on +AFs-2+AF0 is limited and since the number of devices for
which test results are available on +AFs-2+AF0 is limited (e.g. RAID is missing),
there might be other cases in which configuring BFQ as the default would
introduce a regression.

I agree with Jens that it's best to leave it to the Linux distributors to
select a default I/O scheduler.

Bart.

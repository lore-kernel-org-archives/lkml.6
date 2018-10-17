Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CAAECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457752150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457752150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJQVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:34:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42651 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:34:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id c23so24395698otl.9;
        Wed, 17 Oct 2018 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5EUDX803PiowWWGJP/xW4a3xMrgwy9l/YNKviS+1pc=;
        b=t/mHToNfUgc+Mb52STYO4A0DqMGXTuvB6xECxxdytlDKbu/F2rm+fC7kxk6pehcgue
         DrBbInPfiWsl0kN2oaIF9BKTbp5VRQKTLPw+HnBvaReWoEhcRQ3i9VIp0wFE2KHrDAGr
         GpHly4KNJZERuH5MeQF64jYq/dMWxmlBfJDBoAmt4r1gy/uu4zYPUbsG+90NqnW1rea1
         SGc2s6ss7cJ/UGjYd84YZYf6OtuMlqKgbUqjHv2SR/+AJkXNSuubSJQMxXL9VDvEh0MQ
         nPQ2gdBvkIOCbr75kpeeHdCF7PV1vUtd2OG3nqBg5tCxQOVmcJrWLgcXipNLGMpGaW5C
         N3Zg==
X-Gm-Message-State: ABuFfohu/hxArCBPoDhvfyUnM16RcHHqBVJNq6h7TtxaQH9a3vm+mMof
        j5c8XCeDi5mIvPJTSNBnJhisO1ob89JbPPp+kDFZAX4VUCg=
X-Google-Smtp-Source: ACcGV60v7nSAKQSm8G+Heu6Ct0EUZbvudTFD5A3Z3EcQkC4tS1GOlmez/Obvr/CeaZKqPGKdaYWwd7Rn1r1v1nd8Cfw=
X-Received: by 2002:a9d:488e:: with SMTP id d14mr17599624otf.354.1539783499285;
 Wed, 17 Oct 2018 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
In-Reply-To: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 15:38:07 +0200
Message-ID: <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
To:     aaro.koskinen@iki.fi
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 14, 2018 at 7:04 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> There is something wrong with jz4740-mmc in current mainline kernel
> (tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
> prior those), as the DMA support does not work properly if I disable
> kernel pre-emption. The console gets flooded with:
>
> [   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
> [   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
> [   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
> [   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
> [   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
> [   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
> [   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
> [   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
> [   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
> [   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583
>
> etc. ad inf.
>
> This should be easily reproducible on CI20 board with ci20_defconfig
> and setting CONFIG_PREEMPT_NONE=y.

Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
could you confirm that the original mmc driver (kernel from imgtech
people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
?

Thanks

> A.

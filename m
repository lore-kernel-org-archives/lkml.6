Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FAAC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6132077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6132077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJOAqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 20:46:14 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:38538 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeJOAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 20:46:14 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-84-102-nat.elisa-mobile.fi [85.76.84.102])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id F0F3C3005B;
        Sun, 14 Oct 2018 20:04:31 +0300 (EEST)
Date:   Sun, 14 Oct 2018 20:04:31 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Message-ID: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is something wrong with jz4740-mmc in current mainline kernel
(tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
prior those), as the DMA support does not work properly if I disable
kernel pre-emption. The console gets flooded with:

[   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
[   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
[   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
[   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
[   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
[   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
[   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
[   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
[   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
[   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583

etc. ad inf.

This should be easily reproducible on CI20 board with ci20_defconfig
and setting CONFIG_PREEMPT_NONE=y.

A.

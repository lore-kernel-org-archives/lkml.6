Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C33C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F320873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OqL51XAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfANPfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:35:55 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10910 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfANPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:35:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3cac470000>; Mon, 14 Jan 2019 07:35:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Jan 2019 07:35:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Jan 2019 07:35:54 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 15:35:53 +0000
To:     <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Regression: spi: core: avoid waking pump thread from spi_sync instead
 run teardown delayed
CC:     linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Message-ID: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
Date:   Mon, 14 Jan 2019 15:35:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547480135; bh=V3BZptE2eXsvYNh7dbm7c4PLJtlWFBKT2zBV3E0QVkQ=;
        h=X-PGP-Universal:To:From:Subject:CC:Message-ID:Date:User-Agent:
         MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=OqL51XACXWtrjgz5x2mPlR1ixMzWJpVrNJGDKa3afAnD93V1f+AFO2wXsUCW3TO7A
         YhFzYLAT/KbeSQp2IKY+S6BHjMVgm+yGZiQLUPPio65fb2gWnRYvn6haSkOtflYykU
         bF3g2YQkV7ijMDg9xJGv29lDNPGEtZjVRLbfXMKqfACsJPk655qq03f4kykOkvAwoG
         EuFTljTZWLwfNOAWDHoeL9zJzqDJ1951JPSPzbJVjxx3A/tx0DFNKdYWDnll215x5Q
         TcrNX6fEnkdXvV+qjw5K90ChQxUOEFl9MXgyBQApbfaZZYBmBTvatJAWYIjzHqHHnz
         BuiGfZz00wHwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin, Mark,

I have noticed that system suspend has started failing consistently on a
couple Tegra boards over the last few days with the linux-next branch.
The following error is seen on on entering suspend ...

[   58.222033] spi_master spi1: could not stop message queue
[   58.222038] spi_master spi1: queue stop failed
[   58.222048] dpm_run_callback(): platform_pm_suspend+0x0/0x54 returns -16
[   58.222052] PM: Device 7000da00.spi failed to suspend: error -16
[   58.222057] PM: Some devices failed to suspend, or early wake event detected

Bisecting today's -next points to commit 412e60373245 ("spi: core: avoid
waking pump thread from spi_sync instead run teardown delayed") and
reverting this on top of -next fixes the problem. I have not had chance
to dig any further but wanted to report this issue to see if you have
any thoughts.

Cheers
Jon

-- 
nvpublic

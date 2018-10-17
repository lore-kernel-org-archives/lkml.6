Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81331ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBEE214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FexpywWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBEE214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJQQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:42:03 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17263 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeJQQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:42:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6f71f0000>; Wed, 17 Oct 2018 01:47:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 01:47:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 01:47:23 -0700
Received: from [10.26.11.110] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 08:47:19 +0000
Subject: Re: [PATCH v1 2/5] cpufreq: tegra20: Support OPP, thermal cooling and
 Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <50a5b783-d865-c1a6-bfa3-7b38a5ad2a01@nvidia.com>
Date:   Wed, 17 Oct 2018 09:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830194356.14059-3-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539766047; bh=FXHn4qfDSKT5NNa/E9nA4jzlo8U46jKrizbelBrJX5k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FexpywWqRvxDfD7cnDgDjLML0rYcZ641KSx2kIUuJpWXHddECAv2Ko4OtiXhTM9xW
         0oG02BWjXohwkNyWeXuKpZifzSRf07v9uJM76Lpk6odEhmoNWkwvCvNZL8En0oxNwb
         +Nm8rCtoe1rjZgP9w3fgoRm+ycC3NxnuNpEx7j+fQm5wro7RgwRCLbK9xHtWR7n/Bf
         UlAMa/tv1/lKMhrlBO8nPdbLl1bf9ctmP4VpDdqWVD0cYKIqL2DUh2S20h15UEmDzM
         +lSAWXagBTDST0nPmk7rxwoPBAYWIcjmoQzh7lMiDecLXDdRGCxPs1n2fbR1epyv97
         nJVl7Z8yNtsfg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 20:43, Dmitry Osipenko wrote:
> Add support for thermal throttling and Operating Performance Points.
> Driver now relies on OPP's supplied via device tree and therefore will
> work only on devices that use the updated device tree. The generalization
> of the driver allows to transparently support Tegra30.

Thierry, can we or should we do this?

Cheers
Jon

-- 
nvpublic

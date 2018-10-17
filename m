Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6AE21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eVB5q6+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6AE21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJQQsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:48:12 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13383 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeJQQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:48:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc6f8870000>; Wed, 17 Oct 2018 01:53:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 01:53:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 01:53:30 -0700
Received: from [10.26.11.110] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 08:53:27 +0000
Subject: Re: [PATCH v1 1/3] clk: tegra: Convert CCLKG mux to mux + clock
 divider on Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180830192045.11017-1-digetx@gmail.com>
 <20180830192045.11017-2-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <19523f37-eb78-067c-cc62-b6ceaad985a9@nvidia.com>
Date:   Wed, 17 Oct 2018 09:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830192045.11017-2-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539766407; bh=GLxpohoKikSwiBvr5jEru4Kmt0mfPUecBJPkdk8b1zc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eVB5q6+2/xuoYz9d4nhzRxTpzoL0Fuo+aCYjewYMDpi+5qYZ6gokS6jyXOwcxH+LH
         gwJ+4kqRudpAlSWt7SyE3BU5A/C2m29wm+cxr56LtSrvB2tDqksNqnZNQtqf1GfGh3
         7UmWI+ZSt64DiwzobyB+XgBPXwMPlqFS9AQNU/viW4QJdixo0y9YJrGD0m4mdbCOEN
         UH2r/xl7wR4RlAIUkQV9oe3hYT8jZWq2eXBTm/zU8akE6V/j+tpVD7l6qpJsYb0SZQ
         tfUtLCJxyGL9jAK2CLmVG/M5JXGN74RtdgLWqQmRxJFeXLcwgqFptgM8v58k+TpPyb
         ogzXcTQbQ4Zwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 20:20, Dmitry Osipenko wrote:
> Some of the CCLKG parents aren't accessible via device tree because they
> are created as non-DT clocks. Apparently there is no reason to define
> these clocks in that manner, hence convert CCLKG mux to mux + clock
> divider to remove the non-DT parent clocks. Now it is possible to request
> all of CCLKG parents from device tree, which is necessary for the CPUFreq
> driver.

Is it likely that all of these clock parents will be used by the CPUFreq
driver for these devices? If the clocks you currently need are available
then my preference would be to stick with what we have for now.

Cheers
Jon

-- 
nvpublic

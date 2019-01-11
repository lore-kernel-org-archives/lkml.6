Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165E62146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dO3ZMiz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbfAKNfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:35:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8082 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfAKNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:35:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c389b7a0000>; Fri, 11 Jan 2019 05:34:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Jan 2019 05:35:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Jan 2019 05:35:08 -0800
Received: from [10.19.244.53] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 13:35:06 +0000
Subject: Re: [PATCH 2/2] regulator: max77620: disable notifier events for FPS
 rails
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
References: <20190110041117.8216-1-markz@nvidia.com>
 <20190110041117.8216-2-markz@nvidia.com>
 <20190110120707.GD9541@sirena.org.uk>
From:   Mark Zhang <markz@nvidia.com>
Message-ID: <161783bb-2589-c1ae-7efd-1b95f8b8b887@nvidia.com>
Date:   Fri, 11 Jan 2019 21:35:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190110120707.GD9541@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547213690; bh=vkHonU+1PwP28R62u2Ags4sacfKusIyeUNY2aupzFlc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dO3ZMiz9EpPwpew+05CL6N8oQ2nS0d+CbxROU5Bhql84Et/3QsnPj4WtG/Q9B526e
         QLLz8gKGRBlpkqRp9Xw/UghJHxejqBoZ4IYi6dWzjgV03op3SiKcPTvavqU+uZW8cw
         ShLtakuw1/7fauII/801A8T4t6pvC6liPZSNuJ+Fea7zRrxXKGOsjzVzXULToSovw3
         7CCwL0rSBgRnAYELo/NvZRC+7+l7u7gT/7VZInFZdHKSmUhtnUz9u2W1FwQqNVj8xd
         iXSWqPM58QlWoisMbNMwjOq3N1w1yRJHiTNaK3iy24YaBgxCqAuKM4WiHEYjburCTh
         L0Jf4Z7JDWInw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/2019 8:07 PM, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 12:11:17PM +0800, Mark Zhang wrote:
> 
>> +		/* there is no SW control for rails which are part of FPS
>> +		 * set always no contraint to true to avoid regulator
>> +		 * enable/disable notification
>> +		 */
>> +		if (pmic->reg_pdata[id].active_fps_src != MAX77620_FPS_SRC_NONE)
>> +			rdev->constraints->always_on = true;
> 
> A driver should never modify the constraints, you should register a
> different set of operations without an enable operation instead and let
> the framework handle this.

Oh right, today I checked the codes based on your suggestion so I think we don't need this patch now. We can find another way to fix our issue without touching the framework constraints. Thanks.

Mark

> 

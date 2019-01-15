Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14761C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE32520645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PEn/CnfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfAOQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:09:19 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7091 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfAOQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:09:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3e05990000>; Tue, 15 Jan 2019 08:08:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 08:09:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 15 Jan 2019 08:09:17 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 16:09:16 +0000
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
To:     Mark Brown <broonie@kernel.org>
CC:     Martin Sperl <kernel@martin.sperl.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <20190115151009.GC5522@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
Date:   Tue, 15 Jan 2019 16:09:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115151009.GC5522@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547568537; bh=mP/HvQkX74Z2elzZYLUn8AWa6PlcEajW0R1UfiPCOQE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PEn/CnfHPWSz40gYFW8ntg49mhs/14xzuurP9VeECkLWb0vLcVn5uD1Y6oQkAY7sZ
         WfeM73Gv9F3cr+Ssx+RiYSoWxWY5rBx2aZgRoImSAUBwvS7KDGo0jvev96PEad3mMi
         IwHdaymajGN5DCg/KjDIjYChZMLEzqBNXLpJMJdr+PBin1YkCfXWuPL/NtMCodLRBa
         Yw6JYnf9ImaGSNIB+bchEadjvoYyL6JL53zdkwsXB9a89Z4lHi8udgeDbmZ7LpnJAy
         282blYh1DWcewz7hc1qyCirUCPhhr0WDLdK1AO7dXy4/IrCldi4EmJX3XB1uSO4meH
         rCfCeFb6S8h0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/01/2019 15:10, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 02:26:02PM +0000, Jon Hunter wrote:
> 
>> It seems that __spi_pump_messages() is getting called several times
>> during boot when registering the spi-flash, then after the spi-flash has
>> been registered, about a 1 sec later spi_pump_idle_teardown() is called
>> (as expected), but exits because 'ctlr->running' is true. However,
>> spi_pump_idle_teardown() is never called again and when we suspend we
>> are stuck in the busy/running state. In this case should something be
>> scheduling spi_pump_idle_teardown() again? Although even if it does I
>> don't see where the busy flag would be cleared in this path?
> 
> Right, I think with the current code we just shouldn't be checking for
> busy in teardown, since there's now a fairly big delay between idle and
> actually turning the hardware off the name is just super misleading and
> the logic confused.  I don't have time to test right now but does
> something like the below which changes it to a flag for the hardware
> being powered up work:

I tried your change but the same problem still persists.

Cheers
Jon

-- 
nvpublic

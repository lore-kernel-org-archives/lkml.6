Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F571C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA57241A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JdOOkwqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA57241A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeGEGwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:52:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38070 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEGwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:52:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w656pvik106652;
        Thu, 5 Jul 2018 01:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530773517;
        bh=wCs0yB+nnJzWDwqtDLmP4urdC8Tqc13aRc3bSmmX0wo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JdOOkwqYFVxHlXpqCvwW+hyjWz4W2Zgtz8+eT2SBBwy7NUOLIlRu9ZMX93Hge7Y6Z
         9MuUR0kcPOo2P4pKjrlVO3tiaILQIy6DGHTSwVHTKxgNB2u4YbEB1t6+JBC4ql6vG2
         Tm9jLB1JHPQv5YiMLyc0kVMFUe8mNWxuk1mkYn3Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w656pvIm012979;
        Thu, 5 Jul 2018 01:51:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 5 Jul
 2018 01:51:57 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 5 Jul 2018 01:51:57 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w656prCi024783;
        Thu, 5 Jul 2018 01:51:54 -0500
Subject: Re: [PATCH v3 4/6] bus: ti-sysc: Add support for software reset
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>
References: <acdfef83-8778-e8f4-e423-ed04a9a8a649@ti.com>
 <20180611060957.GN5738@atomide.com>
 <f460481f-85a9-2a41-a894-6f25122dee8a@ti.com>
 <20180611062904.GO5738@atomide.com>
 <89d55b0b-fe9e-793b-2694-25755ac2bc15@ti.com>
 <20180611070332.GP5738@atomide.com> <20180703070743.GG112168@atomide.com>
 <ee54c3ea-6200-33dd-83da-491f5fdd9f5c@ti.com>
 <20180703073139.GN112168@atomide.com>
 <1138704c-b7a4-391f-3404-e1bd25a4a0ff@ti.com>
 <20180705055506.GI26255@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <dccc7de2-f3d8-9fb7-4b79-951e2a59e0ca@ti.com>
Date:   Thu, 5 Jul 2018 12:23:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180705055506.GI26255@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 05 July 2018 11:25 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180704 13:37]:
>> After taking a second look at this thread, I don't see anything big to
>> be modified.
>>
>> We both agree that "reset status bit in sysconfig register" is the quirk
>> case which can be added once such an IP is discovered in ti-sysc.
> 
> Yes agreed.
> 
>> All I need to change is SYSC_OMAP4_SOFTRESET to SYSC_SOFT_RESET_SHIFT_0
>> for better readability and rebase it to the latest mainline.
> 
> Let's not change SYSC_OMAP4_SOFTRESET as only the ti-sysc
> driver needs to know that and it can be set based on the
> compatible.

Ok.
> 
> How about replace ddata->cfg.quirks & SYSC_QUIRK_RESET_STATUS
> test with just ddata->cfg.syss_mask test in your sysc_reset()?
> 
> We still need to set SYSC_QUIRK_RESET_STATUS too for pdata
> callbacks.

Sure. Do reset in ti-sysc only if dt has the correct syss_mask.

Rebasing and posting v4 soon.

Thanks,
Faiz

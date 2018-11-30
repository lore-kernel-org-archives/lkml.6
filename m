Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4573C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945E214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pxfvn+tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8945E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeK3SqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:46:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3SqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:46:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAU7bm2t115115;
        Fri, 30 Nov 2018 01:37:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543563468;
        bh=rL40WZQZaIBOx7AAvOviqd+YUBUA1ygEfw+bK0niR/8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Pxfvn+tgihSaSpiGGM/OZI067IbwaAnAJRpJX/ctOQY5vrRTcbSZmW067lcOBFHXv
         O6Y08E8CDVo5c8xqIi1gdJo9NguA+GsrVk1W2AR4aWZqIQYEC8+MSQeqXv5HoVxETL
         Iv7MMn9sSugzUsdghx57yItTgel0aS/+ynAZYfZ4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAU7bmqS111796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 01:37:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 30
 Nov 2018 01:37:48 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 30 Nov 2018 01:37:48 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAU7bi2R021420;
        Fri, 30 Nov 2018 01:37:45 -0600
Subject: Re: [PATCH v2 0/3] mach-omap2: handle autoidle denial
To:     Stephen Boyd <sboyd@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        <bcousson@baylibre.com>, <letux-kernel@openphoenux.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <mturquette@baylibre.com>,
        <paul@pwsan.com>, <tony@atomide.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <154353757335.88331.5161306764126530976@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <6c450d4f-8dbf-5122-edcc-3ac17e295bbe@ti.com>
Date:   Fri, 30 Nov 2018 09:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154353757335.88331.5161306764126530976@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 02:26, Stephen Boyd wrote:
> Quoting Andreas Kemnade (2018-11-10 12:31:12)
>> On the gta04 with a dm3730 omap_hdq does not work properly when the
>> device enters lower power states. Idling uart1 and 2 is enough
>> to show up that problem, if there are no other things enabled.
>> Further research reveals that hdq iclk must not be turned off during
>> transfers, also according to the TRM. That fact is also correctly described
>> in the flags but the code to handle that is incomplete.
>>
>> To handle multiple users of a single ick, autoidle is disabled
>> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
>>
>> Changes since v1:
>> - uses spinlocks instead of mutexes
>> - invert counter logic
>> - check whether clock type is basic
>>
> 
> I'm expecting someone like Tero or Tony to review this.
> 

Rest of it looks fine to me, except for the discussion under the 
CLK_IS_BASIC flag, which might trigger a bigger rework of the code.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

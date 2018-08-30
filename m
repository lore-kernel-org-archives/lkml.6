Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59355C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D632082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K9l3a4p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D632082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeH3L32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:29:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46332 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3L32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:29:28 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7U7Ses6085395;
        Thu, 30 Aug 2018 02:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535614120;
        bh=UQdhQD/tBltxLPxIZbTxfEU9Fmannm3/atQQ3yTG5a0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=K9l3a4p/zTEuwuyiIvS7BGEcCOTeNouhYfF4lKsWPQNE66pkPexsd6vJOHrcaqlTk
         YgipK8/tIQ6Ab+y1QVOhIV8w8g1HqJitwzFNke/H5kgEh+o+EbXDtdHxh4aeI8sA+W
         f/36BbeSi36EBaHGzmmvdpatqvB4g47StH1imP/k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7U7SeZe021652;
        Thu, 30 Aug 2018 02:28:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 30
 Aug 2018 02:28:39 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 30 Aug 2018 02:28:39 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7U7SbNK026987;
        Thu, 30 Aug 2018 02:28:37 -0500
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180822090319.29167-1-johan@kernel.org>
 <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
 <20180829075007.GC28861@localhost>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <4fbdbb5d-6b56-37e2-08e1-27f71cb6de22@ti.com>
Date:   Thu, 30 Aug 2018 10:28:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180829075007.GC28861@localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/18 10:50, Johan Hovold wrote:
> On Tue, Aug 28, 2018 at 03:32:03PM -0700, Stephen Boyd wrote:
>> Quoting Johan Hovold (2018-08-22 02:03:19)
>>> Fix child-node lookup which by using the wrong OF helper was searching
>>> the whole tree depth-first, something which could end up matching an
>>> unrelated node.
>>>
>>> Also fix the related node-reference leaks.
>>>
>>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
>>
>> Found by inspection? Or it's actively causing problems? I'm thinking
>> it's the former so this can bake in clk-next for a while.
> 
> Right, through inspection. I fixed up most of these last year, but this
> one managed to sneak in since then.
> 
> clk-next should be fine.

The patch looks fine to me also, just had to test this out with my 
latest development branch as it conflicts with that one a bit.

Acked-by: Tero Kristo <t-kristo@ti.com>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

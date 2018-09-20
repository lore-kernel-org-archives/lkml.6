Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA706C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7483D21524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hd43VoKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7483D21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeITMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:53:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38626 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeITMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:53:15 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8K7BEQv017362;
        Thu, 20 Sep 2018 02:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537427474;
        bh=zKFN5FvlRlagb4WHq1YrilxEq5NxUOS9GURBty6oZKs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hd43VoKuat+HXXv+QMGmAT9PSZG9ZgnoRGMPxPBcCFp5lWbB/zmDTNSMmFZHvlCBb
         PYXtrAQyorFXtVQXC/j+vskiXoZZap9ff0T/JP0ACgkzbUEb4lSMoewmLgDmWxmjn7
         LwIG1OwYHiEVrcSTeSgsYY7+BEhacKfGLQkogxDc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8K7BEQC006173;
        Thu, 20 Sep 2018 02:11:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 20
 Sep 2018 02:11:14 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 20 Sep 2018 02:11:14 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8K7BB2A019314;
        Thu, 20 Sep 2018 02:11:12 -0500
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
To:     Stephen Boyd <sboyd@kernel.org>, Johan Hovold <johan@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180822090319.29167-1-johan@kernel.org>
 <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <9a80b925-a36e-3895-f91b-4716d5524249@ti.com>
Date:   Thu, 20 Sep 2018 10:11:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153566556601.129321.16962771053169973395@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/18 00:46, Stephen Boyd wrote:
> Quoting Johan Hovold (2018-08-22 02:03:19)
>> Fix child-node lookup which by using the wrong OF helper was searching
>> the whole tree depth-first, something which could end up matching an
>> unrelated node.
>>
>> Also fix the related node-reference leaks.
>>
>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> ---
> 
> Applied to clk-next
> 

Stephen, this patch causes a merge conflict with some of the code I am 
planning to send a pull-req against (the clkctrl work series: 
https://patchwork.kernel.org/project/linux-clk/list/?series=13841)

Would it be possible to drop this from clk-next, and for me to 
pick-it-up via my own branch? I can get this setup either today or tomorrow.

Alternatively I need an immutable branch against which I can work.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E720834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vGOQlSsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9E720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeJEVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:11:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeJEVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:11:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95EBqQr102146;
        Fri, 5 Oct 2018 09:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538748712;
        bh=oTcLWPBg/2WoaXWqMGfrV8FL4K8f9KfeKvr/tSjBNbk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vGOQlSsP4ECAOTgmKNoc1tUZj05hHpfNCqmWDXkYPbQoWHr7a42NakvI/ggS/zC3O
         PhF1RJztUE2XPH4GBVZ95Qsu91MnBGxGz8yc2+xXRjaOpV8+pF281zsFDWquT6AKVa
         6vK+H2ZdKY2uiJ2XFWEGq5sTrVTZW7uRfbXiWkKs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95EBqen003503;
        Fri, 5 Oct 2018 09:11:52 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 09:11:51 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 09:11:51 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95EBp18010680;
        Fri, 5 Oct 2018 09:11:51 -0500
Subject: Re: [PATCH 04/12] i2c: omap: use core to detect 'no zero length'
 quirk
To:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-5-wsa+renesas@sang-engineering.com>
 <20181005122409.GH5433@kunai>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0a7bf9ae-8c20-ce11-0c01-33a3f0eeb93a@ti.com>
Date:   Fri, 5 Oct 2018 09:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005122409.GH5433@kunai>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 07:24 AM, Wolfram Sang wrote:
> On Mon, Jul 23, 2018 at 10:26:08PM +0200, Wolfram Sang wrote:
>> And don't reimplement in the driver.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Ping.
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii

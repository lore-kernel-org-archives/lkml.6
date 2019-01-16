Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C78C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453CE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k+icA/Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbfAPJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:24:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59118 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbfAPJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:24:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0G9OgYk114666;
        Wed, 16 Jan 2019 03:24:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547630682;
        bh=zTEf94y7Pk91M30bP8XHMSqFsjsx9kY46i1CHS2lbgg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k+icA/Zj7QQVoYnzg3E7ICK3VMtIB5/3/Ixh5uW/+Ra4B11fG95aQDbyVYlrGSSsI
         tPU36SWgrLs9MCIkZfV3WPR5g79h+gsYWfEh8noVXBD4i75CSgzvJXUCjuTfE8EkpK
         pYpzXm0m2DT0n4JBeXKRKHjlvLVylCihx+4uun54=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0G9Ogqc042086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 03:24:42 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 03:24:42 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 03:24:42 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0G9OcXd001184;
        Wed, 16 Jan 2019 03:24:38 -0600
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Andy Gross <andy.gross@linaro.org>
CC:     David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
 <20181228160546.GC25288@hector.attlocal.net>
 <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <01b81f00-dc33-cc33-53e6-c937548aa7ab@ti.com>
Date:   Wed, 16 Jan 2019 14:54:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <839a30f7-b3fa-739a-52b4-5438e8573dc3@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/01/19 2:40 PM, Marc Gonzalez wrote:
> On 28/12/2018 17:05, Andy Gross wrote:
> 
>> On Fri, Dec 21, 2018 at 11:13:18AM +0100, Marc Gonzalez wrote:
>>
>>> The private copy of readl_poll_timeout is no longer needed.
>>> Use the implementation in iopoll.h instead.
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>
>> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
> Would this patch go through your tree or Kishon's tree?

I've merged this in phy -next.

Thanks
Kishon

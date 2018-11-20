Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46ABC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E72075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BKK9u8qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9E72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbeKTRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:53:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41820 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKTRxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:53:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK7PP79047827;
        Tue, 20 Nov 2018 01:25:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542698725;
        bh=O+ejHN4WSccVyDskA1roUPk/Q5ZS4XxehQPkmbSvQkA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BKK9u8qK/vEW23Zx9OJuKYLq3WU12q4qPO17dKvHS4wAL9k8IAN3n+SDQ/nKpgRLE
         Hah7hum9VPdfnmpwtrvaW9feirStfbSCJVtdfLq7BnDGSy3L07ugPpG1ZVWd7GVo4+
         mjlkOkJeh5IoTfZirjl4xe7u3u3WJsTrRMChgk04=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK7PO0i045260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 01:25:25 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 01:25:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 01:25:24 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK7PMHK019469;
        Tue, 20 Nov 2018 01:25:23 -0600
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during
 tuning
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-2-faiz_abbas@ti.com>
 <CAPDyKFo==Up-pTGZcjMvKWY70-m7i44A5Yr_qJjtpBFjWK8J5g@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <4ff41f24-e152-521e-3fd7-0083b0d4ff98@ti.com>
Date:   Tue, 20 Nov 2018 12:58:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo==Up-pTGZcjMvKWY70-m7i44A5Yr_qJjtpBFjWK8J5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe

On 19/11/18 6:48 PM, Ulf Hansson wrote:
> On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
>> disabled DCRC interrupts during tuning. This write to the interrupt
>> enable register gets overwritten in sdhci_prepare_data() and the
>> interrupt is not in fact disabled. Fix this by disabling the interrupt
>> in the host->ier variable.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Should we have fixes/stable tag?
> 

Ok. Will add that.

Thanks,
Faiz

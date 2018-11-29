Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67FCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31542081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WAsO/oxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeK2VXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:23:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55764 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeK2VXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:23:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATAHLB9070862;
        Thu, 29 Nov 2018 04:17:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543486641;
        bh=YcqgyK16Cut+1DkZNPurkpUbTrkNfjAmz0/aVYoRyy0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=WAsO/oxT0/+B5ENpM5rTKhaaBhpoDwbWJvnKqySAfbKQBtZ0ITcYTZ9LTt1NpvM25
         lOD1Y7Ip+qWNoPAVu66csdncSr9vKIPB0piJ9lhBcBQMjRx8I7LcJJAhQ1pr5Dx8Qq
         EkvmDkuhYMyDimOdqqVbdct873laUL/ukFsbkO74=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATAHLSp000923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 04:17:21 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 04:17:21 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 04:17:20 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATAHGVH002487;
        Thu, 29 Nov 2018 04:17:17 -0600
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     David Lechner <david@lechnology.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFFBCAC.9000004@ti.com>
Date:   Thu, 29 Nov 2018 12:17:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/18 00:37, David Lechner wrote:
> On 11/26/18 1:52 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The remoteproc core creates certain standard debugfs entries,
>> that does not give a whole lot of useful information for the
>> PRUs. The PRU remoteproc driver is enhanced to add additional
>> debugfs entries for PRU. These will be auto-cleaned up when
>> the parent rproc debug directory is removed.
>>
>> The enhanced debugfs support adds two new entries: 'regs' and
>> 'single_step'. The 'regs' dumps out the useful CTRL sub-module
>> registers as well as each of the 32 GPREGs and CT_REGs registers.
>> The GPREGs and CT_REGs though are printed only when the PRU is
>> halted and accessible as per the IP design.
>>
> 
> If the driver used regmap to access the CTRL I/O memory, then
> 'regs' wouldn't be needed since regmap already does debugfs.
> 

ok, we could split out CTRL from this and use regmap.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

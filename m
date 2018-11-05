Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FDBC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94C720825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94C720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeKEUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:31:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55084 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeKEUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:31:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA5BBg6e123216;
        Mon, 5 Nov 2018 05:11:42 -0600
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA5BBgjY006644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 05:11:42 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 5 Nov
 2018 05:11:42 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 5 Nov 2018 05:11:42 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA5BBdOG024983;
        Mon, 5 Nov 2018 05:11:39 -0600
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kishon@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
 <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>
Date:   Mon, 5 Nov 2018 16:44:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 05 November 2018 03:07 PM, Marc Kleine-Budde wrote:
> On 11/05/2018 07:27 AM, Faiz Abbas wrote:
>> I remove the transceiver child node binding documentation in patch 5/6.
>>
>> The existing implementation is pretty limiting as it just has a child
>> node with no associated device. What if a transceiver requires its own
>> configurations before it can start sending/receiving messages (for
>> example, my usecase requires it to pull the standby line low)?
>>
>> I think that can be solved by implementing the transceiver as a phy and
>> exposing a generic get_max_bitrate API. That way, the transceiver device
>> can do all its startup configuration in the phy probe function.
>>
>> In any case, do suggest if you have a better idea on how to implement
>> pull gpio low requirement.
> 
> As long as we don't have any proper transceiver/phy driver, that does
> more than swtich on/off a GPIO, please add a "xceiver" regulator to your
> driver. Look for:
> 
>> devm_regulator_get(&pdev->dev, "xceiver");
> 

The transceiver is not specific to m_can. The pull down would be
required even if it were connected to some other controller.

Thanks,
Faiz

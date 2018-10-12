Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84692C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C35C20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C35C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJLPDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:03:48 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:35198 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJLPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:03:48 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gArw5-0001Mo-DE from Vladimir_Zapolskiy@mentor.com ; Fri, 12 Oct 2018 00:32:37 -0700
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Fri, 12 Oct 2018 08:32:32 +0100
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link
 connection driver
To:     Lee Jones <lee.jones@linaro.org>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-6-vz@mleia.com> <20181012060455.GV4939@dell>
CC:     Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com>
Date:   Fri, 12 Oct 2018 10:32:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181012060455.GV4939@dell>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10/12/2018 09:04 AM, Lee Jones wrote:
> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
> 
>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>
>> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
>> FPD Link connection handling mechanism.
>>
>> Access to I2C devices connected to a remote de-/serializer is done in
>> a transparent way, on established link detection event such devices
>> are registered on an I2C bus, which serves a local de-/serializer IC.
>>
>> The development of the driver was a collaborative work, the
>> contribution done by Balasubramani Vivekanandan includes:
>> * original simplistic implementation of the driver,
>> * support of implicitly specified devices in device tree,
>> * support of multiple FPD links for TI DS90Ux9xx,
>> * other kind of valuable review comments, clean-ups and fixes.
>>
>> Also Steve Longerbeam made the following changes:
>> * clear address maps after linked device removal,
>> * disable pass-through in disconnection,
>> * qualify locked status with non-zero remote address.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>  drivers/mfd/Kconfig                |   8 +
>>  drivers/mfd/Makefile               |   1 +
>>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
>>  3 files changed, 773 insertions(+)
>>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
> 
> Shouldn't this live in drivers/i2c?

no, the driver is not for an I2C controller of any kind, and the driver does
not register itself in the I2C subsystem by calling i2c_add_adapter() or
i2c_add_numbered_adapter() or i2c_mux_add_adapter() etc, this topic was
discussed with Wolfram also.

Formally the driver converts the managed IC into a multi-address I2C
slave device, I understand that it does not sound like a well suited driver
for MFD, but ds90ux9xx-core.c and ds90ux9xx-i2c-bridge.c drivers are quite
tightly coupled.

--
Best wishes,
Vladimir

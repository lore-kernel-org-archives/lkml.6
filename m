Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE1C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4852628A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sglFhWGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4852628A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeF0L0g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:26:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32976 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeF0L0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:26:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RBPVxf117146;
        Wed, 27 Jun 2018 06:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530098731;
        bh=vM2toye/pXD13nvLkPzijXvmS35hp2WoDrjD6K7YFmM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sglFhWGqgXL4VF8Xx3msOu/8GXa/oKv+phJbzdYw1wZwUeuonwX+mcaupuybKRFnt
         /7RfxZrUEZGG0JTAkfDXymvtgZ2Bc8nPtGQliI2pDXnwTRV6Zds0XNgBGAJrPiC1Oh
         blecHdew4/P09uW5R1XW/M1l9qZjNCxcIgBWM8OI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBPVWp003807;
        Wed, 27 Jun 2018 06:25:31 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 06:25:30 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 06:25:30 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBPR0w018516;
        Wed, 27 Jun 2018 06:25:28 -0500
Subject: Re: [RESEND (again) PATCH] clkdev: don't call __of_clk_get_by_name()
 unnecessarily from clk_get()
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
References: <20180625160440.10537-1-brgl@bgdev.pl>
 <5824a382-00fc-0af3-097f-519a36c2d555@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <efeb5357-899e-acbb-22ad-6a9bc97013b5@ti.com>
Date:   Wed, 27 Jun 2018 16:55:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5824a382-00fc-0af3-097f-519a36c2d555@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 June 2018 04:32 AM, David Lechner wrote:
> On 06/25/2018 11:04 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The way this function is implemented caused some confusion when
>> converting the TI DaVinci platform to using the common clock framework.
>>
>> Current kernel supports booting DaVinci boards both in device tree as
>> well as legacy, board-file mode. In the latter, we always end up
>> calling clk_get_sys() as of_node is NULL and __of_clk_get_by_name()
>> returns -ENOENT.
>>
>> It was not obvious at first glance how clk_get(dev, NULL) will work in
>> board-file mode since we always call __of_clk_get_by_name(). Let's make
>> it clearer by checking if of_node is NULL and skipping right to
>> clk_get_sys().
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: David Lechner <david@lechnology.com>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
> 
> Reviewed-by: David Lechner <david@lechnology.com>

I think Russell previously said that the patch looks good to him. So you
can probably just add it to his patch tracker.

http://www.arm.linux.org.uk/developer/patches/add.php

FWIW, you can also add:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

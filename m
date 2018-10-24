Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC44ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F272075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cztFMmti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F272075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJYEzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:55:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJYEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:55:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9OKPItO011779;
        Wed, 24 Oct 2018 15:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540412718;
        bh=cG6/6w/sMBsblny11mm4W3i6AOxcGBq7XzNocbJ2Uc8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cztFMmti/HyoLGsoz/UnyCqBds7l05xsSRQtsuq3QuHqrJBzw1kRVMOare1veumOe
         XfUIHKWYkOkSr8VcrM/xMUou6csXTPwnjSBgXVPE/1Tr43XHJlz4/SS112gqR4Fhdr
         NXunAGYtNUdnC+JP63pqHXqshONOF+QF0uRx0Nxo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OKPHgG015319;
        Wed, 24 Oct 2018 15:25:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 24
 Oct 2018 15:25:17 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 24 Oct 2018 15:25:17 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9OKPHpr030514;
        Wed, 24 Oct 2018 15:25:17 -0500
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com>
 <20181024202048.7e3534f7@bbrezillon>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <99a506e3-d9d5-0d3e-26e1-031447c14857@ti.com>
Date:   Wed, 24 Oct 2018 15:25:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024202048.7e3534f7@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/18 1:20 PM, Boris Brezillon wrote:
> Hi Arnd,
> 
> On Mon, 22 Oct 2018 15:34:01 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> 
>> +
>> +static void cdns_i3c_master_rd_from_rx_fifo(struct cdns_i3c_master *master,
>> +					    u8 *bytes, int nbytes)
>> +{
>> +	readsl(master->regs + RX_FIFO, bytes, nbytes / 4);
> 
> Vitor reported a problem with readsl(): this function expects the 2nd
> argument to be aligned on 32-bit, which is not guaranteed here. Unless
> you see a better solution, I'll switch back to a loop doing:
> 
> 	for (i = 0; i < nbytes; i += 4) {
> 		u32 tmp = __raw_readl(...);

Pls, do not use __raw io.

> 		memcpy(bytes + i, &tmp,
> 		       nbytes - i  > 4 ? 4 : nbytes - i);
> 	}
> 
>> +	if (nbytes & 3) {
>> +		u32 tmp;
>> +
>> +		readsl(master->regs + RX_FIFO, &tmp, 1);
>> +		memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);
>> +	}
>> +}
> 
> Regards,
> 
> Boris
> 

-- 
regards,
-grygorii

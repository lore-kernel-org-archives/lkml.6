Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D756C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC33E20896
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="crcgB4Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC33E20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeH1Pl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:41:57 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33834 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeH1Pl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:41:56 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AD6D024E259D;
        Tue, 28 Aug 2018 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535457038; bh=ppWQ7/tx1Oix8rSrxt7dXwK0rd5LXdWTK0w45RVjSvs=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=crcgB4PaXlofsTfDHv5m9kbe1FGZ7jXvRPD5M61agF9g2GoEpkqoZswOBUjoAvQ7W
         FOTd5IAqLLNf07FI4O49F976jjIfpjI/HLX8dy2lXDOY9oDjFvMK1jY5FcVVIM3nut
         r8Fpivbo5Li/DsxHY3uwBkAnDhgF9HrQ0jkGwpjVl2OjvUxDgPO3FKei4JLULfKYXv
         QmPwM6BIrtufhw32gYYXlotOUsDw0ob1mNCIbmgLGnMBfA8+f/xXl4kdfdlhAIpAiP
         0aQGfTtG4WuzSIAB5qEjSmhbzonpUo0/J5R5Onx2EOqv6+eepiunZaYsoZF8bAKMsA
         3rh9eB64gbtoA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0210D38A6;
        Tue, 28 Aug 2018 04:50:34 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 28 Aug 2018 04:50:34 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 28 Aug 2018 13:50:32 +0200
Received: from [10.0.2.15] (10.107.25.43) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 28 Aug
 2018 13:50:32 +0200
From:   vitor <Vitor.Soares@synopsys.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <Vitor.Soares@synopsys.com>
CC:     <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
Message-ID: <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
Date:   Tue, 28 Aug 2018 12:50:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824201600.7d80bca9@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.25.43]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

The DT Bindings say "The node describing an I3C bus should be named 
i3c-master.". Do you have a field for secondary master?

On 24-08-2018 19:16, Boris Brezillon wrote:
> Well, before even considering supporting secondary master registration,
> we need to handle mastership handover. As for the DAA operation, it's
> likely to be host specific, so we'll have to add a new hook to the
> i3c_master_controller_ops struct.
Do you mean when master try to delegate the bus ownership through 
GETACCMST? or to get the bus ownership with IBI-MR?

I think that could be useful to pass the ibi type on request_ibi(), 
there is some case where the master doesn't support IBI-MR.

> Once you've done that, we'll have trigger a mastership handover
> everytime an I3C driver tries to send a frame on the bus, and the
> master this frame should do through is not in control of the bus. That
> should be pretty easy for the nominal case, but error cases are likely
> to be hard to deal with.
> Note that I have a ->cur_master field in the i3c_bus object which
> stores allows us to track whose the currently active master. If
> master->this != master->bus->cur_master that means you need to start a
> mastership handover procedure.
>
> That's all I thought about for now, and we'll probably face other
> problems when implementing it. Let me know if you have other questions,
> and don't hesitate to share your code early during the development
> phase.
>
> Also note that the bus representation is likely to change based on
> Arnd's feedback, so you might have to rework your implementation a bit
> at some point.
>
> Regards,
>
> Boris

Best regards,
Vitor Soares

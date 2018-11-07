Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968C20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bt/dqyEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeKHDCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:02:06 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41760 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeKHDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:02:05 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B470710C07D2;
        Wed,  7 Nov 2018 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541611843; bh=xdJNds76opZdu7+EfNJboBfzvYozz5e2lRkCFOVGR90=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Bt/dqyEZkJMH5TQw6njJutjKpZjRv/fRBWTl/jsoh45uG2Yf9aNmQrSs97iPhvr9A
         r3CarCfBikYdt/ox3C8yFr+YMEIVBSEP818NUL5SAj0hYbjK4pFmZW0k2j6sKkEWkP
         4tsVaZLtFnsVujaCsqEMYilf8Z1D4u7MpmVg5y6O1Or/M+c9y2eQsVjYXVLrtguLh8
         V7wEtr5qMuDpKL3GG72NmTcl05O7pdZrUUTBh8zu61xExM7RxA/j4t+//gdT8a5atc
         nf+C2ZePl3jXgRt49YwtVx3tG13o1zCsUxhJU7VDo2caN8AkPHOEhhfP3+qpPeVy+m
         MrnczsIxp4loA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id DA25032E9;
        Wed,  7 Nov 2018 09:30:40 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 09:30:40 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 18:30:38 +0100
Received: from [10.0.2.15] (10.107.19.141) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 7 Nov
 2018 18:30:38 +0100
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Matthew Wilcox <willy@infradead.org>,
        Vitor soares <vitor.soares@synopsys.com>
CC:     <boris.brezillon@bootlin.com>, <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>, <luis.oliveira@synopsys.com>,
        <manuel.abreu@synopsys.com>, <gustavo.pimentel@synopsys.com>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
 <1540807618-13246-2-git-send-email-soares@synopsys.com>
 <20181107170553.GJ3074@bombadil.infradead.org>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <d2540ea9-edbd-3b36-0647-54919a9dfa2d@synopsys.com>
Date:   Wed, 7 Nov 2018 17:30:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107170553.GJ3074@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.107.19.141]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,


On 07/11/18 17:05, Matthew Wilcox wrote:
> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>> Add driver for Synopsys DesignWare I3C master IP
> The so-called "data sheet" (actually just an advertising brochure)


The datasheet is there to download.


> on your website claims DMA support.  I don't see that support
> anywhere in this driver.
>

Right now the driver does not support DMA interface which will be added 
later as the other missed I3C features.

What do you suggest to avoid this misunderstanding?


Best regards,

Vitor Soares



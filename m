Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F40C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2363A2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z6NnUd76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2363A2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKHAqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:46:31 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:44734 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:46:30 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 46A1224E140B;
        Wed,  7 Nov 2018 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541603743; bh=sARyqm8mFbJsXoUIRJKZUkkhpVFyUXiE4oe8QDgg4zs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Z6NnUd765KzIFMTF6aZ9O22BePy+fW5NdBJwaMACEjBOLH36wVr9WMCH7wEp95ilr
         Z81DgDGYtyU2BkeBkF7lAEMClQnV7tQX74OGt9stN08OaF7ElPFllIdx7Ejh0AhbO4
         5TjPYbfv/8swLKl9qSw88flLa9LGyyVOWcX4RXRroIeXGTHR8z2ns1aVw9tLtvt9eC
         znlHUK9v6hB53TQJiKouwnAKcaeR/4V7istaa+Bfn76SiWTUMc1DJraBoeVJrvOJZy
         8ZAw3q3gWlE959kOMJxdszYfqeyoqF65cPlFY7t5GV5cvbRHmBRCUViU+3Ab9qHGkr
         8/lOsfBRP62og==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 52ECE393A;
        Wed,  7 Nov 2018 07:15:39 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 07:15:39 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 16:15:37 +0100
Received: from [10.0.2.15] (10.107.19.141) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 7 Nov
 2018 16:15:36 +0100
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
 <20181029134100.GD28520@bombadil.infradead.org>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <8a71cb94-ccf5-8ec0-446a-37a29405f585@synopsys.com>
Date:   Wed, 7 Nov 2018 15:15:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029134100.GD28520@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.141]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Thank for your feedback.

On 29/10/18 13:41, Matthew Wilcox wrote:
> On Mon, Oct 29, 2018 at 10:06:56AM +0000, Vitor soares wrote:
>> +config DW_I3C_MASTER
>> +	tristate "Synospsys DesignWare I3C master driver"
>> +	depends on I3C
>> +	depends on !(ALPHA || PARISC)
> why?

Please check this email thread: https://lkml.org/lkml/2018/10/8/393

>
>> +	help
>> +	  Support·for·Synopsys·DesignWare·MIPI·I3C·Controller.
> These strange characters (displayed as a centred dot on my terminal)
> should probably be spaces.

Something went wrong here. I need to check it.

>
>> +static struct dw_i3c_xfer *
>> +dw_i3c_master_alloc_xfer(struct dw_i3c_master *master, unsigned int ncmds)
>> +{
>> +	struct dw_i3c_xfer *xfer;
>> +
>> +	xfer = kzalloc(sizeof(*xfer) + (ncmds * sizeof(*xfer->cmds)),
>> +		       GFP_KERNEL);
> You should be using struct_size() here.

This seem to be recent. I will use it next version :D

Best regards,
Vitor Soares

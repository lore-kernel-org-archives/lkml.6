Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B01C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60222184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gyPsA7e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfBLFwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:52:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49146 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLFwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:52:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C5pGxq099477;
        Mon, 11 Feb 2019 23:51:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549950676;
        bh=GGIZiQ3XvjF7PK7mffhRzev9r+oQlkwmOJ6C/s4RqK4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gyPsA7e/usyp4fCB90sOFP5iGZ6/5V9wkljs39gmJkiuHmZ3p9J0XVLYnPkHF+8cf
         OTHJ8N0Ut+B9fGcUqdaRH0jH16XNK+YnZ3RLhCUepVbGp/blGYg7ISOtsKrUwGDoEQ
         C/7vQRCn8D9I1jxA38GMjqIBGdg9DJVyNsjue0fE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C5pG3X060272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 23:51:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 23:51:15 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 23:51:16 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C5pCfs026531;
        Mon, 11 Feb 2019 23:51:13 -0600
Subject: Re: [RESEND PATCH v2 17/33] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        David Lechner <david@lechnology.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-18-brgl@bgdev.pl>
 <67127a57-3d1f-5cf4-efb8-f1a2a49b3a2a@arm.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a852c17c-786a-c568-5736-789901926f42@ti.com>
Date:   Tue, 12 Feb 2019 11:21:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <67127a57-3d1f-5cf4-efb8-f1a2a49b3a2a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/19 6:30 PM, Marc Zyngier wrote:
> On 11/02/2019 12:25, Bartosz Golaszewski wrote:

>> +	/*
>> +	 * Nobody knows why anymore, but this interrupt has been handled as
>> +	 * a level irq from the very beginning of davinci support in mainline
>> +	 * linux.
>> +	 */
>> +	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
>> +
> 
> Now, the real question is: why isn't that set as part of the
> set_irq_type() callback, instead of hardcoding it in the platform?
> 
> This is exactly the kind of information that should come as part of the
> DT or from the driver as one of the request_irq() flags.
> 
> It would save quite a bit of boilerplate code.

True, but I would keep this series feature/bug compatible with existing
code. Without that, tracking regression reports will be a nightmare. Its
a pretty major change already.

We can (and should) fix this, but I prefer thats done as follow-up patch
after this series is merged. That way a revert is easy.

BTW, I don't quite see which in-kernel module uses this interrupt. It
might be some out-of-tree code, or some code that since got removed from
kernel.

Thanks,
Sekhar


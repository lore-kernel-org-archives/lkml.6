Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15EEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C9208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYNVvHoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607C9208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeGaJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeGaJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:47:40 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A54208AF;
        Tue, 31 Jul 2018 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533024511;
        bh=Ov2xTIGMHhZdATrLJE9J3zBwkZMMFsGOyy5uxCrShMI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dYNVvHoTJcWiJOvb3ZdjVN6ALt+pVL3OOvWsZwPMQrNIDd0GCvzzZV420djzreL4L
         MSXJx4i8EKsDsItGY7FId9+z175RMRwAtBuzZpYNedTSKJcjgccB4iIokBjII8r6Qy
         UdR9xBvvUP2hiVYCy7Ayt+FOy1wFbwppMmLqfpZs=
Received: by mail-wr1-f42.google.com with SMTP id q10-v6so15601753wrd.4;
        Tue, 31 Jul 2018 01:08:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlGyd947wXxf39XbhUk3bLWC7jT8ExBXt++PVbQqxECqdDc8j4Vx
        5VXxU3Ewmf63d5YobCJnySawFacMjyb/4xuvfnQ=
X-Google-Smtp-Source: AAOMgpexueUQ236IqTq9cjpregMoyfiyrPfAmjI8o9KEffC3CiyVIuaoiR78yzZO+hqiUuT6AdXwKK8JLzhm6fhiKwY=
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr21452980wra.9.1533024510091;
 Tue, 31 Jul 2018 01:08:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 01:08:29
 -0700 (PDT)
In-Reply-To: <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 10:08:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfKEeZmk2zo4gdasES6Fx7Tq=wuVAtsq9+tNWMaTj8QnA@mail.gmail.com>
Message-ID: <CAJKOXPfKEeZmk2zo4gdasES6Fx7Tq=wuVAtsq9+tNWMaTj8QnA@mail.gmail.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded interrupts
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 00:42, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
>
> On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
>> [+cc Thomas, Christoph, LKML]
>>
>> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> > If we have a threaded interrupt with the handler being NULL, then
>> > request_threaded_irq() -> __setup_irq() will complain and bail out
>> > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> > being NULL and set IRQF_ONESHOT in this case.
>> >
>> > This change is needed to migrate the mei_me driver to
>> > pci_alloc_irq_vectors() and pci_request_irq().
>> >
>> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
>> usage isn't mentioned in the request_threaded_irq() function doc or
>> Documentation/
>
> Possibly these other request_threaded_irq() callers are similarly
> broken?  I can't tell for sure about tda998x_create(), but all the
> others certainly call request_threaded_irq() with "handler == NULL"
> and irqflags that do not contain IRQF_ONESHOT:
>
>   max8997_muic_probe()
>     request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)
>
>   tda998x_create()
>     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
>     (I can't tell what irqd_get_trigger_type() does)
>
>   ab8500_btemp_probe()
>   ab8500_charger_probe()
>     request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)
>
>   lp8788_set_irqs()
>     request_threaded_irq(virq, NULL, ..., 0, ...)
>
>   max77686_rtc_probe()
>     request_threaded_irq(info->virq, NULL, ..., 0, ...)

max77686 works fine because it it is nested IRQ. Parent has ONESHOT flag set.

Best regards,
Krzysztof

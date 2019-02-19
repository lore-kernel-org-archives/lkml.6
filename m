Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63A821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBSPxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:53:45 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33322 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBSPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:53:44 -0500
Received: by mail-ed1-f54.google.com with SMTP id a2so17204848edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XO+WO6xE0sJpb69dFxFEH0+rH2yDa9nljVHwRisqqhU=;
        b=fGxCg4h0raDlGEF9NyAH6uVCNr8Hv46vZjSfPQbME3Zdj71Cv1OD+6TgkTtm6jIsD4
         V3lPGcReoEDRvuakvpQm/IqRlZvUAZ4V/SXRshnpYKxyMrcUHGPiVoqJOYsDKXIEghW/
         K3htjaUIvU1TLT3HZMX4x8bykLHFuNWUaf1VHQn9iIqYlpBqUWZEfItD6z7b69IT0TKV
         YCYI1lHxhoPidl1+7JmCiVyWpe43wB/9lmflV8mAQtHiTJH990MHUbDluJsVWqH5YxJZ
         Pp8lQu3UJBkK7bLnF4oENff2e/p/LO2lQQ+TIo6DUP1DaKC1+avtmIqp7Hg+4DMB+r+S
         +r5w==
X-Gm-Message-State: AHQUAuZebNWO7wzY+yRsyGjAIEkzWDDgZWq9k4T+tIxRQANiD78FRCE6
        Bg6gKyHqlXwRGvtRj+n9g0WakaVmhtc=
X-Google-Smtp-Source: AHgI3IZqJEVrH/fjAIWY6IyOwZENsyUsLvc4ijeyJC9NSw6RE/Zr9B7SEW14lNoQoeGNkWp+j4FEbQ==
X-Received: by 2002:a17:906:4a53:: with SMTP id a19mr20434551ejv.229.1550591622923;
        Tue, 19 Feb 2019 07:53:42 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u49sm3033893edm.37.2019.02.19.07.53.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 07:53:42 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: False positive "do_IRQ: #.55 No irq handler for vector" messages on
 AMD ryzen based laptops
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <95e76875-f6b2-cbea-cd74-dc14ee77b2f8@redhat.com>
Date:   Tue, 19 Feb 2019 16:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Various people are reporting false positive "do_IRQ: #.55 No irq handler for vector"
messages on AMD ryzen based laptops, see e.g.:

https://bugzilla.redhat.com/show_bug.cgi?id=1551605

Which contains this dmesg snippet:

Feb 07 20:14:29 localhost.localdomain kernel: smp: Bringing up secondary CPUs ...
Feb 07 20:14:29 localhost.localdomain kernel: x86: Booting SMP configuration:
Feb 07 20:14:29 localhost.localdomain kernel: .... node  #0, CPUs:      #1
Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 1.55 No irq handler for vector
Feb 07 20:14:29 localhost.localdomain kernel:  #2
Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 2.55 No irq handler for vector
Feb 07 20:14:29 localhost.localdomain kernel:  #3
Feb 07 20:14:29 localhost.localdomain kernel: do_IRQ: 3.55 No irq handler for vector
Feb 07 20:14:29 localhost.localdomain kernel: smp: Brought up 1 node, 4 CPUs
Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Max logical packages: 1
Feb 07 20:14:29 localhost.localdomain kernel: smpboot: Total of 4 processors activated (15968.49 BogoMIPS)

It seems that we get an IRQ for each CPU as we bring it online,
which feels to me like it is some sorta false-positive.

I temporarily have access to a loaner laptop for a couple of weeks which shows
the same errors and I would like to fix this, but I don't really know how to
fix this.

Note if you want I can set up root ssh-access to the laptop.

Regards,

Hans


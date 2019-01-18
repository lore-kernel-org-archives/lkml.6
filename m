Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FB1C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF4320855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP/PM6Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfARKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:09:01 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38707 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:09:00 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so8078555vsa.5;
        Fri, 18 Jan 2019 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n+bIrCa8NP47kNy2c+LBCkgyAzNBjMr/5OaE8AJS908=;
        b=GP/PM6KzhJ5mgHy2MpFiP6V/3Z8fWtWIr7ui26qnGnpyJsgMQsmhG9DPGZJPiGsE8y
         E8MnNBGPBrwMqH5IUF6GdeVgCv8Si72pSI2Oivu5uZfmtkFisV4SbfFKsbgs1iLEVvkd
         NbO61JySwPVYSS87fy+jBN2JeaLp5F1nWMOnzyxBvAzEmF+lgIRl7Ix/dydoLUjbYutS
         Es4zpm7QZHGaurBWOubVTy5C/RKcyl7jX091TgKXES0m3tv4NeZpXVcBFdX04m7C479m
         K+kSbxTk/G5nK0KdyEaFtf2PcAKTvtX9kjgVgq2Gy4lnOSn/d+hhqei9GQUyPqZM7U54
         Gs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n+bIrCa8NP47kNy2c+LBCkgyAzNBjMr/5OaE8AJS908=;
        b=eYpVrxW8BHBbCjhEH7RV8ycyDNJxgEIl/hz89xAeI7d6YmdXZCtzyvxEt2PDo33EXO
         Z4VLZ1GjWRbO3ptdJa54mhgV/9zDFHu/SKdcTqfEXwlpfxW8WuHgYyfx2DWbF39NEJ0u
         qJaqALIGirODtGWzBX0J0UwdNfF8NKr4dDeEitwV5SOP0M+Lcgs37iLFQm/OOZgVSI4B
         /lOdjJJL79C1hBow/tPYScIIQhMjZmL5q7wcArJ/E4aP8RyWGPzzhcVpmkFAGB6aaCG9
         rGxRpO7o6bOIdDydDQKMQPY6JiZksCaVOwWAFxkVhRhSibEo0fS9lSOls6/8pqfIHg22
         SNjw==
X-Gm-Message-State: AJcUukev1sLlvGmizijyHtNjBZxzhhJqEEfMsi1jSP/jpQtr/r/gpK0Y
        RH4RDUkgWqewH32w/WUTgLfbUVQoorSTBjZx/G4CpuuX5Pk=
X-Google-Smtp-Source: ALg8bN5YAP4roDEn+VCrnUhEOEhDQm7xkOO6as2Vt9tet88KRpdW6e+snTl+r440Vp8Jgg3+wEYVTqV3MCJNe50mcQQ=
X-Received: by 2002:a67:f793:: with SMTP id j19mr6892160vso.196.1547806139093;
 Fri, 18 Jan 2019 02:08:59 -0800 (PST)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 18 Jan 2019 15:38:48 +0530
Message-ID: <CAOuPNLj4QzNDt0npZn2LhZTFgDNJ1CsWPw3=wvUuxnGtQW308g@mail.gmail.com>
Subject: Need help: how to locate failure from irq_chip subsystem
To:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        kernelnewbies@kernelnewbies.org, Pintu Kumar <pintu.ping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Currently, I am trying to debug a boot up crash on some qualcomm
snapdragon arm64 board with kernel 4.9.
I could find the cause of the failure, but I am unable to locate from
which subsystem/drivers this is getting triggered.
If you have any ideas or suggestions to locate the issue, please let me know.

This is the snapshot of crash logs:
[    6.907065] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    6.973938] PC is at 0x0
[    6.976503] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
[    7.151078] Process qmp_aop (pid: 24, stack limit = 0xfffffffbedc18000)
[    7.242668] [<          (null)>]           (null)
[    7.247416] [<ffffff9469f8d2e0>] __ipipe_dispatch_irq+0x78/0x340
[    7.253469] [<ffffff9469e81564>] __ipipe_grab_irq+0x5c/0xd0
[    7.341538] [<ffffff9469e81d68>] gic_handle_irq+0xc0/0x154

[    6.288581] [PINTU]: __ipipe_ack_fasteoi_irq - called
[    6.293698] [PINTU]: __ipipe_ack_fasteoi_irq:
desc->irq_data.chip->irq_hold is NULL

When I check, I found that the irq_hold implementation is missing in
one of the irq_chip driver (expected by ipipe), which I am supposed to
implement.

But I am unable to locate which irq_chip driver.
If there are any good techniques to locate this in kernel, please help.


Thanks,
Pintu

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350021709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="apr6TZIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8350021709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeHCJ7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:59:18 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:38431 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeHCJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:59:18 -0400
Received: by mail-io0-f170.google.com with SMTP id v26-v6so4294923iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fw3uq72wzY2C0WOUnE1WMU7SdIVyP4R6Aer6NZCq9DE=;
        b=apr6TZIzZkpYFA3iVHaAAAb9WnAeuy98F0hpybaXMsCuCrgdA+k+kh8d5IVsnpl7wZ
         jb9nPorLj6Wql+fia9LT6Pau4bHVTLw+37Y28zMYLcpp8zfeFBrfM9jK4CfkKUfAfEPP
         4A33S4uaO8SCgtS7xmAUjcGDXofn2wmbM/H6BD4cZbM+Nn/3WtT8w+wtYl55wNJfTW6P
         iX/IvD6qYtYHzOJUYaW1X0dNe18oD4kjDHOnqpb8+XGV+5d+bPGiBsSgNWHO/pVFVVeU
         Mj1ufqpdQT9gRkc7NbHC7ZEOWPuIpZtaUKsnJYsGMkver93DrDxWRCTp21yp/r9z5DQP
         SlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fw3uq72wzY2C0WOUnE1WMU7SdIVyP4R6Aer6NZCq9DE=;
        b=YmiUMTJw1LSa7aiKRxcHo4E64oLdUBijgu5MxmSsUGpu24ecFU0+Qe0UqtEx9YAQYT
         NS8s56khtd5fKa9u8LO8Zn3Ti825PQkd06Hc+AG8Qnho6koXncbUTIuFOi8lcnTNHBsT
         A1P19vgcks2AtW65Iex/EFTAnxjgYvnejvzbGlxWsBYcO4bkquBtMBbwMonm8YUkOkbC
         WHhZ6zLHKyEHh6pknhC92vSkNCrfWM9nvQCsqh8RyMnp+yyWPznbKyH/7jAMyf4fUyw1
         BINoubSvbKHM3ul4ijEXKtcHCi4/EkkVFLNtDpTZazNyOBw2z+yoYJw88+2W4Sq7x4iF
         EUSA==
X-Gm-Message-State: AOUpUlFMgxzzN8CDEKi6aD9582c3jTWJu54UCOmVhn9wTSFl5HONSz3o
        RLhPy/v9AOIT5ma9CWmbD4NTh4XsTp8DHBYeX9GAJA==
X-Google-Smtp-Source: AA+uWPz6acsP5THUnBMgCWoh6Yi3a11Pu9wCGHoRQXPEZAn+jupNJprFImyefsX1UGfif5WmysIq/HRM3zIfnZSzgHk=
X-Received: by 2002:a6b:b791:: with SMTP id h139-v6mr5099806iof.274.1533283450308;
 Fri, 03 Aug 2018 01:04:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8704:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 01:04:09 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 3 Aug 2018 16:04:09 +0800
Message-ID: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
Subject: Built in PS2 keyboard in new ASUS/acer laptops can not wake up system
 after s2idle
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-input <linux-input@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,
    We have some new laptops with Intel new Intel WiskyLake CPU come
in and they all have the same problem. They all have the so-called
"Modern Standby" feature which is s2idle in Linux.

    The problem is the built-in keyboard no longer wake up the system
after it goes to s2idle. Only the power button can wake up. It's
different from the other laptops with old Intel CPUs (CoffeeLake,
KaybeLake...etc). We found the difference is that the EC (embedded
controller) no longer signals SCI event when in s2idle.

    Confirmed with ASUS EC engineer, he also admits that the EC code
for signaling SCI event in modern standby has been removed on
WiskyLake models. Because the built-in PS2 keyboard can still wake up
the system on WisksyLake+Windows10 RS4 combination without EC
intervention.

    Based on this information, we suspect that maybe the built-in
keyboard wakeup on Windows 10 RS4 in enabled by default (although we
don't know how to prove that). It's easy to simply do
'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
keyboard port to wake up the system without EC, but it's nasty.

    Any suggestion about how to achieve the keyboard wake up function
on these new laptops in a generic way? Thanks

Chris

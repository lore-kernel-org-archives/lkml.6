Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267E2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C6B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpRbQOK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C6B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJZBiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:38:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54384 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJZBiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:38:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so2281283wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NUTrU1DoU8RMXgrFSJP81+jVhlX/rFUXO4l1Lyo/QdM=;
        b=HpRbQOK/+mpkZ/FHJBZ/FXl+cX87W9v8AXg1kisqO1sAozlF77ScXFMqJmLOcRwhOK
         Xth+QoGV9p83xRQ5UETha314YAbQwAb5QIzLd78YPwQjV2SvUXZEQXIcXy0sgKUhvIYE
         04/Qxf5eX955yox83fSLMsomrwQkPKHSj+yKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NUTrU1DoU8RMXgrFSJP81+jVhlX/rFUXO4l1Lyo/QdM=;
        b=sUAigpt+nBBw8GL4sxpoc/Y/wD89OzEalnDRU6wwKatpy/c5MPAOHhFYsC6FrDuehr
         0x40fMp6RlgNLWKUm8ZgrtYIWva7uH7XZ9pVEO3axvtL6qq0fRpI1FBNmOX55efSc/Vr
         FZhjAES5JgKEE0W5t1/5aNDLZvWB+gcksoqzwSQz5OoT4KrldVAM7+b9y8hWLmcwQFOa
         ftWkmehnn6qrfXQz6kpPk6tU5dUF9wykiLLR25MMuZiBf7aps39QqWSqm6xnH713SeYq
         /DVBZmHy9xQlYwBqAnRmVGPjCX/I7UF+aywPW5zJ6D0vSNhgAbjwtyrMyJ0FWPkZ6AAz
         mciA==
X-Gm-Message-State: AGRZ1gLzcgj/9Tc3/aiUaaLgO+PNX99zhOIzxnes+Z4ajmzjrNx5MVGE
        dY1SelydhpbAZqCjjAuFgfrqRGFUiU3qwCrYNWAmbw==
X-Google-Smtp-Source: AJdET5fj5bczNX5vKF0a5B0pJyHHOZTzBaaunfAPx/iJBawCJRPxsN4LwrvX/hbsoFahp6ftvL7n/3KYQhcNRxtP+ek=
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr2667504wmg.64.1540487072959;
 Thu, 25 Oct 2018 10:04:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 10:04:32
 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 25 Oct 2018 10:04:32 -0700
Message-ID: <CALAqxLVOEVP2g6tPc1RF8mEgfffwWVHSuwrvv_a+oB2d0Jp8rg@mail.gmail.com>
Subject: Regression: OOPs on boot due to "wlcore: Add support for optional wakeirq"
To:     Tony Lindgren <tony@atomide.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Eyal Reizer <eyalr@ti.com>, lkml <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tony,
  In testing linus/master on my hikey board, I'm hitting the following
OOPS on bootup:

[    1.870279] Unable to handle kernel read from unreadable memory at
virtual address 0000000000000010
[    1.870283] Mem abort info:
[    1.870287]   ESR = 0x96000005
[    1.870292]   Exception class = DABT (current EL), IL = 32 bits
[    1.870296]   SET = 0, FnV = 0
[    1.870299]   EA = 0, S1PTW = 0
[    1.870302] Data abort info:
[    1.870306]   ISV = 0, ISS = 0x00000005
[    1.870309]   CM = 0, WnR = 0
[    1.870312] [0000000000000010] user address but active_mm is swapper
[    1.870318] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    1.870327] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
4.19.0-05129-gb3d1e8e #48
[    1.870331] Hardware name: HiKey Development Board (DT)
[    1.870350] Workqueue: events_freezable mmc_rescan
[    1.870358] pstate: 60400005 (nZCv daif +PAN -UAO)
[    1.870366] pc : wl1271_probe+0x210/0x350
[    1.870371] lr : wl1271_probe+0x210/0x350
[    1.870374] sp : ffffff80080739b0
[    1.870377] x29: ffffff80080739b0 x28: 0000000000000000
[    1.870384] x27: 0000000000000000 x26: 0000000000000000
[    1.870391] x25: 0000000000000036 x24: ffffffc074ecb598
[    1.870398] x23: ffffffc07ffdce78 x22: ffffffc0744ed808
[    1.870404] x21: ffffffc074ecbb98 x20: ffffff8008ff9000
[    1.870411] x19: ffffffc0744ed800 x18: ffffff8008ff9a48
[    1.870418] x17: 0000000000000000 x16: 0000000000000000
[    1.870425] x15: ffffffc074ecb503 x14: ffffffffffffffff
[    1.870431] x13: ffffffc074ecb502 x12: 0000000000000030
[    1.870438] x11: 0101010101010101 x10: 0000000000000040
[    1.870444] x9 : ffffffc075400248 x8 : ffffffc075400270
[    1.870451] x7 : 0000000000000000 x6 : 0000000000000000
[    1.870457] x5 : 0000000000000000 x4 : 0000000000000000
[    1.870463] x3 : 0000000000000000 x2 : 0000000000000000
[    1.870469] x1 : 0000000000000028 x0 : 0000000000000000
[    1.870477] Process kworker/0:0 (pid: 5, stack limit = 0x(____ptrval____))
[    1.870480] Call trace:
[    1.870485]  wl1271_probe+0x210/0x350
[    1.870491]  sdio_bus_probe+0x100/0x128
[    1.870500]  really_probe+0x1a8/0x2b8
[    1.870506]  driver_probe_device+0x58/0x100
[    1.870511]  __device_attach_driver+0x94/0xd8
[    1.870517]  bus_for_each_drv+0x70/0xc8
[    1.870522]  __device_attach+0xe0/0x140
[    1.870527]  device_initial_probe+0x10/0x18
[    1.870532]  bus_probe_device+0x94/0xa0
[    1.870537]  device_add+0x374/0x5b8
[    1.870542]  sdio_add_func+0x60/0x88
[    1.870546]  mmc_attach_sdio+0x1b0/0x358
[    1.870551]  mmc_rescan+0x2cc/0x390
[    1.870558]  process_one_work+0x12c/0x320
[    1.870563]  worker_thread+0x48/0x458
[    1.870569]  kthread+0xf8/0x128
[    1.870575]  ret_from_fork+0x10/0x18
[    1.870583] Code: 92400c21 b2760021 a90687a2 97e95bf9 (f9400803)
[    1.870587] ---[ end trace 1e15f81d3c139ca9 ]---


I've bisected it down to 3c83dd577c7f ("wlcore: Add support for
optional wakeirq").

It seems since we don't have a wakeirq value in the dts, the wakeirq
value in wl1271_probe() is zero, which then causes trouble in
irqd_get_trigger_type(irq_get_irq_data(wakeirq)).

Should we check wakeirq before we set the second elements of res[]?

thanks
-john

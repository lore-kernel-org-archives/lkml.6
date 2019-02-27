Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B12C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E11E20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfB0LyP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:54:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfB0LyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:54:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id w26so739346otp.12;
        Wed, 27 Feb 2019 03:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2LxEjR3G2n0l98DT4cTFD+bn75tx4VrgpL+4Cuot5VM=;
        b=pTnECgqrc+MNBddM4GVcAfrKV7D+5THkf+QHJ92oh/m8Q1RkClpjchjZF1RxFcw77L
         Y7TVKuaAhOyg9PIaC3nejvAKknJx1bXizCtO9WWDByFE0yHKF1wIIU27IQuOjPEUkKa2
         Y+93wuhKJ1zee0eLepzxZ6xrHcPlxNN4m/6wi47yyLT/fVNPuy9NuQ6TnJLy9SybZmGo
         NhQcykZXFajwjZwkg81V4itVNau673R43/EJDiBzXQin8gqhxUGi217XMh9fi8cHmrdq
         q42qpLsvX+YP3AU0nGCtv4ln350BEljQ5om57w99whhQjvil5sm5+YNwyaqMEx1dzlZr
         ctww==
X-Gm-Message-State: AHQUAub5jgow28GUcWIdcyudTF9mbK61C6LotDACQb05mB3C1YpTKTR/
        izBt6WVxvepcVUSDZlIdRjRbhzKm+tMe5lOcGgFblGQC
X-Google-Smtp-Source: AHgI3IbvVMXGsO0y/Xd0CJijAEzl0gej2SbYP7ALth3xNgMtbQnimROvvyh9d5Ylq45dkKDbNenIu3iLtSR6tXBSk8E=
X-Received: by 2002:a9d:58c6:: with SMTP id s6mr1981834oth.122.1551268454099;
 Wed, 27 Feb 2019 03:54:14 -0800 (PST)
MIME-Version: 1.0
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 27 Feb 2019 17:24:03 +0530
Message-ID: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
Subject: Request for suggestion on net device re-naming/re-ordering based on
 DT alias
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Harini Katakam <harinikatakamlinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've had some users requesting control over net device name order
when multiple ethernet devices are present on a system. I've tried a
few solutions to this and looked it up on forums. But I apologize if
I have missed something.

I know that the current system allocates eth<n> as per probe order
but that is obviously not stably controlled by user (tried DT
re-ordering and defer probe). One solution is to use DT alias names
to write to (net_device)->name as follows:
Devicetree:
aliases {
   ethernet0 = &mac1;
   ethernet1 = &mac0;
};
Driver probe:
+       /* Read ethernet DT alias id and assign to right device name*/
+       id = of_alias_get_id(np, "ethernet");
+       if (id < 0) {
+               dev_warn(&pdev->dev, "failed to get alias id (%u)\n", id);
+               return id;
+       }
+       snprintf(dev->name, sizeof(dev->name), "eth%d", id);
+

These three drivers seem to have something similar for mdio/phy bus IDs:
drivers/net/ethernet/broadcom/genet/bcmmii.c:409: id =
of_alias_get_id(dn, "eth");
drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c:43: plat->bus_id =
of_alias_get_id(np, "ethernet");
drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:404:
plat->bus_id = of_alias_get_id(np, "ethernet");

Drawback: This approach will break if alias is not provided for one
of the interfaces on board. Not to mention, there could be systems
with multiple ethernet makes (for ex. Cadence macb and Xilinx axienet)
If one of the drivers does not have an alias read mechanism, it is
possible to have clashing ID assignments. Is there any way this
solution can be changed to be stable/acceptable?

One other alternative I've tried is netdev kernel bootargs but this
device name was not being picked by the kernel:
https://www.kernel.org/doc/html/v4.19/admin-guide/kernel-parameters.html
netdev= <mac1’s interrupt id>, <mac1’s base address>, eth0
netdev=<mac0’s interrupt id>, <mac0’s base address>, eth1

Could you please suggest any alternatives?
Thanks!

Regards,
Harini

Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A789C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198A320855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547801355;
	bh=PfX/qo5bHBPtw9Z5T0H6GdhgQkWlAb9EfUxVj3N/U7g=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=Q8Oe/Uu1HmtBXsOhDsMun8jWJ6N1IG/XYiREXJk3kC0oLwQEBJJcgTmrCviyhEqUk
	 MSlbcpC3IXp4o9V6J8IqjOJ0NZT4HGre8WbelRm7vQoezpi+TGafxJ4UgDvRmO6iCi
	 oraHpzEmvqTDTKaFIqnDMYbVIr8F4mG8G08rrU7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfARItN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARItM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:49:12 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E552133D;
        Fri, 18 Jan 2019 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547801352;
        bh=PfX/qo5bHBPtw9Z5T0H6GdhgQkWlAb9EfUxVj3N/U7g=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=T53reYfgFHCnoicOTGkXjqkpzo7p94iGsOH9g3giXgbAEo8HJ8/byI0KdU2gjOUIm
         eCQdQ2Ue/ymaP1DqAPPrYFm6Q7wcnsXxLJKLB0X1naNizcUXMQ20oiK9xqAEKmL7U0
         MWWDXNBkeRDSQHHCUtSJOxXQ4HR6ec/K7P8sD78A=
Received: by mail-lf1-f54.google.com with SMTP id a8so9908556lfk.5;
        Fri, 18 Jan 2019 00:49:11 -0800 (PST)
X-Gm-Message-State: AJcUukfvVa0E2CuHFXjqcuvMNnFIzIxBT+CwVozPtRlnl0dIG39rxu/D
        FnJ0+MEg9klV4UM3/iA6mzqGu1hluma8riyNRoI=
X-Google-Smtp-Source: ALg8bN4GiYrnkTzFXO80ibhyb127ymDN6vDF2esfH/C+kgjjrSjSVn38giE+a3KIIvNDDW3DgSW8d+wReXWe6VAiqUA=
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr12830880lfc.124.1547801349889;
 Fri, 18 Jan 2019 00:49:09 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
In-Reply-To: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 18 Jan 2019 09:48:58 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Message-ID: <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> Expected:
> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
>
> Result:
> [ 15.614964] Root-NFS: no NFS server address
> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> [ 15.634252] Please append a correct "root=" boot option; here are the
> available partitions:
> [ 15.642791] 0100 16384 ram0
> [ 15.642804] (driver?)
> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> on unknown-block(2,0)
> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> root fs on unknown-block(2,0) ]---
>
> Bisect pointed to:
>     net: phy: check return code when requesting PHY driver module

I see now in the logs:
[ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
driver module for ID 0x00221513
which is kind of misleading. There is no initramfs so there is no
usermod library at this point. It is not needed. This seems to break
all DHCP/NFS root boots without initrd/initramfs.

Best regards,
Krzysztof

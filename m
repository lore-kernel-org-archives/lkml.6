Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7459C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32F521726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548166965;
	bh=SJbq+MbTDSRaJtMVQGVTLNT+jJsrO6+dvaVyDG2/iE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YSFIMSN9vJBgd/OQk0hTdbp0v5sTngXQiWahWFUd4S083thWI6NXo2LeOsuJCNuFf
	 GEzzvOEi0nbUYWJt+sFJjBxcFdW+OTUbepqe8TT/zxU6xkF1rooP4p57Po1FE78B8K
	 u3AgoAKCda4maq61CnI/pi5A21HPYfmh5CnmT9Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfAVOWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:22:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbfAVOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:22:43 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D98921721;
        Tue, 22 Jan 2019 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548166962;
        bh=SJbq+MbTDSRaJtMVQGVTLNT+jJsrO6+dvaVyDG2/iE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wLR+XGachqOJN3SwBCCJoHPatf8PhRk0hNuzg+AR0kanKjbexGhgeAAy4om1n+uc2
         uJVvlWiQAPa498Ho2Zm8gvaDkE3lAQ5m+djVEz9tCdDUgmuUUQNLijBES9e/9nxRAK
         uqm5T1yGuQHKlBpIlv6skhlOJ0ZRXKMG3yyT17s0=
Received: by mail-lf1-f54.google.com with SMTP id u18so18178768lff.10;
        Tue, 22 Jan 2019 06:22:42 -0800 (PST)
X-Gm-Message-State: AJcUuke67puEBrm9uBlO8sorL/FNPqD2CWhmZl3ebDvoFb1qUt1xhdKz
        Rioy75+Fpvwoms2uQYq1fdmw7ICTebmzzCZaiUU=
X-Google-Smtp-Source: ALg8bN5mEAZn2B3qgLIr97TphkudtFk+U7dDWJwXXbKMpL87TIvtf3BMhT7Sss+LDCb4n715glh72yraItlgtgZCRB4=
X-Received: by 2002:a19:4948:: with SMTP id l8mr997043lfj.156.1548166960348;
 Tue, 22 Jan 2019 06:22:40 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com> <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
In-Reply-To: <CAMuHMdUz6J2cG-NCYPTRyS=1QZHGBWUFZPqj4ShEdioQLqu9qw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 22 Jan 2019 15:22:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcm3sMrAS8Yag-6YVUF7f=wGjst991WSVWeRMg2zk3FvA@mail.gmail.com>
Message-ID: <CAJKOXPcm3sMrAS8Yag-6YVUF7f=wGjst991WSVWeRMg2zk3FvA@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stefan Agner <stefan@agner.ch>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 14:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Heiner,
>
> On Fri, Jan 18, 2019 at 9:58 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> > On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> > > On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> > >> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> > >> Expected:
> > >> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> > >> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> > >>
> > >> Result:
> > >> [ 15.614964] Root-NFS: no NFS server address
> > >> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> > >> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> > >> [ 15.634252] Please append a correct "root=" boot option; here are the
> > >> available partitions:
> > >> [ 15.642791] 0100 16384 ram0
> > >> [ 15.642804] (driver?)
> > >> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> > >> on unknown-block(2,0)
> > >> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> > >> root fs on unknown-block(2,0) ]---
> > >>
> > >> Bisect pointed to:
> > >>     net: phy: check return code when requesting PHY driver module
> > >
> > > I see now in the logs:
> > > [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> > > driver module for ID 0x00221513
> > > which is kind of misleading. There is no initramfs so there is no
> > > usermod library at this point. It is not needed. This seems to break
> > > all DHCP/NFS root boots without initrd/initramfs.
> > >
> > Thanks for the report. Could you please provide your kernel config
> > and the syslog of a boot before or w/o the patch in question?
> >
> > If you boot via nfs then I'd expect that the PHY driver is built-in and
> > not a module. Therefore it's not fully clear to me yet why
> > request_module() returns -ENOENT.
>
> I'm seeing the same booting nfsroot on several Renesas boards.
> E.g. on r8a7791/koelsch:
>
>     mdio_bus ee700000.ethernet-ffffffff:01: error -2 loading PHY
> driver module for ID 0x00221537
>     sh-eth ee700000.ethernet: MDIO init failed: -2
>

Hi Geert,

There is a follow up patch:
https://www.spinics.net/lists/netdev/msg545573.html

Best regards,
Krzysztof

Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DFA2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547891479;
	bh=HBrjP4nc2mNBCjxtzgXzaKYXXq7POoiuBjp/ZCoUM54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x5meq9wKa3E9GOdS7vBAz32U1GsN+4CDKLybUWiQBXMo1XyCnew7TgVOQi64lIfMi
	 TRRd4+eOyID7eOXuU3sri4osBiSoTT+aTLjQRxPuf84P2WW7AJteDdHjYKwFKuoBvo
	 5imFKUzwqFYNqCRG0/xYfe4WeUKy3vKmAMRhodC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfASJvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfASJvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:51:15 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2BF2087E;
        Sat, 19 Jan 2019 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547891474;
        bh=HBrjP4nc2mNBCjxtzgXzaKYXXq7POoiuBjp/ZCoUM54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tM/xZax4JRm/Ux1Ecjbm23VR6khECWXe0JrJtZciqiZ+1+e16UWvsOgdpniBu+/6d
         tdtUlyEfkmZQfRPy773wNY+m9Pnh+Vh00/XQhr2kd9cvYY23dSyYr6S+1TD2bGnS28
         5Cl6CjdkeHGSm5k6rxGsJI6Y+SAQLyH98l6CNS8U=
Received: by mail-lf1-f49.google.com with SMTP id u18so12221820lff.10;
        Sat, 19 Jan 2019 01:51:14 -0800 (PST)
X-Gm-Message-State: AJcUukdl6X4VkZmVUObOo3mnZLOD3T419GXORghRv58M2nvZrs47xv5f
        OnyWgnW+rHt2amV9sJChVf+gSM/MXLnUrDFHBkU=
X-Google-Smtp-Source: ALg8bN5E04/Q7+E3ia0Ttk3pzkyiGjYyMCQoBayf36D0BTIFFC5J49aGa9/0gQxTyuDIpDPh0Qo69becbLkBLa9ODO4=
X-Received: by 2002:ac2:554b:: with SMTP id l11mr14164647lfk.92.1547891472281;
 Sat, 19 Jan 2019 01:51:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJKOXPdHhUGoQmrX8_23MfbibozipkAzXA_5woVSFJSK9BvbXw@mail.gmail.com>
 <CAJKOXPe7ot9TLajErKJjSAkbs2vObMJfATzEFwxpT16aFdXHqg@mail.gmail.com>
 <67560e58-93b3-2bfa-9d5d-5956dae47806@gmail.com> <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
In-Reply-To: <68b565a2-7813-57a2-1687-43568e53fade@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 19 Jan 2019 10:51:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdbPa_iHwhRccAd41r_OV=q036BE0dNP7YsXSBogr7o3A@mail.gmail.com>
Message-ID: <CAJKOXPdbPa_iHwhRccAd41r_OV=q036BE0dNP7YsXSBogr7o3A@mail.gmail.com>
Subject: Re: [BUG bisect] Missing Micrel driver on VF50 (net: phy: check
 return code when requesting PHY driver module)
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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

On Fri, 18 Jan 2019 at 22:30, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 18.01.2019 21:58, Heiner Kallweit wrote:
> > On 18.01.2019 09:48, Krzysztof Kozlowski wrote:
> >> On Fri, 18 Jan 2019 at 09:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On today's next (next-20190118) my Colibri VF50 board fails to boot up
> >>> from network (DHCP, NFSv4 root). Looks like missing network adapter.
> >>> Expected:
> >>> [ 3.041773] Micrel KSZ8041 400d1000.ethernet-1:00: attached PHY driver
> >>> [Micrel KSZ8041] (mii_bus:phy_addr=400d1000.ethernet-1:00, irq=POLL)
> >>>
> >>> Result:
> >>> [ 15.614964] Root-NFS: no NFS server address
> >>> [ 15.619353] VFS: Unable to mount root fs via NFS, trying floppy.
> >>> [ 15.626762] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> >>> [ 15.634252] Please append a correct "root=" boot option; here are the
> >>> available partitions:
> >>> [ 15.642791] 0100 16384 ram0
> >>> [ 15.642804] (driver?)
> >>> [ 15.649076] Kernel panic - not syncing: VFS: Unable to mount root fs
> >>> on unknown-block(2,0)
> >>> [ 15.657423] ---[ end Kernel panic - not syncing: VFS: Unable to mount
> >>> root fs on unknown-block(2,0) ]---
> >>>
> >>> Bisect pointed to:
> >>>     net: phy: check return code when requesting PHY driver module
> >>
> >> I see now in the logs:
> >> [ 2.436822] mdio_bus 400d1000.ethernet-1:00: error -2 loading PHY
> >> driver module for ID 0x00221513
> >> which is kind of misleading. There is no initramfs so there is no
> >> usermod library at this point. It is not needed. This seems to break
> >> all DHCP/NFS root boots without initrd/initramfs.
> >>
> > Thanks for the report. Could you please provide your kernel config
> > and the syslog of a boot before or w/o the patch in question?
> >
> > If you boot via nfs then I'd expect that the PHY driver is built-in and
> > not a module. Therefore it's not fully clear to me yet why
> > request_module() returns -ENOENT.
> >
> OK, I see. The -ENOENT could refer to the modprobe binary, not the PHY
> driver module. Still it would be helpful to see the kernel config and
> the requested log.

As I wrote - there is no initramfs so there is no modprobe binary
neither. The log and config were attached to the first email.

Best regards,
Krzysztof

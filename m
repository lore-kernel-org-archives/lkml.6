Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3837C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353520813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG2CGAlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7353520813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJXCwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeJXCwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:52:53 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90845204EC;
        Tue, 23 Oct 2018 18:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540319301;
        bh=G2PlBONjhBi9sv1Xw4h/cc+8zN2vfVGL036aDNPg7aY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZG2CGAlQf8OO9gLkJXvzk6IwdqMpSRc9UXnsKDlXN04dRLpieip4Nq2TxeKtVHFZP
         +kYnH59bpFiLl/PtP1Beytul3kF/Kknt1e5G2Xe8f17SmTFaEkVt7CavfN4zWN8x8m
         Nv9J8AUv74IMRfFVKlVVQPfg3J0tvH8mnVZVOtR4=
Received: by mail-qt1-f172.google.com with SMTP id a10-v6so2708343qtp.2;
        Tue, 23 Oct 2018 11:28:21 -0700 (PDT)
X-Gm-Message-State: ABuFfogbdHd3m5li1C8+lX3yb/OaL0/4GIZ6dH9Uu/dj1VblR1IlAQuz
        vSUT/gP7PstNv9xUuxnsev0iqK+ay0k9udC2Fg==
X-Google-Smtp-Source: ACcGV626xKFuZct1TwBK3H5EtHX6IhYLT+6mA62VaDgK/p63QtU+y26y+TVqQfgjpqVjH+HocrDYwTGqVNCnuAM8zbA=
X-Received: by 2002:ac8:3a64:: with SMTP id w91-v6mr49731392qte.144.1540319300770;
 Tue, 23 Oct 2018 11:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180827082153.22537-1-johan@kernel.org> <20180827082153.22537-6-johan@kernel.org>
 <20180827102820.3abf7291@bbrezillon> <20180827084414.GZ14967@localhost>
 <20180827104842.26bce912@bbrezillon> <20180827094423.GA14967@localhost>
In-Reply-To: <20180827094423.GA14967@localhost>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Oct 2018 13:28:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fiM8E-za-fKufgDuoDqu3DY5a4bgZOuF3Ssvj2=6ayg@mail.gmail.com>
Message-ID: <CAL_Jsq+fiM8E-za-fKufgDuoDqu3DY5a4bgZOuF3Ssvj2=6ayg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:44 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 10:48:42AM +0200, Boris Brezillon wrote:
> > On Mon, 27 Aug 2018 10:44:14 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> >
> > > On Mon, Aug 27, 2018 at 10:28:20AM +0200, Boris Brezillon wrote:
> > > > Hi Johan
> > > >
> > > > On Mon, 27 Aug 2018 10:21:49 +0200
> > > > Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > > Use the new of_get_compatible_child() helper to lookup the nfc child
> > > > > node instead of using of_find_compatible_node(), which searches the
> > > > > entire tree from a given start node and thus can return an unrelated
> > > > > (i.e. non-child) node.
> > > > >
> > > > > This also addresses a potential use-after-free (e.g. after probe
> > > > > deferral) as the tree-wide helper drops a reference to its first
> > > > > argument (i.e. the node of the device being probed).
> > > > >
> > > > > While at it, also fix a related nfc-node reference leak.
> > > > >
> > > > > Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> > > > > Cc: stable <stable@vger.kernel.org>     # 4.11
> > > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > > Cc: Josh Wu <rainyfeeling@outlook.com>
> > > > > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > >
> > > > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > >
> > > Thanks for the ack.
> > >
> > > > I'll let Miquel queue this patch to the nand/next branch, unless you
> > > > want it to be merged in 4.19, in which case I'll queue it to the
> > > > mtd/fixes branch.
> > >
> > > Note that there's a dependency on the first patch of the series which
> > > adds the new helper.
> >
> > I was not Cc-ed on this patch :P.
>
> Yeah, sorry about that. I made sure everyone was CCed on the
> cover letter, but guess I could have reused that list for the helper as
> well.
>
> > > Rob can pick up the entire series if the various
> > > maintainers agree, otherwise I'll try to get at the least the helper
> > > into -rc2.
> >
> > If everything goes in 4.19-rc2 through Rob's tree that's fine, but if
> > it's queued for 4.20 we might need an immutable tag just in case we
> > queue conflicting changes to the NAND tree.
>
> Ok, thanks.

Hi Boris, can you pick this one up. It conflicts with "mtd: rawnand:
atmel: Fix potential NULL pointer dereference"

Rob

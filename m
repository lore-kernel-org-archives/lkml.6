Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C4824021
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KOwt81bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C4824021
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeFVKLV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:11:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56449 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFVKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:11:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180622101113euoutp02df9e63f53ea39ddccdcf53fd21d18714~6c7uqclos0469304693euoutp02N;
        Fri, 22 Jun 2018 10:11:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180622101113euoutp02df9e63f53ea39ddccdcf53fd21d18714~6c7uqclos0469304693euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529662273;
        bh=aMOGGWmdpxQJ+wBP/fCdwguKoJhFTfJaOqQHslPzXlE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=KOwt81bgzy2fhK1UOjnxWyYaJ2vJOLO/+mPEV/5p1P13EBVfMMe7u9i53ypgamafd
         f+2fCSGn+YLVutATfvZm4ebVCOQQExebTy7SPUEstk9sdGV7IRnODFOL28R27ed/xC
         gdKpmZrgEmCpRpdFUsexDbYeJtdpvX22X2xxHp1Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180622101112eucas1p102222f1c97c95129130339f4d2310e21~6c7uAub9B0223302233eucas1p1Y;
        Fri, 22 Jun 2018 10:11:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.8C.10409.04BCC2B5; Fri, 22
        Jun 2018 11:11:12 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180622101111eucas1p119946679a7686911744b1296c2796b15~6c7tRsmE31583015830eucas1p1K;
        Fri, 22 Jun 2018 10:11:11 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-5a-5b2ccb40330a
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.A7.04183.F3BCC2B5; Fri, 22
        Jun 2018 11:11:11 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAP006FFYYN5B90@eusync1.samsung.com>; Fri, 22 Jun
        2018 11:11:11 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Peter Jones <pjones@redhat.com>, Sinan Kaya <okaya@codeaurora.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Date:   Fri, 22 Jun 2018 12:11:11 +0200
Message-id: <2887099.lOTkQMqGFA@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <12969617.N13u7zUTf5@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djPc7oOp3WiDU6+Ebb4/2E3o8WVr+/Z
        LDY9vsZqMXH/WXaLE30fWC0u75rDZtE4aRuTRdfCG+wWzY/VHTg9Lvf1MnncubaHzeN+93Em
        j81L6j3e77vK5vF5k1wAWxSXTUpqTmZZapG+XQJXxo7tPewF7wUqZrfsYWtgXM7bxcjJISFg
        IvHs+23WLkYuDiGBFYwST7uPMoIkhAQ+M0qcueYMU/T1ynpmiKJljBLNW8+zQDi/GSXOnTjN
        DFLFJmAlMbF9FVA3B4eIgJ5ES5cZSA2zwC8miXOT2thAaoQFUiWm7H8FtoFFQFWiqf8aWC+v
        gKZEw5fFLCC2qICXxJZ97UwgNqeAtsSJNYcZIWoEJX5MvgdWwywgL7Fv/1RWCFtH4uyxdYwg
        yyQEzrBJnHu7mRnibBeJv+3dLBC2sMSr41vYIWwZicuTu1kgGqYzSrz5tRTKWc8osebMMSaI
        KmuJw8cvQq3gk5i0bTozyGsSArwSHW1CECUeEicfNDBCguI/o0TbrEOsExhlZiG5dhaSa2ch
        uXYBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwGRx+t/xrzsY9/1JOsQowMGoxMMb
        sUI7Wog1say4MvcQowQHs5IIb66/TrQQb0piZVVqUX58UWlOavEhRmkOFiVx3jiNuighgfTE
        ktTs1NSC1CKYLBMHp1QD45HZQnFzLBWv+PoIl/mWn1aKsLwXu2N+O2O8x4foE+/ilt332sPZ
        +zF6F4fsDf8qsS6GV5/OPTU/8y58Q9Yfn0mMoXe3Fd1I+/mlPFSOLfpturrR1yw1rgixbTN7
        1N59EMp1W7zzgMCyT/oPBYw3THlhevl29ef6hbs6T9oFL9jlMSG15I+NoxJLcUaioRZzUXEi
        AEZf13sSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xy7r2p3WiDTbM1bP4/2E3o8WVr+/Z
        LDY9vsZqMXH/WXaLE30fWC0u75rDZtE4aRuTRdfCG+wWzY/VHTg9Lvf1MnncubaHzeN+93Em
        j81L6j3e77vK5vF5k1wAWxSXTUpqTmZZapG+XQJXxo7tPewF7wUqZrfsYWtgXM7bxcjJISFg
        IvH1ynrmLkYuDiGBJYwSv37uZgJJCAn8ZZS48zsLxGYTsJKY2L6KsYuRg0NEQE+ipcsMpJ5Z
        4BeTxNTTK1hAaoQFUiWm7H/FCGKzCKhKNPVfYwaxeQU0JRq+LAarERXwktiyrx1sPqeAtsSJ
        NYcZIRavZpS4+P0RO0SDoMSPyffAGpgF5CX27Z/KCmFrSazfeZxpAiP/LCRls5CUzUJStoCR
        eRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgmG879nPLDsaud8GHGAU4GJV4eCNWaEcLsSaW
        FVfmHmKU4GBWEuHN9deJFuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1
        CCbLxMEp1cC44tCetqINKr4sC6wZWDddPappKvnClNs0pq5wd2r1zQi3+NZPLh0Zkr4ZO9qL
        hZNmRifcOcmzyf5+578A3carsdnrwv+xSX/zdVVTcJJ1PGLjYaAs8E/OQLNWa/vbvH6O5fpd
        6hfcHC1fXDWK7uwOWd0ZoP7VYWr+ZI91qSZT6sqdTQoPKrEUZyQaajEXFScCADrq7/hvAgAA
X-CMS-MailID: 20180622101111eucas1p119946679a7686911744b1296c2796b15
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180622101111eucas1p119946679a7686911744b1296c2796b15
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
        <CAKv+Gu9dFGudOr1uTmOnM=X47gsOAgpdUJ6UMiDJJ_7phH1ZzA@mail.gmail.com>
        <12969617.N13u7zUTf5@amdc3058>
        <CGME20180622101111eucas1p119946679a7686911744b1296c2796b15@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 22, 2018 12:07:48 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, June 22, 2018 09:54:22 AM Ard Biesheuvel wrote:
> > On 13 June 2018 at 18:08, Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> > > On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
> > >> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> > >> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
> > >> > _CRS windows.
> > >> >
> > >> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> > >> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> > >> >
> > >> > When a VGA device is behind such a host bridge and the resource is
> > >> > translated efifb driver is trying to do ioremap against bus address
> > >> > rather than the resource address and is failing to probe.
> > >> >
> > >> > efifb: probing for efifb
> > >> > efifb: cannot reserve video memory at 0x1e000000
> > >> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> > >> > efifb: mode is 800x600x32, linelength=3200, pages=1
> > >> > efifb: scrolling: redraw
> > >> > efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> > >> >
> > >> > Use the host bridge offset information to convert bus address to
> > >> > resource address in the fixup.
> > >> >
> > >> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > >>
> > >> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >>
> > >> Bartlomiej, could you please take these via the fbdev tree for v4.19?
> > >
> > > Sure, I will queue it after the current merge window.
> > >
> > >> Peter already gave his ack but Sinan dropped it (presumably because of
> > >> the split in v2)
> > >
> > > Peter, can I (re)add your ACK to V2 patches?
> > >
> > 
> > Actually, it would be better if we could take this through the EFI
> > tree instead, with your ack. Would you mind?
> 
> Fine with me.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


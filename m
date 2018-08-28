Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5E9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375E20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeH1Qsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:48:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46995 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:48:55 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so1460937qtn.13;
        Tue, 28 Aug 2018 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IhYBP565gSmsT9cNUrFfJvTEU2OYHVdrYq8ka/ryW8=;
        b=oaxOEUWSbWSCMCTwBFXmip4DBh6HPPTkgaxf9o6kGRky/HO9Bz1E+mCIHmgsm4Eai0
         HX3brMFb5FI8pidBvEs7hqB8FyiLVJM4hOev3ji9PZRY9cyc5kqDRk/4h5qyMiPHTmpX
         F7E7rLDPlT1lz5xBWAAF4pYwqxty7xVJhPxTE6XyYdB7yxGjViG6C1zaMB6vsnS+rthz
         kcLnR3DErDhsHdEDH8LZOS3jYfgReTuzHxIIrS3Fi5Gg4Lca1krWhBTFIAHpfMy1vr5w
         KUddQ9JMT32f3TY7SkNRCjtKo31B3eqWdmRgTolfS7zNkx63W2rRiavIPGsWjseqDD0W
         frtA==
X-Gm-Message-State: APzg51BWkH8qNSHsJGRZtWWNVeJ3r3ybbypT8MnbPcBUzW5tUyJK2hkx
        lWUfyh2Y0bJ0igq++opI+QVsQNIbWdSPtVbdi0s=
X-Google-Smtp-Source: ANB0VdalUZcrMvprpwnQI8DUFJZbUc/3LV/NYP70IPJcInuKx4vQX/zjZIy9xeD+FifzLCI8n2F5irVqcsVpJ6UZu6U=
X-Received: by 2002:a0c:885b:: with SMTP id 27-v6mr1361221qvm.115.1535461041864;
 Tue, 28 Aug 2018 05:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com> <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
In-Reply-To: <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:57:05 +0200
Message-ID: <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, gakula@marvell.com,
        sgoutham@marvell.com, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 2:42 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > From: Geetha sowjanya <gakula@marvell.com>
> > >
> > > HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> > > create a IOMMU mapping for the physcial address configured by
> > > firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
> > >
> > > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> >
> > I think this needs some more explanation. What is the difference between
> > the MSI-X support in this driver and every other one? Are you working
> > around a hardware bug, or is there something odd in the implementation
> > of your irqchip driver? Do you use a GIC to handle the MSI interrupts
> > or something else?
>
> This admin function is a PCI device which is capable of provisioning
> HW blocks to other PCIe SRIOV devices in the system. Each HW block
> (eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
> certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
> in memory (not on-chip) which based on HW block provisioning to a PCI device
> attaches the required number of vectors to that device. Some part of this
> configuration is done by low level firmware.
>
> RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
> vectors. If kernel is booted with IOMMU enabled and admin function device
> is attached to SMMU, HW will go through translation to access this MSIX
> vector memory region. Hence the mapping done in this patch.

Do you mean this is not a regular PCIe MSI-X interrupt to the GIC, but
something internal to your device that gets routed through the IOMMU
back into the device?

I'm still confused.

       Arnd

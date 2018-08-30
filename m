Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7A3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFCA205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFCA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeH3Rz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:55:57 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39069 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeH3Rz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:55:56 -0400
Received: by mail-qt0-f193.google.com with SMTP id o15-v6so9847318qtk.6;
        Thu, 30 Aug 2018 06:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFrgYrj00Tp5CkJmXMCnQ28//YPIycij1wGEQHb/n3U=;
        b=WioOFLq+bLa+ZJifZUsbcWhbnz6dXrC1f6v3oLagyiCk8reaULW1dly8/W7RPHymgQ
         awHz1SLBiaPDbR2ljRZYYyrAd8Ot3dzWQAJ+Apb8wQ44BXJwVOhZTeV0LRpM90vRFT0C
         nk6Dd3PeEckS1UDXO9Ch0M2xVzedcRLLI3EQFP4oNKVttbS2vDHpxHEZL0EID4wmZacd
         n+5E9rHLsZN5E9rVLghryAeFBt5GHdD8f2GMXWiH6EqFd1DjWo//pnGaDgfOGmwm3MKj
         o7CveDjUnkVrfhr+T7So5HChqTUbKKVMqp3WVkumKX0Y/Y8+xCCfqCQf8urOqziqrtW2
         V+Bg==
X-Gm-Message-State: APzg51DSHaOANlR/g95Z4CD+W2QVgzRRyI8r7xNeuOEWKC0I087RlbRg
        3sRKHRmi8UuaiIZ4FZ5Jl0Z/LqMscOFZIEP7cG8=
X-Google-Smtp-Source: ANB0VdYeyHT5JpieiRcJ1gCU9s5E/dbJDEykaL5A2ocjlBlr/VrKh9tUnnTZZXw9a11KtjC4ji1TGKUnNxQSUkkx20c=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr11709208qvc.161.1535637221513;
 Thu, 30 Aug 2018 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
 <CA+sq2Cf2BLKsV=gY-MPnygV1ufpvmnw6ETh90JX_uKQBk3Sduw@mail.gmail.com>
 <CAK8P3a0+zJRxEYWZpYShRJo-3oqMaC9TJADugaRTiBnjw7ssPA@mail.gmail.com> <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com>
In-Reply-To: <CA+sq2Cfd_jk=JzcLmPYiW1iGqKrJRrv5vrsmeZfY4W+qi5GLgw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Aug 2018 15:53:25 +0200
Message-ID: <CAK8P3a1BRvhQ9iQWP2hTrJOu+Z+vmmek-Uobw6zX0dM4zFe_gQ@mail.gmail.com>
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

On Tue, Aug 28, 2018 at 3:17 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> On Tue, Aug 28, 2018 at 6:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Aug 28, 2018 at 2:42 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
> > > On Tue, Aug 28, 2018 at 5:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> > >
> > > This admin function is a PCI device which is capable of provisioning
> > > HW blocks to other PCIe SRIOV devices in the system. Each HW block
> > > (eg memory buffer pools, NIC dewscriptors, crypto engines e.t.c) needs
> > > certain no of MSIX vectors. Admin function has a set of 32K MSIX vectors
> > > in memory (not on-chip) which based on HW block provisioning to a PCI device
> > > attaches the required number of vectors to that device. Some part of this
> > > configuration is done by low level firmware.
> > >
> > > RVU_AF_MSIXTR_BASE points to the memory region allocated for 32K MSIX
> > > vectors. If kernel is booted with IOMMU enabled and admin function device
> > > is attached to SMMU, HW will go through translation to access this MSIX
> > > vector memory region. Hence the mapping done in this patch.
> >
> > Do you mean this is not a regular PCIe MSI-X interrupt to the GIC, but
> > something internal to your device that gets routed through the IOMMU
> > back into the device?
> >
>
> This is a regular PCIe MSI-X interrupt, the difference is that the
> bunch of PCI devices
> here doesn't have a fixed set of MSIX vectors. Admin function has a
> memory region with
> 32K MSIX vectors which it provisions to PCI devices based on the HW
> functional blocks
> attached to them. A PCI device which works as a ethernet device needs
> X number of vectors
> and a crypto device needs Y number of vectors.
>
> Since the admin function owns the whole MSIX vector region, HW uses
> this device's stream ID
> to access the vectors. Hence the IOMMU mapping. Once MSIX vectors are
> provisioned to
> a PCI device they work as normal MSIX interrupt like any other device.

Ok, I think I got it now, just to confirm: the MSIX vectors you allocate
in the admin device refer to memory backing the BAR that contains
the MSI-X entries of the other functions, right?

I was a bit confused here and assumed that you were mapping
the MMIO area of an interrupt controller that receives the interupt
transactions.

         Arnd

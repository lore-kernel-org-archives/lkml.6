Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B080CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF072086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hBULB71O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfBUI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:59:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33906 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfBUI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:59:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so29123168wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 00:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnSbCQyycLq8oDMSUhgJQnPqOcaOQETywggOOu0R6lI=;
        b=hBULB71OefHi5mYgZdKD1NE3EtIoi6jjLVuJ5bgwUamg8KMCN/oJs++IvkvVIlDPNp
         ABMbt8JMoBMPK00QmqScGwRUU41MaM7o2M/pqgB/4tQaZZrlj2XBA9LMuh4wMmLaGRjW
         nuVR6S83wrg7GjFGcidYXG+OKmyA9jt27mTFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnSbCQyycLq8oDMSUhgJQnPqOcaOQETywggOOu0R6lI=;
        b=Djt1wHfn1f/ztyU0Gk3h+IHlQTCxlWZVTCOTE0zhLKHs24lp8PWDkhvcPeLpJp7IWN
         VKjqdKflKUScSLpf5kVXO8LGlYpTdqk7K7BaxUtVckNCiGWI5IY0FUXc5RNodgEacArb
         YJNs/C3arM647vBio+AI95YmXQAE5LDJwI6QmXfWk12CTkmmcu4dxa+hLHZKpHpWdmB0
         KqeaiigrSFMrPW4DPQc64D7/hXNvv2HldIiFprDVghvBsKdurIgzTSHNHjFlT5hvCFAu
         igmYm9XsP6sglI0DPTyZtEV74gnRXGuPAVDsIL8u2Ez8lNYDLSYZDcaFTxtVlFpWXKg5
         dhew==
X-Gm-Message-State: AHQUAubuJFAiAMT5/WMY8QvSqxaEqW/QTIHwDZcUrtoiJYr5qYpBWBcg
        OKT3MgLqc5fyFgARpbCMeQu9/uO7lspEAOJz+sgRyQ==
X-Google-Smtp-Source: AHgI3IY19j2QMO10R327qYh6SDi2/lTaEV0OB3iQj9x+9KaDa+CkBDmGVzE+VdaBZnVhahb2hzzhu0py76Een5yp8lc=
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr27875564wrf.83.1550739590847;
 Thu, 21 Feb 2019 00:59:50 -0800 (PST)
MIME-Version: 1.0
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 21 Feb 2019 14:29:39 +0530
Message-ID: <CABe79T66daJOditCZ-6ENKW2ugbpDUUfjn1CMHCcDtb3=HiiOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Please help to review this patch series.
Thank you.

Regards,
Srinath.
On Fri, Jan 25, 2019 at 3:44 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Few SOCs have limitation that their PCIe host can't allow few inbound
> address ranges. Allowed inbound address ranges are listed in dma-ranges
> DT property and this address ranges are required to do IOVA mapping.
> Remaining address ranges have to be reserved in IOVA mapping.
>
> PCIe Host driver of those SOCs has to list all address ranges which have
> to reserve their IOVA address into PCIe host bridge resource entry list.
> IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
>
> This patch set is based on Linux-5.0-rc2.
>
> Changes from v2:
>   - Patch set rebased to Linux-5.0-rc2
>
> Changes from v1:
>   - Addressed Oza review comments.
>
> Srinath Mannam (3):
>   PCI: Add dma-resv window list
>   iommu/dma: Reserve IOVA for PCI host reserve address list
>   PCI: iproc: Add dma reserve resources to host
>
>  drivers/iommu/dma-iommu.c           |  8 ++++++
>  drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
>  drivers/pci/probe.c                 |  3 +++
>  include/linux/pci.h                 |  1 +
>  4 files changed, 62 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>

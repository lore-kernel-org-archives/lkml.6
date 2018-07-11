Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F00A2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9Q45N1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F00A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbeGKOpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:45:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35085 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388636AbeGKOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:45:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so2852985wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f06fbMsQugC2RwJhH1+A1CHNrcU97j0nq6PJpc50ctI=;
        b=D9Q45N1dAh0ju4n0uc+3d2gmRRYXUBkypnUz2rUNvh2e9EBQmEMha+FRNzlxA92yp5
         fOJP4MTWFiKWitp2MU8B65wIF5pXENqE68qVA/tGmwE9LvsmMhM6OFx3MCUkeVMFaT+r
         qAKjKzhxGH0B17DMskK4LwZ7kPCD+VAh3KTeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f06fbMsQugC2RwJhH1+A1CHNrcU97j0nq6PJpc50ctI=;
        b=qIkCawlZcD7MNVddppYSzzgSiwbu0aPEdzqmbigQHyhNn8Ow63tlaNfFiwXRlqtKyE
         YstA8k+i2SxsqtdMyG3ZdBJsCvmXlSPdUUR9XJBFW0Lj3AVw95x7dxPEwoaMfwwuJFQw
         hZKqpKrh65PYLisSqgk8Lp5nniFfDBawfqDYpQQi+UCixQ8oSexBfwVhCN73GbJ1j7WJ
         kpNN2S9R1tauRZUxJn+MYB8szwpc52AisknZcO+7rdg14HlBtforlRhQD/x2TymIMV7b
         PzKWz2m5A9XkRboRbIzeIZFiGaCZix4U5MiBRKyyL/5arqOQSUIkTcbWNRGaiU6OrC1S
         ytjA==
X-Gm-Message-State: AOUpUlEBc/L8hOMkMHQgSdSHVxuTRWzRRua+46S+XUSd6RSKUoEHcb51
        sBq29f7CouyXxZIVfgol27/OklInFE44IrW4o6uoEvZ2
X-Google-Smtp-Source: AAOMgpeu2o/9XfC8UDxt01lGEYFbrm9apIUmRDGcwggPFM50vXM9j66xP8hrh3dC2gJ6cmlNLNB7jzZi09dELhaOuU0=
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr10923486wmf.114.1531320042107;
 Wed, 11 Jul 2018 07:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531239284.git.robin.murphy@arm.com>
In-Reply-To: <cover.1531239284.git.robin.murphy@arm.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 11 Jul 2018 08:40:30 -0600
Message-ID: <CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        joro@8bytes.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:43 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Whilst the common firmware code invoked by dma_configure() initialises
> devices' DMA masks according to limitations described by the respective
> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
> the dma_set_mask() API leads to that information getting lost when
> well-behaved drivers probe and set a 64-bit mask, since in general
> there's no way to tell the difference between a firmware-described mask
> (which should be respected) and whatever default may have come from the
> bus code (which should be replaced outright). This can break DMA on
> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
> only knows its maximum supported address size, not how many of those
> address bits might actually be wired up between any of its input
> interfaces and the associated DMA master devices. Similarly, some PCIe
> root complexes only have a 32-bit native interface on their host bridge,
> which leads to the same DMA-address-truncation problem in systems with a
> larger physical memory map and RAM above 4GB (e.g. [2]).
>
> These patches attempt to deal with this in the simplest way possible by
> generalising the specific quirk for 32-bit bridges into an arbitrary
> mask which can then also be plumbed into the firmware code. In the
> interest of being minimally invasive, I've only included a point fix
> for the IOMMU issue as seen on arm64 - there may be further tweaks
> needed in DMA ops to catch all possible incarnations of this problem,
> but this initial RFC is mostly about the impact beyond the dma-mapping
> subsystem itself.

Couldn't you set and use the device's parent's dma_mask instead. At
least for DT, we should always have a parent device representing the
bus. That would avoid further bloating of struct device.

Rob

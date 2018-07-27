Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D2920897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEijCbEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D2920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeG0Sgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbeG0Sgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:36:32 -0400
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com [209.85.216.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6798208C2;
        Fri, 27 Jul 2018 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532711623;
        bh=zhXGrDnLdW2Vbz3oRvzxOQFoPJOgxEVZ0Y85dL4QBxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pEijCbECTmq/QBB6x339LjR6qdPY5LBbOypUPZnpUHba84lHFvztEhx1dmIOPiBut
         K3H6g8Ae1UAX8BG5Kh882HxJTwnG7rBsqx51iCOX/lQHXkon2Kieae7qhV3RZBaxNj
         MoCrVVp/SOI25poeedqjaY/CuRECPMVJ4FGo9Cgk=
Received: by mail-qt0-f175.google.com with SMTP id c15-v6so5789062qtp.0;
        Fri, 27 Jul 2018 10:13:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlFRzTAFHOVRF/fuxt8+kv7oYfY4ie1c77ozBToSRuAZVQlCKleO
        Li3HGU7VGpEQZ2IWQTTq8Oa0ebBfQrNxwzQpvg==
X-Google-Smtp-Source: AAOMgpc2+VbCPGpwIoxH7hGfbuqvWOEIvX/ElfEMr2fLBWjiJPvUJH7V71MgEsKOw3RZFnFA6UiUooRV83xHzBEEUX0=
X-Received: by 2002:a0c:f411:: with SMTP id h17-v6mr6489490qvl.25.1532711622874;
 Fri, 27 Jul 2018 10:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180726231624.21084-1-digetx@gmail.com> <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
 <20180727090328.GH28088@arm.com> <4164951.xGHfcFJ9uZ@dimapc> <20180727142000.76zgficpta473snl@8bytes.org>
In-Reply-To: <20180727142000.76zgficpta473snl@8bytes.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Jul 2018 11:13:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
Message-ID: <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Frank Rowand <frowand.list@gmail.com>, bskeggs@redhat.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, kwizart@gmail.com,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:20 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Fri, Jul 27, 2018 at 05:10:22PM +0300, Dmitry Osipenko wrote:
> > I'm not sure what you guys are meaning by the "firmware", could you elaborate
> > please? Do you mean the Open Firmware and hence the devicetree or what?
>
> Yes, I think the best way to request this is using a device-tree
> property. Letting the device driver request it is definitly a bad idea.

I don't follow why we need a property rather than being implied by the
device's (the GPU) compatible string.

Rob

Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD88DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7947F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFOoUBXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7947F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbeG0VZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:25:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51190 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389326AbeG0VZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:25:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6444253wmc.0;
        Fri, 27 Jul 2018 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqkUGJipEj+KbNRGey4YQivwr9wqaIsKHnCwW0FR1KI=;
        b=TFOoUBXQjKLJ2s74MzWyd6ctAVDxFj1v8bxH8zh7xZtGeLtnWr7zjh2jUQNkKXmhtO
         U5dfIG2DKB9B0Cu2fckJmtbEVS1PeTPrx2QrnDjxu+i8/R2pMWcSddpyG9+GXLXuQUdv
         FVWyqItEv/WAIhL4xsQTJUoGOQoBigSDqssYJq9Nso+N36igki/2ajJ5FnXvnIBHlHfX
         Oh9qI+GJ3t9cfo/M/96k3DXpS3crkwRxIRjyp4saE1uqpSm9YdXlkDpiAVak6LZ+eACs
         lzvZrQnE3TIBBSjLkglflk1jcPPJSm55EESoOnP+mdnXe7LSmRd4uXsIUonrt87rSxLy
         I5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqkUGJipEj+KbNRGey4YQivwr9wqaIsKHnCwW0FR1KI=;
        b=ssJofaX7RTRoVjl4rRkyU1R858TCjIpbkj7vRicJcD15vDvaUphQ08XP7Y/dhTHm43
         sKosrLsbTESW9+kEEU+pSrupXQQc3uB6FdIbXKbncxUF2JHp3yECdaUu09Nzy/NtnJB8
         W/Jo/h6iNdnt+/r8AAPCmaMz3E5dPLSDTWot/5LSF034MaIXIGa1yVswQ7roZYM0k9t/
         8yC7LGPIBSPHgOhlLxCyAUbdXcv//GEOPir5z6vhJZvTJHQCza34iIEBMKQf4Vgk8fzj
         MZJra1v5NWemi/bsdqkat7SXVOiCHyP32AL1Tkhaf4raTCm102fCev+krbUaeFOMII6d
         R4fg==
X-Gm-Message-State: AOUpUlFJiBS1ABAT6PUdQOHYFo4s/0yMoYElIauTkXDVnJdY5R2sQ5g8
        d6XiWOrBOJcZix7QeoxBKvA=
X-Google-Smtp-Source: AAOMgpcPYNj0dkqP8BKIIcnodQuPLwWjGIEx8+rj57i0CkwDtf+hXIJ/FtdAOBKysD1gzdnPl0xfjA==
X-Received: by 2002:a1c:d946:: with SMTP id q67-v6mr5478795wmg.156.1532721723995;
        Fri, 27 Jul 2018 13:02:03 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id r16-v6sm8051056wru.59.2018.07.27.13.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 13:02:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 23:02:01 +0300
Message-ID: <4850389.K9ByBxYttl@dimapc>
In-Reply-To: <20180727183134.GD6738@8bytes.org>
References: <20180726231624.21084-1-digetx@gmail.com> <CAL_JsqJCE+8hZ-xCajUaW4ScY8VmaZ3nN4U-_AKJL+063sLBpw@mail.gmail.com> <20180727183134.GD6738@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 July 2018 21:31:34 MSK Joerg Roedel wrote:
> On Fri, Jul 27, 2018 at 11:13:31AM -0600, Rob Herring wrote:
> > I don't follow why we need a property rather than being implied by the
> > device's (the GPU) compatible string.
> 
> There might be devices where either setup works, with or without IOMMU
> translation, and the firmware can set the property depending on whether
> the user wants more performance or more security.
> 
> If we have a whitelist in the kernel this gets more complicated, we
> probably need additional kernel-parameters to overwrite those whitelist
> entries. Having a property in the device-tree seems to be a better way
> here, imho.

IIUC, device-tree should be considered to be "written in stone" for a consumer 
device and hence firmware property isn't something that could be easily 
changed. The kernel-parameter will be much more universal. Anyway the global 
whitelisting should be a different topic for discussion, right now we need a 
kind of private whitelisting that is internal to kernel.




Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E78C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2E421104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAl9HDqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2E421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeK3HEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:04:08 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37612 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeK3HEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:04:07 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so1291644ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=B+5v7MZmndls8FH9IgUqchqONn8gu0QAGn7ScGzwnfI=;
        b=cAl9HDqt/a2UGXsd52CB3SEhbmXPebX5YfSfLlDbgLT93xroeJ4LMxIwYPpOiXMMpC
         65aO+Q4GoIEvqDI5kcbL3ERK7oIR32ONiEWw9SC1ElKfOPcovxy+DQKiGnjlwqjKN2Qe
         ZWdoIsryTj5qPPkptbg66v4ubaK7pInypnjyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=B+5v7MZmndls8FH9IgUqchqONn8gu0QAGn7ScGzwnfI=;
        b=reDdEHtxI4pUK1D0K0TNO75U0Gyjt2Q1le6fIvYasAXsCECfAUh7tJhvwRKOdgpJyz
         39dOngoxDD9aud+tvvGVhs1BrWxkphrbg9xdSMIUmn0vVSybvPkD+4G4o8Ym/dJoKoSR
         3va1OOBXoKOTbak0n7+qwZRWQQDz7jkbwhFdyOS5PRrbBmeTMMVmFeiVOfPXso49+qNS
         ue3lC1v7+/XLeLuDdtNE/po/5cRRK+8i0QQefyxGZI8rO+jO2si3Y0RBjKQWlSFUHJh7
         8QaJGreCkPOnx1OQgP/2PdTbnYlq/B00bSH4qPp7+t624l1hfMAR6X31hzam5LDss5dR
         E54g==
X-Gm-Message-State: AA+aEWYl/0AZJRZ2BgIF75BNZNoAFaXtYcqpastIT12mZ0r+EUM3j/8w
        jpcvYrJ107b1bux1xIHdJVnGmXS9Y5I=
X-Google-Smtp-Source: AFSGD/WhJV5kmvtnF5Rx40FRqVLZ21jMHW5pw4Sa8y18UCtCjFaTElzcKpj73/pU0U/R8myJ+RaNHA==
X-Received: by 2002:a81:b54f:: with SMTP id c15mr2876191ywk.274.1543521451979;
        Thu, 29 Nov 2018 11:57:31 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id k80sm798451ywe.61.2018.11.29.11.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:57:30 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id u103-v6so1264355ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:57:30 -0800 (PST)
X-Received: by 2002:a25:9a46:: with SMTP id r6-v6mr2717863ybo.303.1543521450159;
 Thu, 29 Nov 2018 11:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org>
 <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
 <CAF6AEGu65Vvzpy6K7eF+Kk4YdYBPEKFX5ct8GxG0pw-KNwM5eA@mail.gmail.com>
 <20181129155418.GB26537@lst.de> <CAF6AEGufdp5jRtUZ_+VRQg3ZXH36hNHvbWZQeJDArp8N5SZ3Lg@mail.gmail.com>
 <20181129194029.GE17663@jcrouse-lnx.qualcomm.com>
In-Reply-To: <20181129194029.GE17663@jcrouse-lnx.qualcomm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 29 Nov 2018 11:57:16 -0800
X-Gmail-Original-Message-ID: <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
Message-ID: <CAAFQd5D139pNx9aEpO8745R4kfVYCBDyqyJNR_HDDXvKt7NZjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
To:     Rob Clark <robdclark@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:40 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> On Thu, Nov 29, 2018 at 01:48:15PM -0500, Rob Clark wrote:
> > On Thu, Nov 29, 2018 at 10:54 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 09:42:50AM -0500, Rob Clark wrote:
> > > > Maybe the thing we need to do is just implement a blacklist of
> > > > compatible strings for devices which should skip the automatic
> > > > iommu/dma hookup.  Maybe a bit ugly, but it would also solve a problem
> > > > preventing us from enabling per-process pagetables for a5xx (where we
> > > > need to control the domain/context-bank that is allocated by the dma
> > > > api).
> > >
> > > You can detach from the dma map attachment using arm_iommu_detach_device,
> > > which a few drm drivers do, but I don't think this is the problem.
> >
> > I think even with detach, we wouldn't end up with the context-bank
> > that the gpu firmware was hard-coded to expect, and so it would
> > overwrite the incorrect page table address register.  (I could be
> > mis-remembering that, Jordan spent more time looking at that.  But it
> > was something along those lines.)
>
> Right - basically the DMA domain steals context bank 0 and the GPU is hard coded
> to use that context bank for pagetable switching.
>
> I believe the Tegra guys also had a similar problem with a hard coded context
> bank.

Wait, if we detach the GPU/display struct device from the default
domain and attach it to a newly allocated domain, wouldn't the newly
allocated domain use the context bank we need? Note that we're already
doing that, except that we're doing it behind the back of the DMA
mapping subsystem, so that it keeps using the IOMMU version of the DMA
ops for the device and doing any mapping operations on the default
domain. If we ask the DMA mapping to detach, wouldn't it essentially
solve the problem?

Best regards,
Tomasz

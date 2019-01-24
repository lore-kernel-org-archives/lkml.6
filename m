Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19739C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6582184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkPXeLhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfAXMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:32:28 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40893 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfAXMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:32:27 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so4094236ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F3VCMZYQHk+dES8GD4GKOvmgry3BxujfQ36g2qotYKM=;
        b=IkPXeLhb1v9yYKDcPuLTMPUQj9ccjp3XoBOC2aHGBCMCfYCC0dV8d86WGbJdw5cd+1
         E9lplTFs8WOUx58H8eY27S56/H0ij+Tvs29ymM8MDuYh7ayaZcEF0J//J67I4gNuK848
         IHNOmRCQU3kIRZepoSy7DiZDrh55MyfMtNSJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F3VCMZYQHk+dES8GD4GKOvmgry3BxujfQ36g2qotYKM=;
        b=NMWQ1veARbwgeVx1l9BGgcEA7i1NszO7009Y9qFUxD3HKuml5Z6b5QpRHGbEBx0R4O
         dqnTS24kDo3ARLwko9EZegOycutfcVgw3snCmLFnaHlLpGeQqczDkpM9/qkHIsHGsnI+
         nUodLIE4Tj68bf68GxVmd/0yz+VNbVmzHyA0EIpnr41pS2KjAaROH+4yKtbCG1YIn8UH
         kJWNIvXzRsoSVV/JGu5dUF/rVsrJFoz8PrMe2P38206E6d/wUruM8jNtiHkcFIprg0YB
         wYbcYayu48aWtQ/7oxySBA+PkS4k+PgDVZPcwK9SwgB6P3JmAcfEubfk0iOQL5Gni/rk
         c8SA==
X-Gm-Message-State: AJcUukcSQgQ1t+LMoyf1d7brFrm75sl25FHHhVRkSIwBRpkQlLU32EIP
        yPiuZHSwSgMo+zqiajYZejmriozZaSw1D9uU2Ll5CA==
X-Google-Smtp-Source: ALg8bN4wjFbIakhtj0hnxuyWDDz7O+TaM/72FWY+jIkiG/4A0F/DjIMahcH8mdOOmVBlMssD84C5+NWBZsm2sEGLI5c=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr1298530itk.71.1548333146518;
 Thu, 24 Jan 2019 04:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org> <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
In-Reply-To: <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Jan 2019 13:32:15 +0100
Message-ID: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Daenzer, Michel" <Michel.Daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > The DRM driver stack is designed to work with cache coherent devices
> > only, but permits an optimization to be enabled in some cases, where
> > for some buffers, both the CPU and the GPU use uncached mappings,
> > removing the need for DMA snooping and allocation in the CPU caches.
> >
> > The use of uncached GPU mappings relies on the correct implementation
> > of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
> > will use cached mappings nonetheless. On x86 platforms, this does not
> > seem to matter, as uncached CPU mappings will snoop the caches in any
> > case. However, on ARM and arm64, enabling this optimization on a
> > platform where NoSnoop is ignored results in loss of coherency, which
> > breaks correct operation of the device. Since we have no way of
> > detecting whether NoSnoop works or not, just disable this
> > optimization entirely for ARM and arm64.
> >
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: David Zhou <David1.Zhou@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > Cc: Michel Daenzer <michel.daenzer@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> The subject line should probably read "disable uncached...".
>

Ugh, of course ...

> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.
>

Thanks.

Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B8C2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED9B20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aVYYgK+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfAUPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:07:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAUPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2j5QAMnWZYAHmPB6B/PLFycemJfuLetLmqnb8Ek7zWQ=; b=aVYYgK+HBuEyNiRsC+xcgmMGG
        BrXscf3Dz0SZfcuB6oOpJWcJmSYnuBHFr79JIiV4zOjYcLMSzLb6fuyNcFPRKJjlFAJIKmQOJrGSl
        O0f/V84aHAqhGSvfYeaP+MC0tlEqUajjWXCV2qp/FTXI97jI/NWM0NIxR+Qywagl568xIzb1e1YkU
        uIilgow675PlyDGRpv1MwbLPAXNPusKtP1fJ8J55IkFaXlZyJGlBs4gKretnrvW6Zezlqum5Cr/ya
        IHzum9uV51KRS2hqSDS5Pr5q1po6+w5iHUUylPvBRXC/eGGw0wIEKIulX+5BYDKtUvkAqvbmL4Msm
        /7kd3RPsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glbAk-00015z-Kc; Mon, 21 Jan 2019 15:07:34 +0000
Date:   Mon, 21 Jan 2019 07:07:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Michel Daenzer <michel.daenzer@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Message-ID: <20190121150734.GA30582@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/dma-noncoherent.h>

This header is not for usage in device drivers, but purely for
dma-mapping implementations!

> +static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
>  {
> +	if (IS_ENABLED(CONFIG_PPC))
> +		return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
> +	else if (IS_ENABLED(CONFIG_MIPS))
> +		return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
> +	else if (IS_ENABLED(CONFIG_X86))
> +		return true;
> +
> +	return !dev_is_dma_coherent(ddev->dev);

And even if something like this was valid to do, it would have to be
a core function with an arch hook, and not hidden in a random driver.

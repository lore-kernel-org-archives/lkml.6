Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AF820841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOLIxHIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AF820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeGaTUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:20:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeGaTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:20:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so6455810pfo.4;
        Tue, 31 Jul 2018 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWu0hHJ60IJFxovi5QHYRpuAWtEB4yJPWtSw9el28Lc=;
        b=UOLIxHIslXEp5sZTABPIEC/oLs9sdH/IMWsEmrDV5//q0/xdRq1M8/OQre3YAdKRUe
         FFnIN0Ed7J4Wta9VaBTTiRFtB7iD3gap+Ce8DS9jJkw+ZPzUfWHHc0CKfvNQUlGL3Iwb
         8eJ8RY63kEjyr22qjeMAOb8rUkQwxUsLD3LcGS5Pxk1oEgDUlhHmB/raTq002jZAoXrI
         utbmjmbGNDgvrPTZtSpFWWMwAOVDN0d6xhzaTPzz8/FbOhRaWdj2r0R+ipu3THthgmsP
         iqOjMHOfbsiuZY0docjX5zIsUgCvGPw4ZJ5L+GpA6G29c19LhP7+EA/XkFqwfBVrHQtD
         4jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWu0hHJ60IJFxovi5QHYRpuAWtEB4yJPWtSw9el28Lc=;
        b=HwDeEc+7yr/X+uD/XltyjbL4cjI1WtB3WmGeeRkMA4NdiMS/dV/D/VtNUiP9+MyK3w
         oZ6wW+g0jNA7KKJPARAAjgEznhEv5q5ZH6IvpeXyTCFx3Kraj3FX3vXC+H9hD+vdRxOm
         aZiy/z8Xf5cyXwwgvATeZOglDc0DPwk8NJG417CBlRAoOAF9iEY1o+40OnSC/f5S0XJE
         eIGtPFjqHdv3iecYspH6tC/KyvZVa/2TgwIYtZT2UdFwSEBVohIsoP9SDRIv6Fpwhz7f
         eJopk3KQLeKJxY1C94cPyk/kDLUNk6O/yG+C+9jPGRLjYWrg5xayEgFkToDsK51cKxRj
         hwZA==
X-Gm-Message-State: AOUpUlHBqLG1s9K0R1mw2OCH88Wc4APaiNLy7oJCfkkJ7YpbfKtE4CIp
        UJlS9wXntx4bhP63yvOFeuKiWjfP
X-Google-Smtp-Source: AAOMgpfQWBAZlkuzLHhO6+la5wwBbNV+dBB3y9QBwdnrdDrubDx6k8Vu1R/qJgEKBBmtaMIXGA40Vg==
X-Received: by 2002:a62:5a01:: with SMTP id o1-v6mr23454899pfb.0.1533058742289;
        Tue, 31 Jul 2018 10:39:02 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u2-v6sm22310811pfn.59.2018.07.31.10.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 10:39:01 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:38:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Stefan Agner <stefan@agner.ch>, Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
 coherent DMA mask)
Message-ID: <20180731173859.GA17007@roeck-us.net>
References: <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
 <20180727140448.GA29001@lst.de>
 <20180728165820.GA5731@roeck-us.net>
 <45f7fc82-fb9c-e666-4ada-c5338d2c1c96@arm.com>
 <39fa11ce4b7dd151d98868f375baf818@agner.ch>
 <0e893142-a5db-d119-6eb3-f849db6b5d04@arm.com>
 <f67628ad-4cae-96cd-d0c4-3b2f7d12a822@roeck-us.net>
 <4ce17098-850f-3bb0-b977-8d7932e74e06@arm.com>
 <20180731154353.GA29601@roeck-us.net>
 <10c2ca4d-d587-2705-2802-b6df3dc72fd4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c2ca4d-d587-2705-2802-b6df3dc72fd4@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:58:41PM +0100, Robin Murphy wrote:
> On 31/07/18 16:43, Guenter Roeck wrote:
> >On Tue, Jul 31, 2018 at 03:09:34PM +0100, Robin Murphy wrote:
> >>>Please note that sparc images still generate the warning (next-20180731).
> >>
> >>Ugh, OK, any ideas what sparc does to create these platform devices that
> >>isn't of_platform_device_create_pdata() and has somehow grown an implicit
> >>dependency on of_dma_configure() since 4.12? I'm looking, but nothing jumps
> >>out...
> >>
> >
> >I suspect it might be of_device_register(), called from
> >	arch/sparc/kernel/of_device_64.c:scan_one_device()
> >	arch/sparc/kernel/of_device_32.c:scan_one_device()
> 
> Right, that's as far as I got as well, so I'm struggling to see how these
> things ever got DMA masks set before the of_dma_configure() call moved out
> of of_platform_device_create_pdata(), or why it wasn't a problem prior to
> the generic dma_ops rework if they didn't :/
> 
Ah, ok. No idea, sorry. All I know is that the messages were first seen
with next-20180727.

Guenter

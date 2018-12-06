Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3823DC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F212020850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544088337;
	bh=yquEor6AGUb2p6/EUGQqZ2H6Yefy6nm54eUNuIcLIIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ATvzImZeRy3flyuSEf1cnr34ujUypllq4wbEAFq1ORTW7W/NXi6MLmwHT2JM+dPvs
	 q+L1TwPlbI3fQecidcx9JzBhkRZnwjOJ+62zBhdBIkPMgT2KpEKppslQg3KYuwtsJG
	 d4IBdopSlkVFotWr5iOwH3o2IvbC+GZQ2A3eAD3Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F212020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeLFJZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbeLFJZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:25:35 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BEC214DA;
        Thu,  6 Dec 2018 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544088334;
        bh=yquEor6AGUb2p6/EUGQqZ2H6Yefy6nm54eUNuIcLIIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cu0YVRdJzQkS8WiMUarKxuv7Fp/YlWIYIJ5STrBneZorU02jd3FYwbolkrsWPemzi
         nabEVtvkLmlJolSFOpQtndcPoi4r3eeN5jGQU+Xlv76LVejAq3pJ/cd0siiiOzzpe/
         yZ4OYxAYWZ3cmdCprl+hPd74QsuSFZLVeSjSrB1c=
Received: by mail-lj1-f176.google.com with SMTP id s5-v6so21000375ljd.12;
        Thu, 06 Dec 2018 01:25:33 -0800 (PST)
X-Gm-Message-State: AA+aEWbFq2EM2F7Ppx3p9Mo3/4eCEZoSWd6kSgLe28u2wiMMOceL35rj
        ploFpPFyVCaz0lLuzaovtk1XgppXmY7krexIOnI=
X-Google-Smtp-Source: AFSGD/UJermQifqMj7VVuugimzzXNWBaWyDncc4zMM5FNRdd62S1tJxt103d9JZBn4tiCRuMMVvTlQa/StV+8km8AFQ=
X-Received: by 2002:a2e:c41:: with SMTP id o1-v6mr2042505ljd.152.1544088332104;
 Thu, 06 Dec 2018 01:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20181206013054.GI6707@atomide.com>
In-Reply-To: <20181206013054.GI6707@atomide.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Dec 2018 10:25:20 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Message-ID: <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
Subject: Re: dmapool regression in next
To:     tony@atomide.com
Cc:     tonyb@cybernetics.com, akpm@linux-foundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        andy.shevchenko@gmail.com, hch@lst.de, john.garry@huawei.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
> on at least omap4 pandaboard, see below.
>
> Any ideas what might be going wrong?
>
> Regards,
>
> Tony
>
> 8< ---------------------
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
> ...

I see it as well on all my Exynos boards, since yesterday's next. In
my case it is the USB EHCI driver:
exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
vaddr)/0xb8844180
Full log here:
https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0

Best regards,
Krzysztof

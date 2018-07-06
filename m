Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5509C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3520896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRAo2+qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF3520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeGFGAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932684AbeGFGAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:00:45 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3572E21468;
        Fri,  6 Jul 2018 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530856844;
        bh=K3k5KRAN80Th2LaMV0QfGJGKj0muzPc/rm+5xxmXMv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRAo2+qNbtXJ8koJwet5bV1avI6unUBPD263YJ5xK8tUgQYbacXNGYOH9KnGS+dfW
         /r8GRSL33d+nN37kYGuMiHATzG4V6O8DtNcJjclLLDqx8SNoo7FqQq82u2Hi8bT48/
         rBEVyAw0Bee/033Fz0F4/Evb1SnStW9fQcMFprLQ=
Date:   Fri, 6 Jul 2018 11:30:36 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Message-ID: <20180706060036.GR22377@vkoul-mobl>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
 <20180704070033.GA22377@vkoul-mobl>
 <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-18, 13:38, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 10:00 AM, Vinod <vkoul@kernel.org> wrote:
> > Hi Marek,
> >
> > On 02-07-18, 15:08, Marek Szyprowski wrote:
> >> 'cmd_pause' DMA channel capability means that respective DMA engine
> >> supports both pausing and resuming given DMA channel. However, in some
> >> cases it is important to know if DMA channel can be paused without the
> >> need to resume it. This is a typical requirement for proper residue
> >> reading on transfer timeout in UART drivers. There are also some DMA
> >> engines with limited hardware, which doesn't really support resuming.
> >
> > Am curious given that your hardware does not support resume, what was motivation
> > for adding pause?
> >
> >> Reporting pause and resume capabilities separately allows UART drivers to
> >> properly check for the really required capabilities and operate in DMA
> >> mode also in systems with limited DMA hardware. On the other hand drivers,
> >> which rely on full channel suspend/resume support, should now check for
> >> both 'pause' and 'resume' features.
> >>
> >> Existing clients of dma_get_slave_caps() have been checked and the only
> >> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> >> driver, which has been updated to check the newly added capability.
> >> Existing 'cmd_pause' now only indicates that DMA engine support pausing
> >> given DMA channel.
> >
> > The change looks fine to me. I was hoping that serial would also check
> > this..
> 
> AFAIU serial does not need to resume.

I meant the serial should check for Pause capability..

-- 
~Vinod

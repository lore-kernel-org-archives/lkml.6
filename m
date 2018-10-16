Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B96C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28E321477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Jta/Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28E321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJQACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJQACk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:02:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F8B2098A;
        Tue, 16 Oct 2018 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539706291;
        bh=QzdrCts8yfcaSecW20siOOETay6cRIHLj4hGUToh5LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7Jta/OrTIBFRSTD8epenzteNoaETBUJg1+fMH5J840AoBFkNW0rCV9AiXLBM/Xra
         d/E0nhd+a7/O9/eOzn3BC2KgiERCZDhX6rHHYOgP4dFHpbvJ7pzQ2bdxjvN+iGRP7w
         kqYewOvqoX31jDkbzVUQyqxhBYq2ovOgFloF5HPQ=
Date:   Tue, 16 Oct 2018 18:11:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/7] NULL pointer deref fix for stm32-dma
Message-ID: <20181016161129.GB17066@kroah.com>
References: <20181009054752.145978-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009054752.145978-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:47:45PM -0700, Joel Fernandes (Google) wrote:
> Hi Greg,
> 
> While looking at android-4.14, I found a NULL pointer deref with
> stm32-dma driver using Coccicheck errors. I found that upstream had a
> bunch of patches on stm32-dma that have fixed this and other issues, I
> applied these patches cleanly onto Android 4.14. I believe these should
> goto stable and flow into Android 4.14 from there, but I haven't tested
> this since I have no hardware to do so.
> 
> Atleast I can say that the coccicheck error below goes away when running:
> make coccicheck MODE=report
> ./drivers/dma/stm32-dma.c:567:18-24: ERROR: chan -> desc is NULL but dereferenced.
> 
> Anyway, please consider this series for 4.14 stable, I have CC'd the
> author and others, thanks.
> 
> Pierre Yves MORDRET (7):
>   dmaengine: stm32-dma: threshold manages with bitfield feature
>   dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
>   dmaengine: stm32-dma: fix typo and reported checkpatch warnings
>   dmaengine: stm32-dma: Improve memory burst management
>   dmaengine: stm32-dma: fix DMA IRQ status handling
>   dmaengine: stm32-dma: fix max items per transfer
>   dmaengine: stm32-dma: properly mask irq bits
> 
>  drivers/dma/stm32-dma.c | 287 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 240 insertions(+), 47 deletions(-)


I need git commit ids for all of these for what the patch in mainline
is.

Can you fix that up and resend them?

thanks,

greg k-h

Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A189D218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549100236;
	bh=UsFfb+3BH4+0XTBnl8zNtli9MDcvDqpzNijtUOXfqAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jbOcie2YC03Hb5HFRHnCGPkhva3gEXIj3ZVqTO5TgXKxRsWbt39zE4lfYk7jfJqDj
	 g1CI/jlRHk8oWsYp3FNhFP2YghOt5YWmFYAP4UEjCKLtSb3jB50trSoiNFBySaOxXg
	 EjfvuS/MqTmrwLpC7pGRkC9DZsh6pICLA642PLX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfBBJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:37:14 -0500
Received: from localhost (unknown [125.16.100.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5373720870;
        Sat,  2 Feb 2019 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549100234;
        bh=UsFfb+3BH4+0XTBnl8zNtli9MDcvDqpzNijtUOXfqAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIKBiQJCwY+hT99SMRtJJuZkWBqs3MQ8Gyhc58wY9iCDp6GflyFa9fQmCdt6OEJ+a
         FFHUGudbzzF911Oxf0tS4U7zGwHGFZYuS5hvhxcyAuhVnT1ioahYZd2bXcKGIW2ef3
         lZxQFtRLU9/RaA3Oh5ShtbCB40+xVaadoK2BTlUk=
Date:   Sat, 2 Feb 2019 15:05:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: DMA Engine Documentation: TX Descriptor and Submission
Message-ID: <20190202093226.GC4296@vkoul-mobl>
References: <1655406.8MLMLfCWyH@pcbe13614>
 <20190201041750.GM4635@vkoul-mobl>
 <77C59695-001C-46B3-9C41-C4C7A763D001@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77C59695-001C-46B3-9C41-C4C7A763D001@cern.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-19, 09:59, Federico Vaga wrote:
> 
> 
> On February 1, 2019 4:17:50 AM UTC, Vinod Koul <vkoul@kernel.org> wrote:
> >On 28-01-19, 09:47, Federico Vaga wrote:
> >> Hi,
> >> 
> >> I have a new question concerning documentation.
> >> 
> >>
> >https://www.kernel.org/doc/html/latest/driver-api/dmaengine/client.html
> >> 
> >> >From this document it is not really clear, at least to me, if
> >clients can 
> >> consider valid the `struct dma_async_tx_descriptor` after submission
> >to the 
> >> DMA engine.
> >
> >Nope they can't and should not touch the descriptor after submission.
> >The client get cookie and that is supposed to be used
> 
> Good, thanks
> 
> 
> >> 
> >> Clients get a TX descriptor from a DMA engine using things like 
> >> `dmaengine_prep_*`. These calls - may - allocate new descriptors and
> >return 
> >> them to the caller; this may include other structures which are not
> >visible to 
> >> clients. So, if my understanding is correct, this means that it's the
> >DMA 
> >> engine that, on TX completion, releases any TX descriptor allocated
> >by 
> >> `dmaengine_prep_*`. This implies that the pointer that the client is
> >using 
> >> must be considered invalid right after `dmaengine_submit()`.
> >> If what I understood by reading the documentation and the code is
> >correct, 
> >> then I think that this should be mentioned in the Documentation.
> >> If I'm wrong, please tell me where :)
> >
> >And what exactly are you trying to do here..?
> 

Please wrap your replies within 80chars

> What if I answer: "the right thing"? Joking. I just expressed my
> understanding of something which is not documented properly (my
> opinion). I wanted to be sure that the logic, the reasons behind are
> the ones that I understood. I will propose a patch to the
> documentation, unless you want to do it.  -- Inviato dal mio
> dispositivo Android con K-9 Mail. Perdonate la brevità.

Sure please feel free to send a patch :)

Mostly people ask these questions based on a driver they are working
off, and it makes sense to fix the assumptions by asking what they are
trying to achieve...

-- 
~Vinod

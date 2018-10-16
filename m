Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F972148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dZ6W55be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F972148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJQHmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:42:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41871 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeJQHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:42:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so11751906plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+EflfE4YgAWJlhl7tu6DdVfYqYVIqQFBVpO0h8yn7rc=;
        b=dZ6W55beiBZv18z7snb/8HaQXlusDeygkew33lGBelYRe+OnDLLIuxAwgyM6DIGw39
         YkLeEn9My07fnZylnnyX3UwIqfZ5d0BLXlTbzjTXrwYiK4MGnR7+c4YkvdTWnkY80QCV
         3XdCyuax/iJGLXKsRUt8puxLM1dpjnCoMw7/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+EflfE4YgAWJlhl7tu6DdVfYqYVIqQFBVpO0h8yn7rc=;
        b=kJbT55yDVLVWwxcv4sNsMgnXeGoa9229ckRMfxgRE5kHiBaMXW9VDWrcYPv33vXN50
         i3bN6g/fZCp73XcNZ6kDkZH/OFKizX4nUNairVkCnKOLdCtzPdYeIKzUbtUmVmQwT56S
         AwguXeIcjGIDvWfkEOzUzmDR+EQr9QrkkDUF94nRa133STe82FfeijaFKzSpg1Ua9nge
         6UxkW0wREuqpNBfxQIwUbn5/wFxvq2+0bH084FLXXbpbA78nAqKnmLJiAsa8NBzaSH/A
         oCTWotQh7rdowEoCVWKkrRL5IGM/pAWWV0LfH03vFSZfcaJ/vvPpyVxsIdKNr61rC+Vb
         lGEA==
X-Gm-Message-State: ABuFfoiIuyY3ttKRoBZckahSrnF25P4ZPFQ/s8OZgbCzE1UVORk6mSeu
        TeSUDfC7qi9gbS8V8NEsBhec0Q==
X-Google-Smtp-Source: ACcGV63Xnv8omeYNeHPeK+BgaSlL3f5R3VQZT2uFsCmSSw3hpmLiVKDy6c6tOcJ2TIFDcujBLBtuog==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9-v6mr23654255plz.210.1539733772992;
        Tue, 16 Oct 2018 16:49:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22681928pfi.185.2018.10.16.16.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:49:31 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:49:30 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/7] NULL pointer deref fix for stm32-dma
Message-ID: <20181016234930.GB140578@joelaf.mtv.corp.google.com>
References: <20181009054752.145978-1-joel@joelfernandes.org>
 <20181016161129.GB17066@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016161129.GB17066@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:11:29PM +0200, Greg KH wrote:
> On Mon, Oct 08, 2018 at 10:47:45PM -0700, Joel Fernandes (Google) wrote:
> > Hi Greg,
> > 
> > While looking at android-4.14, I found a NULL pointer deref with
> > stm32-dma driver using Coccicheck errors. I found that upstream had a
> > bunch of patches on stm32-dma that have fixed this and other issues, I
> > applied these patches cleanly onto Android 4.14. I believe these should
> > goto stable and flow into Android 4.14 from there, but I haven't tested
> > this since I have no hardware to do so.
> > 
> > Atleast I can say that the coccicheck error below goes away when running:
> > make coccicheck MODE=report
> > ./drivers/dma/stm32-dma.c:567:18-24: ERROR: chan -> desc is NULL but dereferenced.
> > 
> > Anyway, please consider this series for 4.14 stable, I have CC'd the
> > author and others, thanks.
> > 
> > Pierre Yves MORDRET (7):
> >   dmaengine: stm32-dma: threshold manages with bitfield feature
> >   dmaengine: stm32-dma: fix incomplete configuration in cyclic mode
> >   dmaengine: stm32-dma: fix typo and reported checkpatch warnings
> >   dmaengine: stm32-dma: Improve memory burst management
> >   dmaengine: stm32-dma: fix DMA IRQ status handling
> >   dmaengine: stm32-dma: fix max items per transfer
> >   dmaengine: stm32-dma: properly mask irq bits
> > 
> >  drivers/dma/stm32-dma.c | 287 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 240 insertions(+), 47 deletions(-)
> 
> 
> I need git commit ids for all of these for what the patch in mainline
> is.
> 
> Can you fix that up and resend them?
> 

Vinod raised a concern in the other thread that he does not want all of the
"feature patches" that I posted in these series into -stable, since not
everything is a fix.

So what I'll do is I'll only repost:
dmaengine: stm32-dma: fix incomplete configuration in cyclic mode

which fixes the null pointer issue that raised the coccinelle error I found
and reported.

I'll let Vinod/Pierre decide on posting the other fixes to stable since they
may have more background on whether something is a fix or not.

thanks,

 - Joel


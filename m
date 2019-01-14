Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C22064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dypfaALy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfANUYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:24:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38440 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfANUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:23:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so143561pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZOtHXcEinU3k47EXVCQKwZV5lZ9F7iYD0P8FSPjc2tw=;
        b=dypfaALyWmVUFAvANObmu4zSCHTOBpeaCPiJELo0lkjrhEJu/TakxqEtqZVX8IPznP
         uE6duwJnrsMLGWe5/6atohcgWHxx4BDNuqRuGduWFFilF/4sumv9/i4kJySaQVre+j8f
         9j45sXAayC4ZQPv4MK7qaUutE4QUvf9y2FQ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOtHXcEinU3k47EXVCQKwZV5lZ9F7iYD0P8FSPjc2tw=;
        b=dw1LdkSKY6Q46BCqNvctnwoPQMLq1uYY5RYPSD0pGw1f9uIPosa9eq4n3Xe27MDTSH
         rnYJW2/7wtkG6gUjvm0vh+OU68QeyxRsmZR6k79cyfyTbhltie1KLO2UTGGNEbkPcZau
         MAq8AkiG3GVN3BG71cA5CdOJPoonShGFYdS8Yb0d6QfpHmKXfaPs5Fyw9vh6RkGnFAxi
         mD5RfOGIXyWvHur5SwuID0NG+vty0eqEQistZlLIiWuMbQBFDPxIaAN8eGnwARQK5hny
         SIVkmAIEY8CapFq9Rw/psHtMJLrelZd23rLZPEqtmaHvjJv0ZFYNX4KhjEhMHaIlh1S9
         jBNg==
X-Gm-Message-State: AJcUukehX+h1aaU4MoPIik8uKcvtq1oMHI4eQov4ZtLARP23dL39sLWD
        4Kic/sA54rGdOybPBu9NcLiqGg==
X-Google-Smtp-Source: ALg8bN6ZCZXiOhdJzVEvPSAd5bE+93EkCp3+eEW8VTQv7jxwqZBdwpB+6eVv7hzo5P9lqB35wZpu3g==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr281774pgk.406.1547497438375;
        Mon, 14 Jan 2019 12:23:58 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b5sm2674403pfc.150.2019.01.14.12.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:23:57 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:23:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Message-ID: <20190114202355.GB9278@minitux>
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
 <20190114111109.GA18673@infradead.org>
 <20190114173051.GA9278@minitux>
 <20190114173659.GA17788@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114173659.GA17788@infradead.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 09:36 PST 2019, Christoph Hellwig wrote:

> On Mon, Jan 14, 2019 at 09:30:51AM -0800, Bjorn Andersson wrote:
> > The problem here is that the capability bit states that the controller
> > itself claim to be able to deal with 64-bit addresses, which is probably
> > true. The thing that the struct device represents (the integrated
> > controller, on a bus in this SoC) doesn't.
> > 
> > The device model accurately handles this and carries a dma_mask that's
> > appropriate for the device in this system - the capability is not.
> > 
> > > You either need to introduce a quirk or a way to communicate the
> > > different limit so that it can be set by the core.
> > 
> > The system's limit is already communicated in hba->dev->dma_mask, but
> > the ufshcd driver overwrites this. I expect that this would make sense
> > if the device model claims we can do e.g. 40 bit addressing, but the
> > 64-bit capability is not set in the controller - in which case ufshcd
> > would accurately lower this to 32-bits.
> 
> No, that is absolutely not true.  dev->dma_mask is set by the driver
> to what the driver based on the device specsheet/register claims to
> support.  dev->bus_dma_mask contains any additional limits imposed
> by the bus/system, but that is handled transparently by the dma mapping
> code.

You're right and I see now that my bus_dma_mask is not set properly and
is the cause of the problem.

Thanks for correcting me, I fully agree with your NACK now.

Regards,
Bjorn

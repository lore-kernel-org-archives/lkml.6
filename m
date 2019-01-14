Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB025C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9927206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzRSVic2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfANRhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:37:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfANRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rqdUcD6zWC7vTK5KKyPK6+xpPlOHeOPj/wHvCYm6p8k=; b=LzRSVic2vRQu0ZaoUWvxnGDiJ
        UIAQA2+SjZNjAhWxjDBV2Um1c9kJX0wzVzuLfaQkStaosGff9IiIvex3CxcB3HuEmfOzyZFOxBX0I
        PhxlgPiSTYHDg4ybQgjdH23ue5kr6Dm/a5xBbvEtk1oLKCv0tYgCavrbWM6OYdWLgOjetRSstVk4D
        W023aC5B5alraBTcPwUYKpLkoFHKgFg5DwbckgtmTIF+OA2afS6puHSP2S/INbpKI5wcJZc9bShRp
        VQwwmkoupCESUQlux46GSHJ0r14pBVUQg0nprVkaOlog7cBzC6vBRz1GFxox4jryxz2GRLmN4swJz
        SlVPouXtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj6AV-0004vL-E7; Mon, 14 Jan 2019 17:36:59 +0000
Date:   Mon, 14 Jan 2019 09:36:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Message-ID: <20190114173659.GA17788@infradead.org>
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
 <20190114111109.GA18673@infradead.org>
 <20190114173051.GA9278@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114173051.GA9278@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:30:51AM -0800, Bjorn Andersson wrote:
> The problem here is that the capability bit states that the controller
> itself claim to be able to deal with 64-bit addresses, which is probably
> true. The thing that the struct device represents (the integrated
> controller, on a bus in this SoC) doesn't.
> 
> The device model accurately handles this and carries a dma_mask that's
> appropriate for the device in this system - the capability is not.
> 
> > You either need to introduce a quirk or a way to communicate the
> > different limit so that it can be set by the core.
> 
> The system's limit is already communicated in hba->dev->dma_mask, but
> the ufshcd driver overwrites this. I expect that this would make sense
> if the device model claims we can do e.g. 40 bit addressing, but the
> 64-bit capability is not set in the controller - in which case ufshcd
> would accurately lower this to 32-bits.

No, that is absolutely not true.  dev->dma_mask is set by the driver
to what the driver based on the device specsheet/register claims to
support.  dev->bus_dma_mask contains any additional limits imposed
by the bus/system, but that is handled transparently by the dma mapping
code.

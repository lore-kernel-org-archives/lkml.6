Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB22C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA32219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vm3P/pRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA32219DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbeHGJio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:38:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388772AbeHGJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zu/PrnOkOI+WvXnv9v1aWYBHXkuVK0qbLBa2kuSLar8=; b=Vm3P/pRpMzxPofST9WoexAQAF
        uKYCPFspcdKZyCSrNZ9x6DNaGsWcFYfXl1V2L8YgQNXehw0WGVXKzNf0NXLz67hMPJyKyPtzwdJ/C
        ie+d5MsOdxbHr2GOZSkzt/UiIGudcb2hCriRLBDRsYvC9u+B8ug5EuZkys2cJ96ARh8AEfi3UOLMs
        w5s4r9JA5DWH8tstRFiA3dL1lUumZPg3sgaZwtBBgIRvu5sZDs9Oe/q3RG8yiBDiE/xLkQhwZ+9iT
        YIVeOfCz+v1Pzfj3dyxq43ojBPz677+lrknd1xX7uwjAwu+PKardTnVLdGhxqR5bN0sKSFEgE2LoN
        O9dq0gBig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmwNC-0006Xp-18; Tue, 07 Aug 2018 07:25:42 +0000
Date:   Tue, 7 Aug 2018 00:25:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
Message-ID: <20180807072541.GA10720@infradead.org>
References: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
 <20180806083730.GA32650@infradead.org>
 <cbbcbe2c-28c6-faa1-4ef4-8e59c486e2a4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbbcbe2c-28c6-faa1-4ef4-8e59c486e2a4@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:03:35AM -0700, Guenter Roeck wrote:
> Yes, I can confirm that the warning is gone in -next. Problem solved,
> except of course there are still the warnings about the missing
> coherent_dma_mask.
> 
> sm501-usb sm501-usb: SM501 OHCI
> sm501-usb sm501-usb: new USB bus registered, assigned bus number 1
> WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 ohci_init+0x194/0x2d8
> 
> Is that warning also not warranted for the given use case, or is
> the missing mask indeed necessary ? It is easy to add - see
> https://lore.kernel.org/patchwork/patch/971411/ - but I do wonder
> if that change is appropriate.

Yes, every driver using dma coherent functions should set a coherent
mask.

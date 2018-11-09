Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6326C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9EF2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jEkC6CjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9EF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeKIRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:24:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeKIRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NQU5as14VuxTEo4YTlnWbZyJ2D6SWiG2oqZ8giH4tNg=; b=jEkC6CjS8klVnLdIQ79D4aklT
        7fSebe0x5RjlmNwm+1/6m5iWgtIfkoundoFdSUZ02ox1DY9njb9YYnCiNUSps3t6R3Hv8xW5/wlXm
        iATXe5jIUHChpdI5AGRj+P6+oH6RSnAXoluoCXq7E4aTD5pgEUcC9SdZfDNggkUCQfK0OV0LPrmQU
        opX3293wE/vDHKptX8cyzNZV2NAOnBlXnV4Vfoc1r/m/NTlFn0wDYBuj9GU6XSg5/kd5xG01Yqrbn
        6dQoFdt3FcYB2R2C/pClq8wja2+OSpwNZztid4luQWt3sp1MDda3S5qAAXmmpnstqQXgdInwjB5q9
        3Nx8N3ZsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gL1Tb-0000PW-4K; Fri, 09 Nov 2018 07:45:11 +0000
Date:   Thu, 8 Nov 2018 23:45:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181109074510.GA27623@infradead.org>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <20181105145847.GA31337@infradead.org>
 <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdc0e33-db18-6ad9-61cd-919fe3df1b4e@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 02:39:26PM +0000, Robin Murphy wrote:
> ...and I have some significant objections to that simplification which I
> plan to respond with ;)
> 
> (namely that it defaults the whole higher-order page allocation business
> which will have varying degrees of performance impact on certain cases)

Well, please place your objection there.  The behavior does match what
every other iommu-based dma ops implementation ouside of arm/arm64 does,
so there is some precedent for it to say the least.  But if the only
current users objects I'll surely find a way to accomodate it, but a
good rationale including numbers would be useful to document it.

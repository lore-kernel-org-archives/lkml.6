Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CE32148D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbZepM/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBAXQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:16:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hITrKD1UvJBkX8+FdT2WJe0osPPJT9rBZQVOR7anM94=; b=gbZepM/5HJBBiMCElsKLTtBvQ
        vv5WsdK3AMfmm5ew11Uh9hP4id7NTo1KYbk1tN6CBHDkBgNyaaGr4/zDcgBuOwCuNGrD+O8tJPhz4
        Ud2qFbVKMV/3wuLMwZeNkvQyqMa2AEaFxetBeRd7sfwyqhfR9CkifpORuQ+tsVnXeq6XTGg9BUO1P
        pzjXkomLt1+lRpMA8Sv9xf+ALC/wmwuJ8e3bPsHmlsxGXQS7v+yqHWdDa32c0vU6qhcRVGurkKEht
        PsZJ+5HrH+e0Jf48HdEOeimqRFvmhEKjR16zMDC4JudZ8beVwFYjEqP/1utIggZT/JVS5jpiAYMpL
        ePR9ycfQg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpi2S-0007FR-Vh; Fri, 01 Feb 2019 23:16:00 +0000
Date:   Fri, 1 Feb 2019 15:15:59 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     stuart.w.hayes@gmail.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario_Limonciello@Dell.com
Subject: Re: [PATCH] dell_rbu: stop abusing the DMA API
Message-ID: <20190201231559.GC105752@fedora.eng.vmware.com>
References: <20190129073409.7247-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129073409.7247-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:34:09AM +0100, Christoph Hellwig wrote:
> For some odd reason dell_rbu actually seems to want the physical and
> not a bus address for the allocated buffer.  Lets assume that actually
> is correct given that it is BIOS-related and that is a good source
> of insanity.  In that case we should not use dma_alloc_coherent with
> a NULL device to allocate memory, but use GFP_DMA32 to stay under
> the 32-bit BIOS limit.

+ Mario re bios related physical address - is Christoph's assumption
correct?

Christoph, did you observe a failure? If so, we should probably also
tag for stable.

-- 
Darren Hart
VMware Open Source Technology Center

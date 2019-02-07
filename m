Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B432BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE12147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YDtR7P4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBGHQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 02:16:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBGHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 02:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=so5q6TjpGxAOvmkdcR8//fWOl4z6ZFvizvjphmN4+MA=; b=YDtR7P4ZgLpd2Rl1fCGqmnCC2
        Buoo+xJlfs3myD3RQXQY2TAn84mxR09oa/IMZIB+G/vOJtTmVH5NHkErrgl+tsMBfaYYrU3OUFw7m
        orYvF1aHiaQ0H4VXW/EVeiELfN2wUMK0wps3+7LzSVKl/ujFG34RhViaGG2OytbJVU5ViYfc0vAIr
        U97kTVb70VMPMwMO4UyR3Pa6ja+4AL2fvsD8ANhd7DFGRI+iDWh3FqubXDIXJlOYLP6Ml/h+xlwMd
        j7h/kffrThOQcRPT/izHxzTTN9ep3J07lKj0uO7XRsV//8RSP3hlK8/R1TTYg5iZKkN9FbEihO+7C
        VnoGFydDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grdvF-0001Cz-Eu; Thu, 07 Feb 2019 07:16:33 +0000
Date:   Wed, 6 Feb 2019 23:16:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V11 3/5] i2c: tegra: Add DMA support
Message-ID: <20190207071633.GA25149@infradead.org>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com>
 <20190206145343.GA3651@ulmo>
 <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:56:02PM +0300, Dmitry Osipenko wrote:
> > We don't have an IOMMU attached to I2C or APBDMA, so this can't happen
> > and even if we had an IOMMU attached, all we care about is the device's
> > DMA address space, which means IOVA space, and that would still be
> > guaranteed to be contiguous, according to the above.
> 
> Yes, but doesn't T186+ have IOMMU support for the DMA controller?

Even if it did, why would that matter?  The device would only see
IOVA space, the CPU for a normal driver only sees kernel virtual
space.

Forced contiguous space only makes sense when you have access by CPU
physical address, which should not happen for "normal" device drivers.

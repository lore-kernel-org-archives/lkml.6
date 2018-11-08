Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB35ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBA020825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UHJJmx2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBA020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeKIBBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:01:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKIBBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wuBdvmBEI70uIvQdAA8obT6YBWRMuyuR1fcXdBf7kx4=; b=UHJJmx2NgqK/jWGcTEqd4LyHc
        Jzo88G6SObnNV9UwxL77+URbJkTRwOPWom9c+a0D2Rv52NX4h05JfEIzqfct02ePhU+2GhWML4efJ
        OLfDgV0LGni1MPMXDEALLEwRBUBw0CaLqnzK/bgnm5/0t8qDuW9AkiIj2hBuzq7CA90oyDTN2IjS2
        YSeT80iugCiAtIpF+ZojQOIC1YEqMArtebKyi7N4+4ZEHsoNkSb+FtIqupVf9hGcHdAisPQibIZnS
        DZSSUTp7E3L3IMA2VEloyTz593rzllY2xv25Pkea4lqeXaIAsEMm4kH2bTfjfOwfDjnPknzdBwfUa
        OxaJKYn/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKmBX-0008Ln-1K; Thu, 08 Nov 2018 15:25:31 +0000
Date:   Thu, 8 Nov 2018 07:25:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "danielwa@cisco.com" <danielwa@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Message-ID: <20181108152530.GA27198@infradead.org>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
 <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
 <20181107173303.slnb3i2d6ufaonp7@zorba>
 <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
 <bee96cb5db73c325675881b180006e1382718abe.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee96cb5db73c325675881b180006e1382718abe.camel@infinera.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 06:41:47PM +0000, Joakim Tjernlund wrote:
> > Certainly not. I'm not sure which architectures do have Spectre V2
> > mitigations which make indirect branches expensive now... perhaps there is
> > no intersection with the cases where we really care about JFFS2 being
> > CPU-bound?
> 
> All that passing of a new extra arg and extra if .. elif .. does cost too.

I know of no current microarchitecture where an indirect call is cheaper
than a simple branch, which can be very well predicted.

Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E819DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1B2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 05:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B1B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeHXJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:32:03 -0400
Received: from verein.lst.de ([213.95.11.211]:38633 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbeHXJcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:32:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1977768E54; Fri, 24 Aug 2018 08:00:56 +0200 (CEST)
Date:   Fri, 24 Aug 2018 08:00:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
Message-ID: <20180824060055.GB13689@lst.de>
References: <20180824025933.24319-1-bauerman@linux.ibm.com> <20180824025933.24319-11-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824025933.24319-11-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
> device can access it through it's DMA window without requiring bouncing. In
> such cases it just chooses to skip bouncing. But for cases like secure
> guests on powerpc platform all addresses need to be bounced into the shared
> pool of memory because the host cannot access it otherwise. Hence the need
> to do the bouncing is not related to device's DMA window. Hence force the
> use of bouncing by setting the swiotlb_force variable on secure guests.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/kernel/svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
> index 1af5caa955f5..f0576ad65cd0 100644
> --- a/arch/powerpc/kernel/svm.c
> +++ b/arch/powerpc/kernel/svm.c
> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>  		return 0;
>  
>  	ppc_swiotlb_enable = 1;
> +	swiotlb_force = SWIOTLB_FORCE;
>  	swiotlb_update_mem_attributes();

This needs a comment.

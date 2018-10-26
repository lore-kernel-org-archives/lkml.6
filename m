Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD512C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB8C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJZQYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:24:01 -0400
Received: from verein.lst.de ([213.95.11.211]:34775 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:24:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 91A4B68C38; Fri, 26 Oct 2018 09:48:02 +0200 (CEST)
Date:   Fri, 26 Oct 2018 09:48:02 +0200
From:   Christoph Helwig <hch@lst.de>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages
 are contiguous
Message-ID: <20181026074802.GA4768@lst.de>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com> <20181024130246.GA22616@localhost.localdomain> <83900cf4-690c-9725-d022-d427fdeb4f7d@oracle.com> <581cb7ea-3112-791d-918d-9bb887e4744f@oracle.com> <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com> <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com> <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com> <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com> <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 11:56:02AM -0700, Joe Jin wrote:
> I just discussed this patch with Boris in private, his opinions(Boris,
> please correct me if any misunderstood) are:
> 
> 1. With/without the check, both are incorrect, he thought we need to
>    prevented unalloc'd free at here. 
> 2. On freeing, if upper layer already checked the memory was DMA-able,
>    the checking at here does not make sense, we can remove all checks.
> 3. xen_create_contiguous_region() and xen_destroy_contiguous_region()
>    to come in pairs.
> 
> For #1 and #3, I think we need something associate it, like a list, on
> allocating, add addr to it, on freeing, check if in the list.

Is there any way to figure out based on an address if the exchange
operation happened?

> For #2, I'm was not found anywhere validated the address on 
> dma_free_coherent() callpath, not just xen-swiotlb.

At least for simple direct mappings there is no easy way to verify that
without keeping a list, and for some of the ops that do vmap like
operations we have basic santiy checks, but nothing that really catches
a wrong free.

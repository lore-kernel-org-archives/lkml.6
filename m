Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC535C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AE820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLFRn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeLFRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7308C7F6D0;
        Thu,  6 Dec 2018 17:43:58 +0000 (UTC)
Received: from localhost (ovpn-200-34.brq.redhat.com [10.40.200.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBAC360F89;
        Thu,  6 Dec 2018 17:43:52 +0000 (UTC)
Date:   Thu, 6 Dec 2018 18:43:51 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@toke.dk>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181206184351.4d9ece54@redhat.com>
In-Reply-To: <20181206153720.10702-1-hch@lst.de>
References: <20181206153720.10702-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 06 Dec 2018 17:43:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Dec 2018 07:37:19 -0800
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> a while ago Jesper reported major performance regressions due to the
> spectre v2 mitigations in his XDP forwarding workloads.  A large part
> of that is due to the DMA mapping API indirect calls.
> 
> It turns out that the most common implementation of the DMA API is the
> direct mapping case, and now that we have merged almost all duplicate
> implementations of that into a single generic one is easily feasily to
> direct calls for this fast path.
> 
> This patch adds a check if we are using dma_direct_ops in each fast path
> DMA operation, and just uses a direct call instead.  For the XDP workload
> this increases the number of packets per second from 7,438,283 to
> 9,610,088, so it provides a very significant speedup.

Full test report avail here:
 https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org


> Note that the patch depends on a lot of work either queued up in the
> DMA mapping tree, or still out on the list from review, so to actually
> try the patch you probably want this git tree:
> 
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-calls
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

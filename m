Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8741214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="XF/8tkNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8741214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeIYPQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:16:24 -0400
Received: from 8bytes.org ([81.169.241.247]:33750 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeIYPQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:16:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A8F506FB; Tue, 25 Sep 2018 11:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537866589; bh=EP0pGRqKC2ZQwSyO2dkc1ia5+0d39Y3Q4LQHEcqeuqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XF/8tkNtfUF7PuXDLGDvLy0DOjGapCsIa1DejJenGRg/7MCN7HI0rF9jR9G+dpYCK
         f+0Re2fR65NeQWxzSGcLxKSVZ3vNJ639s+n5CIuldXMwvB/VfWxEzBLqyo+DUlrNC+
         1O/6Q7Y2bG/QUwsO8pUIp1EQNK562jHfKwFcfmusbZ9TDEU8JdGsmXOObLEFdzUtww
         R2WnJfdYDm3nnFdOq9kXg+5fEwMSj9CmdsnL43OUPQcrOQit3Q4dqzEIl/FFFM1n0O
         GFO25kLZUhPZRxClyvAVTgnpwgEbq9Ljhvw3GZ/wbQaA8kNU15vUKo9hhuU0oMlC3c
         MLp9gAIqnq0UA==
Date:   Tue, 25 Sep 2018 11:09:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     murphyt7@tcd.ie
Cc:     leo.duran@amd.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Message-ID: <20180925090948.k62lms4t5qduwnpo@8bytes.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7@tcd.ie wrote:
> From: Tom Murphy <murphyt7@tcd.ie>
> 
> ---
> 
> This patch allows the IOMMU API path in the AMD driver to be called
> from an atomic context.  This is useful for anyone building a driver
> which needs to call the IOMMU API while holding a spinlock.

A bit more context would be helpful here. This is a pretty intrusive
change since we will drain the memory allocators atomic pools now while
building page-tables. This needs some more justification than just 'some
drivers might need it'.

Further, if we really address this problem it needs to happen through
the IOMMU-API, because the functions you are patching are called from
iommu_map()/iommu_unmap(), and these functions are allowed to sleep.

So the required approach here would be to introduce something like
iommu_map_atomic()/iommu_unmap_atomic() and implement call-backs for
that in more than just one driver.

Regards,

	Joerg


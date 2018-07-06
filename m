Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23D124027
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="XgeKUbFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23D124027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeGFNQS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:16:18 -0400
Received: from 8bytes.org ([81.169.241.247]:54216 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933049AbeGFNQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:16:17 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 778EA1F0; Fri,  6 Jul 2018 15:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530882976; bh=URFhKYmPMB40YjFPfAhv5yMBmcAuoIx0NWuWNOYPauI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgeKUbFTiGQlUj0vsjlRUWyCWVO4uAQscKAXUSmy767VFC4XQ3pc/ilzq7rjwtyxE
         KW4y6yxWYkOThrqBq+MYLgjQUiRQn/vjbfAncOpgOUqzzJfCBToOcLb8IgRA+WSCG5
         gfuvS7/R4g1XR617VwMrrxyjhQQ4zuhzIIGzM+cJNFWp8KOPGhk/g4gN2F1gkelOmW
         Hx6LZ0R1sGVmgREFavJkqqALFED4EAVqeaKwi7L4SeoSLY2ExP1wu9bNjocHXcqNXE
         IMMQnyN1fAxm6XEWVzi5ItF2kgRV3cFLEYZg2zFSaM9Dz9ICCYL3eIsUwal1ixgfLs
         PxLrJk0rLcd9A==
Date:   Fri, 6 Jul 2018 15:16:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [RFC 0/3] iommu/iova: Unsafe locking in find_iova()
Message-ID: <20180706131611.h3w2kdinmjguikgo@8bytes.org>
References: <20180621180823.805-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621180823.805-1-dima@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:08:20PM +0100, Dmitry Safonov wrote:
> find_iova() looks to be using a bad locking practice: it locks the
> returned iova only for the search time.  And looking in code, the
> element can be removed from the tree and freed under rbtree lock. That
> happens during memory hot-unplug and cleanup on module removal.  Here
> I cleanup users of the function and delete it.

But this is only a problem if more than one code-path uses tries to
handle a given iova at the same time, no?

Regards,

	Joerg


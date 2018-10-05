Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2813CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26AF20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Bn3qBwvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26AF20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeJEP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:28:42 -0400
Received: from 8bytes.org ([81.169.241.247]:54388 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728447AbeJEP2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:28:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 00047338; Fri,  5 Oct 2018 10:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1538728262; bh=yi7doJdrlQxHHlnZuQmqnS1VBtMYh2LL/rSgZLyyFfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bn3qBwvYaTqxXGbCjBlwiA/l8CQNw1gPVxO59nQY3LZobfHylKEOfiAod8QU1bCOS
         YawvBh8TM1Wpyy32AilbDg4aKBgKUJpzc8pvN2Sjf4OjZHnz3KUPes92WWqgxv3rNu
         MaK0CLeYNrTq3GSKOzz6cDt+CPpj/wqsCiM51GNFBkPiS5mYcBK2zohzm5TfqkBO8P
         Qnoz/fsV0s8ppfrxJWMR9T+MrVAOKSOQJtpGRO9clUlUUMJeyuJ7fodfXw+Vg4e6oV
         3/FMg933fYDifctXvTe00xn7Px9sq0tfffcRIpk9AErkywjyZ71CvmNZ5yey5LrxBd
         3ZA+6rs0qeLdw==
Date:   Fri, 5 Oct 2018 10:31:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "# 4 . 14+" <stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Clear memory encryption mask from physical
 address
Message-ID: <20181005083101.GD3630@8bytes.org>
References: <1538689210-14524-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538689210-14524-1-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:40:23PM +0000, Singh, Brijesh wrote:
> Boris Ostrovsky reported a memory leak with device passthrough when SME
> is active.
> 
> The VFIO driver uses iommu_iova_to_phys() to get the physical address for
> an iova. This physical address is later passed into vfio_unmap_unpin() to
> unpin the memory. The vfio_unmap_unpin() uses pfn_valid() before unpinning
> the memory. The pfn_valid() check was failing because encryption mask was
> part of the physical address returned. This resulted in the memory not
> being unpinned and therefore leaked after the guest terminates.
> 
> The memory encryption mask must be cleared from the physical address in
> iommu_iova_to_phys().

Merged and on its way upstream, thanks Brijesh.

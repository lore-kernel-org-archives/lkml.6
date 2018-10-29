Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED59C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374C020825
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JI/PlU9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374C020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeJ2SpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:45:07 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19899 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbeJ2SpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:45:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6d9680000>; Mon, 29 Oct 2018 02:56:56 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 02:57:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Oct 2018 02:57:09 -0700
Received: from [10.26.11.215] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 09:57:07 +0000
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
To:     Ashish Mhetre <amhetre@nvidia.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <avanbrunt@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <vdumpa@nvidia.com>,
        <Snikam@nvidia.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b014451f-d81e-1d02-4b04-f719bca6621d@nvidia.com>
Date:   Mon, 29 Oct 2018 09:57:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540807016; bh=B1EmMxeTBY1PPTiFEUalJrnyKJhas2yAxsj4P8Dj6JM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JI/PlU9zToSOj+AJzpwikxfzVKAzSw8NspwDlqWxhlpBY7SOnYGtVWAXHmqmzge4x
         Kh55yLizRGKLQYnh6C2GBjgx6IT6b816bH8/t92PUGEDwShdHcVDBciBaruWormo3A
         nLZLqeWiyhE/pCbuEmmw84/uf9phwnBZyj3fOHL7ELDkdT4z8McocFetsoZYks1QXm
         KrMmoqhzlcMnFOdpo/tism60rvV6p4ucEgYszKk5hhBzzTxwegB6UgTRv5xD+8BRam
         BmcLM1btyIbb8yotGfvUIn9xEClflLFem+Ds7O+ysjjAltMHIOnKiY3DkM+pSZUCoi
         txbF9KN0FV/1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/2018 09:25, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessary
> for this. Clearing the accessed bit without flushing TLB doesn't cause data
> corruption on ARM64.
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accessed
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.
> Please refer to:
> 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---

Please make sure you state here below the above line what has been
changed between each version of the patch.

Thanks
Jon

-- 
nvpublic

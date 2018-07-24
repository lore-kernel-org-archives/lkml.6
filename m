Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EBEECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823F420875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdVNnLCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbeGXBnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbeGXBnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:43:49 -0400
Received: from [10.82.12.117] (unknown [131.107.147.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E3B20685;
        Tue, 24 Jul 2018 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532392803;
        bh=l+bb3cYfYUDzt8drZOt84gW0WC67lQSJnA7mEBK1Z5c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NdVNnLClRhDNaIFlsCAW02JBQ9pcTgQRzQWLF7Utp7gx/FFB1OiJkv4DylxJzY6yd
         s1rAG6y2JzHGLGhY6qkd8fxaWkC3YtKEiBCAL1DJikA0x1UQ6Z0F4TBg4ENokhuPgv
         oXf7n2omKaQ/8xSBh2T2MU/Umxah9l+oX/9ASIMo=
Subject: Re: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>
Date:   Mon, 23 Jul 2018 17:40:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724001310.7671.41243.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 5:13 PM, Alex Williamson wrote:
> + * The NVMe specification requires that controllers support PCIe FLR, but
> + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> + * config space) unless the device is quiesced prior to FLR.

Does disabling the memory bit in PCI config space as part of the FLR 
reset function help? (like the very first thing)

Can we do that in the pcie_flr() function to cover other endpoint types
that might be pushing traffic while code is trying to do a reset?



Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B784C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CDA20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CDA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIKMbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:31:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37400 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeIKMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:31:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fzdAX-0004MF-Vm; Tue, 11 Sep 2018 09:33:06 +0200
Message-ID: <1536651177.3224.106.camel@sipsolutions.net>
Subject: Re: 4.19-rc[23] iwlwifi: BUG in swiotlb
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
Date:   Tue, 11 Sep 2018 09:32:57 +0200
In-Reply-To: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org> (sfid-20180911_041837_063528_262C06DC)
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
         (sfid-20180911_041837_063528_262C06DC)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 19:17 -0700, Randy Dunlap wrote:
> Hi,
> 
> Any ideas?

Hmm. Is this new?

> 2018-09-10T18:47:54.532837-07:00 dragon kernel: [   31.472371] kernel BUG at ../kernel/dma/swiotlb.c:521!

        nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
	[...]
	BUG_ON(!nslots)

> 2018-09-10T18:47:54.613655-07:00 dragon kernel: [   31.490325]  swiotlb_alloc+0x88/0x170
> 2018-09-10T18:47:54.613656-07:00 dragon kernel: [   31.490329]  ? __kmalloc+0x1cc/0x200
> 2018-09-10T18:47:54.613657-07:00 dragon kernel: [   31.491652]  iwl_pcie_txq_alloc+0x1d4/0x3b0 [iwlwifi]

There are two calls to dma_alloc_coherent() here, should those even hit
swiotlb? The sizes of those should be
 * 256 x 128 (32k)
 * 32 x 256 (8k) [TFH, unlikely to be the case here]
 * 256 x 256 (65k) [TFH]
 * 32 x 64 (2k)
 * 256 x 64 (16k)


IO_TLB_SHIFT is 11, so we get 2k alignment, so even the smallest size
(32*64) should result in nslots being 1?

In fact, unless the driver passed *ZERO* as the size, this should never
happen (hence the BUG_ON), since ALIGN() would take care of rounding up
any smaller allocation here.

Presumably you can reproduce this pretty easily (and I don't know what
specific model of NIC you have etc.), so perhaps you can do something
like this?

https://p.sipsolutions.net/aa0dccd7a60fe176.txt

johannes

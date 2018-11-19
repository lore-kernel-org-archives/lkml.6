Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A53C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC0A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC0A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elvees.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbeKTCyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:08 -0500
Received: from mail.elvees.com ([80.90.126.250]:59704 "EHLO mail.elvees.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbeKTCyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:08 -0500
X-Greylist: delayed 1662 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 21:54:07 EST
Received: from virgo-pc.elvees.com ([81.26.151.163])
        (authenticated bits=0)
        by mail.elvees.com (8.14.3/8.14.2) with ESMTP id wAJG2NfS070044
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 19:02:23 +0300 (MSK)
        (envelope-from okitain@elvees.com)
Reply-To: okitain@elvees.com
To:     linux-kernel@vger.kernel.org
From:   Olga Kitaina <okitain@elvees.com>
Subject: using ioremap() memory in dma_map_sg()
Organization: ELVEES
Message-ID: <1de01d9e-7cf4-5803-be65-e24a6c5e30c6@elvees.com>
Date:   Mon, 19 Nov 2018 19:02:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
As part of our driver, we want to have some device memory to be 
available to other devices via the DMA-BUF subsystem. The device memory 
is managed by genpool, and mapped from the sram driver via ioremap_wc(). 
We initially used sg_set_buf() with the virtual address returned from 
gen_pool_dma_alloc(), but it seems like the wrong thing to do, since the 
virt_addr_valid() check fails. Attempting to use vmalloc_to_page() 
results in a failure down the line, such as:

Unable to handle kernel paging request at virtual address ba405000
Backtrace:
(dma_cache_maint_page) from (__dma_page_dev_to_cpu+0x88/0x108)
(__dma_page_dev_to_cpu) from (arm_dma_map_page+0x5c/0x60)
(arm_dma_unmap_page) from (arm_dma_map_sg+0x64/0x8c)
(arm_dma_unmap_sg) from(foo_dmabuf_map+0x60/0x8c [foo])

Is there an appropriate way to put an ioremapped buffer into an SG table?

Thanks,
Olga.

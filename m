Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeBIVZ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:25:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:29548 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeBIVZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:25:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,485,1511856000";
   d="scan'208";a="16851053"
To: sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Alexey Skidanov <alexey.skidanov@intel.com>
Subject: dma-buf CPU access
Cc: Laura Abbott <labbott@redhat.com>
Message-ID: <e2571723-1b92-db19-8ca8-06f358363453@intel.com>
Date: Fri, 9 Feb 2018 23:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

According to the CPU access instructions in the dma-buf.c, I understand
that on 32 bit platforms, due to the limited number of persistent kernel
mappings or limited vmalloc range, the CPU access pattern should look
like this:

dma_buf_start_cpu_access();

void *ptr = dma_buf_kmap();

/*Access the page pointed by ptr*/

dma_buf_kunmap(ptr);

dma_buf_end_cpu_access();


or


dma_buf_start_cpu_access();

void *ptr = dma_buf_vmap();

/*Access the buffer pointed by ptr*/

dma_buf_vunmap(ptr);

dma_buf_end_cpu_access();


But on 64 bit platforms, there are no such restrictions (there is no
highmem at all). So, frequently accessed buffer, may be mapped once, but
every access should be surrounded by :

dma_buf_start_cpu_access();

/*Access the buffer pointed by ptr*/

dma_buf_end_cpu_access()

Am I correct?

Thanks,
Alexey

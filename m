Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81638C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E8121019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 01:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeL2BlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 20:41:08 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40596 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbeL2BlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 20:41:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TH231mC_1546047661;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TH231mC_1546047661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Dec 2018 09:41:04 +0800
Subject: Re: [v3 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545428420-126557-1-git-send-email-yang.shi@linux.alibaba.com>
 <20181228164246.4867201125a2123c8f6a6f9c@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <453db4f7-cff9-c3ec-4b37-3669ab85016f@linux.alibaba.com>
Date:   Fri, 28 Dec 2018 17:41:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181228164246.4867201125a2123c8f6a6f9c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/18 4:42 PM, Andrew Morton wrote:
> On Sat, 22 Dec 2018 05:40:19 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Swap readahead would read in a few pages regardless if the underlying
>> device is busy or not.  It may incur long waiting time if the device is
>> congested, and it may also exacerbate the congestion.
>>
>> Use inode_read_congested() to check if the underlying device is busy or
>> not like what file page readahead does.  Get inode from swap_info_struct.
>> Although we can add inode information in swap_address_space
>> (address_space->host), it may lead some unexpected side effect, i.e.
>> it may break mapping_cap_account_dirty().  Using inode from
>> swap_info_struct seems simple and good enough.
>>
>> Just does the check in vma_cluster_readahead() since
>> swap_vma_readahead() is just used for non-rotational device which
>> much less likely has congestion than traditional HDD.
>>
>> Although swap slots may be consecutive on swap partition, it still may be
>> fragmented on swap file. This check would help to reduce excessive stall
>> for such case.
> Some words about the observed effects of the patch would be more than
> appropriate!

Yes, sure. Actually, this could reduce the latency long tail of 
do_swap_page() on a congested system.

The test on my virtual machine with emulated HDD shows:

Without swap congestion check:
page_fault1_thr-1490  [023]   129.311706: funcgraph_entry:      # 
57377.796 us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.369103: funcgraph_entry: 5.642 us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.369119: funcgraph_entry:      # 
1289.592 us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.370411: funcgraph_entry: 4.957 us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.370419: funcgraph_entry: 1.940 us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.378847: funcgraph_entry:      # 
1411.385 us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.380262: funcgraph_entry: 3.916 us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.380275: funcgraph_entry:      # 
4287.751 us |  do_swap_page();


With swap congestion check:
       runtest.py-1417  [020]   301.925911: funcgraph_entry:      # 
9870.146 us |  do_swap_page();
       runtest.py-1417  [020]   301.935785: funcgraph_entry: 9.802 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935799: funcgraph_entry: 3.551 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935806: funcgraph_entry: 2.142 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935853: funcgraph_entry: 6.938 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935864: funcgraph_entry: 3.765 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935871: funcgraph_entry: 3.600 us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935878: funcgraph_entry: 7.202 us   
|  do_swap_page();


The long tail latency (>1000us) is reduced significantly.

BTW, do you need I resend the patch with the above information appended 
into the commit log?

Thanks,
Yang



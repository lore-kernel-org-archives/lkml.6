Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D273C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4267020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfACRLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:11:36 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55661 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732518AbfACRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:11:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THTEd2x_1546535413;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THTEd2x_1546535413)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jan 2019 01:10:15 +0800
Subject: Re: [v4 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190102230054.m5ire5gdhm5fzecq@ca-dmjordan1.us.oracle.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <76d8727a-77b4-d476-af89-9ae1904ec8cd@linux.alibaba.com>
Date:   Thu, 3 Jan 2019 09:10:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190102230054.m5ire5gdhm5fzecq@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/19 3:00 PM, Daniel Jordan wrote:
> On Sun, Dec 30, 2018 at 12:49:34PM +0800, Yang Shi wrote:
>> The test on my virtual machine with congested HDD shows long tail
>> latency is reduced significantly.
>>
>> Without the patch
>>   page_fault1_thr-1490  [023]   129.311706: funcgraph_entry:      #57377.796 us |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.369103: funcgraph_entry:        5.642us   |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.369119: funcgraph_entry:      #1289.592 us |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.370411: funcgraph_entry:        4.957us   |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.370419: funcgraph_entry:        1.940us   |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.378847: funcgraph_entry:      #1411.385 us |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.380262: funcgraph_entry:        3.916us   |  do_swap_page();
>>   page_fault1_thr-1490  [023]   129.380275: funcgraph_entry:      #4287.751 us |  do_swap_page();
>>
>> With the patch
>>        runtest.py-1417  [020]   301.925911: funcgraph_entry:      #9870.146 us |  do_swap_page();
>>        runtest.py-1417  [020]   301.935785: funcgraph_entry:        9.802us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935799: funcgraph_entry:        3.551us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935806: funcgraph_entry:        2.142us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935853: funcgraph_entry:        6.938us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935864: funcgraph_entry:        3.765us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935871: funcgraph_entry:        3.600us   |  do_swap_page();
>>        runtest.py-1417  [020]   301.935878: funcgraph_entry:        7.202us   |  do_swap_page();
> Hi Yang, I guess runtest.py just calls page_fault1_thr?  Being explicit about

Yes, runtest.py is the wrapper script of will-it-scale.

> this may improve the changelog for those unfamiliar with will-it-scale.

Sure.

>
> May also be useful to name will-it-scale and how it was run (#thr, runtime,
> system cpus/memory/swap) for more context.

How about the below description:

The test with page_fault1 of will-it-scale (sometimes tracing may just 
show runtest.py that is the wrapper script of page_fault1), which 
basically launches NR_CPU threads to generate 128MB anonymous pages for 
each thread,  on my virtual machine with congested HDD shows long tail 
latency is reduced significantly.

Without the patch
  page_fault1_thr-1490  [023]   129.311706: funcgraph_entry: #57377.796 
us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.369103: funcgraph_entry: 5.642us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.369119: funcgraph_entry: #1289.592 
us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.370411: funcgraph_entry: 4.957us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.370419: funcgraph_entry: 1.940us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.378847: funcgraph_entry: #1411.385 
us |  do_swap_page();
  page_fault1_thr-1490  [023]   129.380262: funcgraph_entry: 3.916us   
|  do_swap_page();
  page_fault1_thr-1490  [023]   129.380275: funcgraph_entry: #4287.751 
us |  do_swap_page();

With the patch
       runtest.py-1417  [020]   301.925911: funcgraph_entry: #9870.146 
us |  do_swap_page();
       runtest.py-1417  [020]   301.935785: funcgraph_entry: 9.802us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935799: funcgraph_entry: 3.551us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935806: funcgraph_entry: 2.142us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935853: funcgraph_entry: 6.938us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935864: funcgraph_entry: 3.765us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935871: funcgraph_entry: 3.600us   
|  do_swap_page();
       runtest.py-1417  [020]   301.935878: funcgraph_entry: 7.202us   
|  do_swap_page();


Thanks,
Yang



Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0F82082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 04:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F82082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeKEORF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:17:05 -0500
Received: from relay.sw.ru ([185.231.240.75]:37394 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbeKEORF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:17:05 -0500
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gJWyn-0006f6-VF; Mon, 05 Nov 2018 07:59:14 +0300
Subject: Re: [PATCH 1/2] mm: use kvzalloc for swap_info_struct allocation
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
References: <37b60523-d085-71e9-fef9-80b90bfcef18@virtuozzo.com>
 <87wopsbb5v.fsf@yhuang-dev.intel.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <f702278c-4e2f-a7fd-0e0a-150284ec8cc1@virtuozzo.com>
Date:   Mon, 5 Nov 2018 07:59:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87wopsbb5v.fsf@yhuang-dev.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/18 3:50 AM, Huang, Ying wrote:
> Vasily Averin <vvs@virtuozzo.com> writes:
> 
>> commit a2468cc9bfdf ("swap: choose swap device according to numa node")
>> increased size of swap_info_struct up to 44 Kbytes, now it requires
>> 4th order page.
> 
> Why swap_info_struct could be so large?  Because MAX_NUMNODES could be
> thousands so that 'avail_lists' field could be tens KB?  If so, I think
> it's fair to use kvzalloc().  Can you add one line comment?  Because
> struct swap_info_struct is quite small in default configuration.

I was incorrect not 44Kb but 40kb should be here.
We have found CONFIG_NODES_SHIFT=10 in new RHEL7 update 6 kernel,
default ubuntu kernels have the same setting too.

crash> struct swap_info_struct -o
struct swap_info_struct {
      [0] unsigned long flags;
      [8] short prio;
           ...
    [140] spinlock_t lock;
    [144] struct plist_node list;
    [184] struct plist_node avail_lists[1024]; <<<< here
  [41144] struct swap_cluster_info *cluster_info;
  [41152] struct swap_cluster_list free_clusters;
          ...
  [41224] spinlock_t cont_lock;
}
SIZE: 41232

struct swap_info_struct {
        ...
        RH_KABI_EXTEND(struct plist_node avail_lists[MAX_NUMNODES]) /* entry in swap_avail_head */
        ...
}

#define MAX_NUMNODES    (1 << NODES_SHIFT)

#ifdef CONFIG_NODES_SHIFT 
#define NODES_SHIFT     CONFIG_NODES_SHIFT
#else
#define NODES_SHIFT     0
#endif

/boot/config-4.15.0-38-generic:CONFIG_NODES_SHIFT=10


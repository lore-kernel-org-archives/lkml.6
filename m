Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3A920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3A920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeKEOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:34:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:25411 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeKEOeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:34:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="103430333"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2018 21:16:09 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 1/2] mm: use kvzalloc for swap_info_struct allocation
References: <37b60523-d085-71e9-fef9-80b90bfcef18@virtuozzo.com>
        <87wopsbb5v.fsf@yhuang-dev.intel.com>
        <f702278c-4e2f-a7fd-0e0a-150284ec8cc1@virtuozzo.com>
Date:   Mon, 05 Nov 2018 13:16:09 +0800
In-Reply-To: <f702278c-4e2f-a7fd-0e0a-150284ec8cc1@virtuozzo.com> (Vasily
        Averin's message of "Mon, 5 Nov 2018 07:59:13 +0300")
Message-ID: <878t28ayue.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> writes:

> On 11/5/18 3:50 AM, Huang, Ying wrote:
>> Vasily Averin <vvs@virtuozzo.com> writes:
>> 
>>> commit a2468cc9bfdf ("swap: choose swap device according to numa node")
>>> increased size of swap_info_struct up to 44 Kbytes, now it requires
>>> 4th order page.
>> 
>> Why swap_info_struct could be so large?  Because MAX_NUMNODES could be
>> thousands so that 'avail_lists' field could be tens KB?  If so, I think
>> it's fair to use kvzalloc().  Can you add one line comment?  Because
>> struct swap_info_struct is quite small in default configuration.
>
> I was incorrect not 44Kb but 40kb should be here.
> We have found CONFIG_NODES_SHIFT=10 in new RHEL7 update 6 kernel,
> default ubuntu kernels have the same setting too.
>
> crash> struct swap_info_struct -o
> struct swap_info_struct {
>       [0] unsigned long flags;
>       [8] short prio;
>            ...
>     [140] spinlock_t lock;
>     [144] struct plist_node list;
>     [184] struct plist_node avail_lists[1024]; <<<< here
>   [41144] struct swap_cluster_info *cluster_info;
>   [41152] struct swap_cluster_list free_clusters;
>           ...
>   [41224] spinlock_t cont_lock;
> }
> SIZE: 41232
>
> struct swap_info_struct {
>         ...
>         RH_KABI_EXTEND(struct plist_node avail_lists[MAX_NUMNODES]) /* entry in swap_avail_head */
>         ...
> }
>
> #define MAX_NUMNODES    (1 << NODES_SHIFT)
>
> #ifdef CONFIG_NODES_SHIFT 
> #define NODES_SHIFT     CONFIG_NODES_SHIFT
> #else
> #define NODES_SHIFT     0
> #endif
>
> /boot/config-4.15.0-38-generic:CONFIG_NODES_SHIFT=10

I see.  So this is a more practical issue than my original imagination.

But for default config, I mean

$ make defconfig

And it turns out,

CONFIG_NODES_SHIFT=6

Best Regards,
Huang, Ying

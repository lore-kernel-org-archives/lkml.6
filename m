Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ADAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27A204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeKEP2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:28:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:21547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbeKEP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:28:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 22:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="247016571"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2018 22:10:16 -0800
Date:   Mon, 5 Nov 2018 14:10:16 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: use kvzalloc for swap_info_struct allocation
Message-ID: <20181105061016.GA4502@intel.com>
References: <37b60523-d085-71e9-fef9-80b90bfcef18@virtuozzo.com>
 <87wopsbb5v.fsf@yhuang-dev.intel.com>
 <f702278c-4e2f-a7fd-0e0a-150284ec8cc1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f702278c-4e2f-a7fd-0e0a-150284ec8cc1@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 07:59:13AM +0300, Vasily Averin wrote:
> 
> 
> On 11/5/18 3:50 AM, Huang, Ying wrote:
> > Vasily Averin <vvs@virtuozzo.com> writes:
> > 
> >> commit a2468cc9bfdf ("swap: choose swap device according to numa node")
> >> increased size of swap_info_struct up to 44 Kbytes, now it requires
> >> 4th order page.
> > 
> > Why swap_info_struct could be so large?  Because MAX_NUMNODES could be
> > thousands so that 'avail_lists' field could be tens KB?  If so, I think
> > it's fair to use kvzalloc().  Can you add one line comment?  Because
> > struct swap_info_struct is quite small in default configuration.
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

So every 'struct plist_node' takes 40 bytes and 1024 of them take a
total of 40960 bytes, which is 10 pages and need an order-4 page to host
them. It looks a little too much, especially consider most of the space
will left be unused since most systems have nodes <= 4. I didn't realize
this problem when developing this patch, thanks for pointing this out.

I think using kvzalloc() as is done by your patch is better here as it
can avoid possible failure of swapon.

Acked-by: Aaron Lu <aaron.lu@intel.com>

BTW, for systems with few swap devices this may not be a big deal, but
according to your description, your workload will create a lot of swap
devices and each of them will likely cause an order-4 unmovable pages
allocated(when kvzalloc() doesn't fallback). I was thinking maybe we
should convert avail_lists to a pointer in swap_info_struct and use
vzalloc() for it.

Thanks,
Aaron

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
> 

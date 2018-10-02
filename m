Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C6DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C3721471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C3721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeJCBMk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJCBMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:12:39 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A77030020A1;
        Tue,  2 Oct 2018 18:27:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56A3F9D814;
        Tue,  2 Oct 2018 18:27:57 +0000 (UTC)
Subject: Re: [RFC, PATCH] ipc/util.c: use idr_alloc_cyclic() for ipc
 allocations
To:     Manfred Spraul <manfred@colorfullife.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20181002161942.1037-1-manfred@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1b8bcd5c-1264-08da-0b91-ebb4c02f6035@redhat.com>
Date:   Tue, 2 Oct 2018 14:27:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181002161942.1037-1-manfred@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 02 Oct 2018 18:27:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 12:19 PM, Manfred Spraul wrote:
> A bit related to the patch series that increases IPC_MNI:
>
> (User space) id reuse create the risk of data corruption:
>
> Process A: calls ipc function
> Process A: sleeps just at the beginning of the syscall
> Process B: Frees the ipc object (i.e.: calls ...ctl(IPC_RMID)
> Process B: Creates a new ipc object (i.e.: calls ...get())
> 	<If new object and old object have the same id>
> Process A: is woken up, and accesses the new object
>
> To reduce the probability that the new and the old object
> have the same id, the current implementation adds a
> sequence number to the index of the object in the idr tree.
>
> To further reduce the probability for a reuse, switch from
> idr_alloc to idr_alloc_cyclic.
>
> The patch cycles over at least RADIX_TREE_MAP_SIZE, i.e.
> if there is only a small number of objects, the accesses
> continue to be direct.
>
> As an option, this could be made dependent on the extended
> mode: In extended mode, cycle over e.g. at least 16k ids.
>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>
> Open questions:
> - Is there a significant performance advantage, especially
>   there are many ipc ids?
> - Over how many ids should the code cycle always?
> - Further review remarks?
>
>  ipc/util.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/ipc/util.c b/ipc/util.c
> index 0af05752969f..6f83841f6761 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -216,10 +216,30 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>  	 */
>  
>  	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
> +		int idr_max;
> +
>  		new->seq = ids->seq++;
>  		if (ids->seq > IPCID_SEQ_MAX)
>  			ids->seq = 0;
> -		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
> +
> +		/*
> +		 * If a user space visible id is reused, then this creates a
> +		 * risk for data corruption. To reduce the probability that
> +		 * a number is reduced, two approaches are used:
  reduced -> reused?

> +		 * 1) the idr index is allocated cyclically.
> +		 * 2) the use space id is build by concatenating the
> +		 *    internal idr index with a sequence number
> +		 * To avoid that both numbers have the same cycle time, try
> +		 * to set the size for the cyclic alloc to an odd number.
> +		 */
> +		idr_max = ids->in_use*2+1;
> +		if (idr_max < RADIX_TREE_MAP_SIZE-1)
> +			idr_max = RADIX_TREE_MAP_SIZE-1;
> +		if (idr_max > IPCMNI)
> +			idr_max = IPCMNI;
> +
> +		idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, idr_max,
> +					GFP_NOWAIT);
>  	} else {
>  		new->seq = ipcid_to_seqx(next_id);
>  		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),


Each of IPC components have their own sysctl parameters limiting the max
number of objects that can be allocated. With cyclic allocation, you
will have to make sure that idr_max is not larger than the corresponding
IPC sysctl parameters. That may require moving the limits to the
corresponding ipc_ids structure so that it can be used in ipc_idr_alloc().

What is the point of comparing idr_max against RADIX_TREE_MAP_SIZE-1? Is
it for performance reason.

Cheers,
Longman



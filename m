Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F97205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F97205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbeG0Td1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:33:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388344AbeG0Td1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD2CC8197011;
        Fri, 27 Jul 2018 18:10:24 +0000 (UTC)
Received: from treble (ovpn-120-105.rdu2.redhat.com [10.10.120.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 561901C5BA;
        Fri, 27 Jul 2018 18:10:24 +0000 (UTC)
Date:   Fri, 27 Jul 2018 13:10:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: mballoc: Fix spectre gadget in
 ext4_mb_simple_scan_group
Message-ID: <20180727181022.zjz3lwagugitwt5m@treble>
References: <20180727162357.30801-1-jcline@redhat.com>
 <20180727162357.30801-4-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727162357.30801-4-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 18:10:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 18:10:24 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:23:57PM +0000, Jeremy Cline wrote:
> 'ac->ac_2order' is a user-controlled value used to index into
> 'grp->bb_counters' and based on the value at that index, 'ac->ac_found'
> is written to. Clamp the value right after the bounds check to avoid a
> speculative out-of-bounds read of 'grp->bb_counters'.
> 
> This also protects the access of the s_mb_offsets and s_mb_maxs arrays
> inside mb_find_buddy().
> 
> These gadgets were discovered with the help of smatch:
> 
> * fs/ext4/mballoc.c:1896 ext4_mb_simple_scan_group() warn: potential
>   spectre issue 'grp->bb_counters' [w] (local cap)
> 
> * fs/ext4/mballoc.c:445 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_offsets' [r] (local cap)
> 
> * fs/ext4/mballoc.c:446 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_maxs' [r] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  fs/ext4/mballoc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f7ab34088162..c0866007a949 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -14,6 +14,7 @@
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/nospec.h>
>  #include <linux/backing-dev.h>
>  #include <trace/events/ext4.h>
>  
> @@ -1893,6 +1894,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
>  
>  	BUG_ON(ac->ac_2order <= 0);
>  	for (i = ac->ac_2order; i <= sb->s_blocksize_bits + 1; i++) {
> +		i = array_index_nospec(i, sb->s_blocksize_bits + 2);
>  		if (grp->bb_counters[i] == 0)
>  			continue;

Similar to my patch 1 comment, it's better to go up the call chain.

ac_2order's user taint seems to come from ext4_mb_regular_allocator(),
where it's derived from ac->ac_g_ex.fe_len, which has a user taint
according to smatch.

	i = fls(ac->ac_g_ex.fe_len);
	ac->ac_2order = 0;
	/*
	 * We search using buddy data only if the order of the request
	 * is greater than equal to the sbi_s_mb_order2_reqs
	 * You can tune it via /sys/fs/ext4/<partition>/mb_order2_req
	 * We also support searching for power-of-two requests only for
	 * requests upto maximum buddy size we have constructed.
	 */
	if (i >= sbi->s_mb_order2_reqs && i <= sb->s_blocksize_bits + 2) {
		/*
		 * This should tell if fe_len is exactly power of 2
		 */
		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
			ac->ac_2order = i - 1;
	}

So here maybe you could change the assignment to:

			ac->ac_2order = array_index_nospec(i - 1,
							   sb->s_blocksize_bits + 2);

That makes it easier for a reader of the code to understand what
speculation we're protecting against.  And it also protects other
consumers of this value down the call chain.

-- 
Josh

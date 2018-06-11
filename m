Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PPiBJSomHluVfAAAmS7hNA
	; Mon, 11 Jun 2018 07:35:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8700B607E7; Mon, 11 Jun 2018 07:35:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8275060792;
	Mon, 11 Jun 2018 07:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8275060792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbeFKHfB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:35:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37497 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932230AbeFKHfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:35:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20326AD0B;
        Mon, 11 Jun 2018 07:34:59 +0000 (UTC)
Date: Mon, 11 Jun 2018 09:34:58 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: fix null pointer dereference in mem_cgroup_protected
Message-ID: <20180611073458.GD13364@dhcp22.suse.cz>
References: <20180608170607.29120-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608170607.29120-1-guro@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-06-18 18:06:07, Roman Gushchin wrote:
> Shakeel reported a crash in mem_cgroup_protected(), which
> can be triggered by memcg reclaim if the legacy cgroup v1
> use_hierarchy=0 mode is used:
> 
> [  226.060572] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000120
> [  226.068310] PGD 8000001ff55da067 P4D 8000001ff55da067 PUD 1fdc7df067 PMD 0
> [  226.075191] Oops: 0000 [#4] SMP PTI
> [  226.078637] CPU: 0 PID: 15581 Comm: bash Tainted: G      D
>  4.17.0-smp-clean #5
> [  226.086635] Hardware name: ...
> [  226.094546] RIP: 0010:mem_cgroup_protected+0x54/0x130
> [  226.099533] Code: 4c 8b 8e 00 01 00 00 4c 8b 86 08 01 00 00 48 8d
> 8a 08 ff ff ff 48 85 d2 ba 00 00 00 00 48 0f 44 ca 48 39 c8 0f 84 cf
> 00 00 00 <48> 8b 81 20 01 00 00 4d 89 ca 4c 39 c8 4c 0f 46 d0 4d 85 d2
> 74 05
> [  226.118194] RSP: 0000:ffffabe64dfafa58 EFLAGS: 00010286
> [  226.123358] RAX: ffff9fb6ff03d000 RBX: ffff9fb6f5b1b000 RCX: 0000000000000000
> [  226.130406] RDX: 0000000000000000 RSI: ffff9fb6f5b1b000 RDI: ffff9fb6f5b1b000
> [  226.137454] RBP: ffffabe64dfafb08 R08: 0000000000000000 R09: 0000000000000000
> [  226.144503] R10: 0000000000000000 R11: 000000000000c800 R12: ffffabe64dfafb88
> [  226.151551] R13: ffff9fb6f5b1b000 R14: ffffabe64dfafb88 R15: ffff9fb77fffe000
> [  226.158602] FS:  00007fed1f8ac700(0000) GS:ffff9fb6ff400000(0000)
> knlGS:0000000000000000
> [  226.166594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  226.172270] CR2: 0000000000000120 CR3: 0000001fdcf86003 CR4: 00000000001606f0
> [  226.179317] Call Trace:
> [  226.181732]  ? shrink_node+0x194/0x510
> [  226.185435]  do_try_to_free_pages+0xfd/0x390
> [  226.189653]  try_to_free_mem_cgroup_pages+0x123/0x210
> [  226.194643]  try_charge+0x19e/0x700
> [  226.198088]  mem_cgroup_try_charge+0x10b/0x1a0
> [  226.202478]  wp_page_copy+0x134/0x5b0
> [  226.206094]  do_wp_page+0x90/0x460
> [  226.209453]  __handle_mm_fault+0x8e3/0xf30
> [  226.213498]  handle_mm_fault+0xfe/0x220
> [  226.217285]  __do_page_fault+0x262/0x500
> [  226.221158]  do_page_fault+0x28/0xd0
> [  226.224689]  ? page_fault+0x8/0x30
> [  226.228048]  page_fault+0x1e/0x30
> [  226.231323] RIP: 0033:0x485b72
> 
> The problem happens because parent_mem_cgroup() returns a NULL
> pointer, which is dereferenced later without a check.
> 
> As cgroup v1 has no memory guarantee support, let's make
> mem_cgroup_protected() immediately return MEMCG_PROT_NONE,
> if the given cgroup has no parent (non-hierarchical mode is used).
> 

Fixes: bf8d5d52ffe8 ("memcg: introduce memory.min")

I guess.

> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michal Hocko <mhocko@suse.com>

I really do not see why the whole min limit thing had to be rushed into
mainline. It has clearly not been tested for all configurations. Sigh...

> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6c9fb4e47be3..6205ba512928 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5750,6 +5750,9 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	elow = memcg->memory.low;
>  
>  	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		return MEMCG_PROT_NONE;
> +

This deserves a comment.
	/* No parent means a non-hierarchical mode on v1 memcg */

>  	if (parent == root_mem_cgroup)
>  		goto exit;
>  
> -- 
> 2.14.3

-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765EA20838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfBRJ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:57:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:34494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727414AbfBRJ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:57:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 861A3ABE3;
        Mon, 18 Feb 2019 09:57:20 +0000 (UTC)
Subject: Re: mremap vs sysctl_max_map_count
To:     Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hughd@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org
References: <20190218083326.xsnx7cx2lxurbmux@d104.suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <a11a10b5-4a31-2537-7b14-83f4b22e5f6c@suse.cz>
Date:   Mon, 18 Feb 2019 10:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218083326.xsnx7cx2lxurbmux@d104.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 9:33 AM, Oscar Salvador wrote:
> 
> Hi all,
> 
> I would like to bring up a topic that comes from an issue a customer of ours
> is facing with the mremap syscall + hitting the max_map_count threshold:
> 
> When passing the MREMAP_FIXED flag, mremap() calls mremap_to() which does the
> following:
> 
> 1) it unmaps the region where we want to put the new map:
>    (new_addr, new_addr + new_len] [1]
> 2) IFF old_len > new_len, it unmaps the region:
>    (old_addr + new_len, (old_addr + new_len) + (old_len - new_len)] [2]
> 
> Now, having gone through steps 1) and 2), we eventually call move_vma() to do
> the actual move.
> 
> move_vma() checks if we are at least 4 maps below max_map_count, otherwise
> it bails out with -ENOMEM [3].
> The problem is that we might have already unmapped the vma's in steps 1) and 2),
> so it is not possible for userspace to figure out the state of the vma's after
> it gets -ENOMEM.
> 
> - Did new_addr got unmaped?
> - Did part of the old_addr got unmaped?
> 
> Because of that, it gets tricky for userspace to clean up properly on error
> path.
> 
> While it is true that we can return -ENOMEM for more reasons
> (e.g: see vma_to_resize()->may_expand_vm()), I think that we might be able to
> pre-compute the number of maps that we are going add/release during the first
> two do_munmaps(), and check whether we are 4 maps below the threshold
> (as move_vma() does).
> Should not be the case, we can bail out early before we unmap anything, so we
> make sure the vma's are left untouched in case we are going to be short of maps.
> 
> I am not sure if that is realistically doable, or there are limitations
> I overlooked, or we simply do not want to do that.

IMHO it makes sense to do all such resource limit checks upfront. It
should all be protected by mmap_sem and thus stable, right? Even if it
was racy, I'd think it's better to breach the limit a bit due to a race
than bail out in the middle of operation. Being also resilient against
"real" ENOMEM's due to e.g. failure to alocate a vma would be much
harder perhaps (but maybe it's already mostly covered by the
too-small-to-fail in page allocator), but I'd try with the artificial
limits at least.

> Before investing more time and giving it a shoot, I just wanted to bring
> this upstream to get feedback on this matter.
> 
> Thanks
> 
> [1] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L519
> [2] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L523
> [3] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L338
> 


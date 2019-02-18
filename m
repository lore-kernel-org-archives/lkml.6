Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16822184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbfBRIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:33:35 -0500
Received: from nat.nue.novell.com ([195.135.221.2]:24772 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728342AbfBRIdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:33:35 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 46E2C42F1; Mon, 18 Feb 2019 09:33:32 +0100 (CET)
Date:   Mon, 18 Feb 2019 09:33:31 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hughd@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org
Subject: mremap vs sysctl_max_map_count
Message-ID: <20190218083326.xsnx7cx2lxurbmux@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I would like to bring up a topic that comes from an issue a customer of ours
is facing with the mremap syscall + hitting the max_map_count threshold:

When passing the MREMAP_FIXED flag, mremap() calls mremap_to() which does the
following:

1) it unmaps the region where we want to put the new map:
   (new_addr, new_addr + new_len] [1]
2) IFF old_len > new_len, it unmaps the region:
   (old_addr + new_len, (old_addr + new_len) + (old_len - new_len)] [2]

Now, having gone through steps 1) and 2), we eventually call move_vma() to do
the actual move.

move_vma() checks if we are at least 4 maps below max_map_count, otherwise
it bails out with -ENOMEM [3].
The problem is that we might have already unmapped the vma's in steps 1) and 2),
so it is not possible for userspace to figure out the state of the vma's after
it gets -ENOMEM.

- Did new_addr got unmaped?
- Did part of the old_addr got unmaped?

Because of that, it gets tricky for userspace to clean up properly on error
path.

While it is true that we can return -ENOMEM for more reasons
(e.g: see vma_to_resize()->may_expand_vm()), I think that we might be able to
pre-compute the number of maps that we are going add/release during the first
two do_munmaps(), and check whether we are 4 maps below the threshold
(as move_vma() does).
Should not be the case, we can bail out early before we unmap anything, so we
make sure the vma's are left untouched in case we are going to be short of maps.

I am not sure if that is realistically doable, or there are limitations
I overlooked, or we simply do not want to do that.

Before investing more time and giving it a shoot, I just wanted to bring
this upstream to get feedback on this matter.

Thanks

[1] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L519
[2] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L523
[3] https://github.com/torvalds/linux/blob/master/mm/mremap.c#L338

-- 
Oscar Salvador
SUSE L3

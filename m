Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB62C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B72073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfACIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:36:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:55062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfACIg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:36:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44418AE23;
        Thu,  3 Jan 2019 08:36:56 +0000 (UTC)
Subject: Re: KMSAN: uninit-value in mpol_rebind_mm
To:     syzbot <syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org, glider@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com
References: <000000000000c06550057e4cac7c@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <a71997c3-e8ae-a787-d5ce-3db05768b27c@suse.cz>
Date:   Thu, 3 Jan 2019 09:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <000000000000c06550057e4cac7c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/31/18 8:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    79fc24ff6184 kmsan: highmem: use kmsan_clear_page() in cop..
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c48b67400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=901dd030b2cc57e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=b19c2dc2c990ea657a71
> compiler:       clang version 8.0.0 (trunk 349734)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b19c2dc2c990ea657a71@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:353 [inline]
> BUG: KMSAN: uninit-value in mpol_rebind_mm+0x249/0x370 mm/mempolicy.c:384

The report doesn't seem to indicate where the uninit value resides in
the mempolicy object. I'll have to guess. mm/mempolicy.c:353 contains:

        if (!mpol_store_user_nodemask(pol) &&
            nodes_equal(pol->w.cpuset_mems_allowed, *newmask))

"mpol_store_user_nodemask(pol)" is testing pol->flags, which I couldn't
see being uninitialized after leaving mpol_new(). So I'll guess it's
actually about accessing pol->w.cpuset_mems_allowed on line 354.

For w.cpuset_mems_allowed to be not initialized and the nodes_equal()
reachable for a mempolicy where mpol_set_nodemask() is called in
do_mbind(), it seems the only possibility is a MPOL_PREFERRED policy
with empty set of nodes, i.e. MPOL_LOCAL equivalent. Let's see if the
patch below helps. This code is a maze to me. Note the uninit access
should be benign, rebinding this kind of policy is always a no-op.

----8<----
From ff0ca29da6bc2572d7b267daa77ced6083e3f02d Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 3 Jan 2019 09:31:59 +0100
Subject: [PATCH] mm, mempolicy: fix uninit memory access

---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d4496d9d34f5..a0b7487b9112 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -350,7 +350,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) &&
+	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 
-- 
2.19.2

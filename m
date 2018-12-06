Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544097706;
	bh=syq9P1eHuALHNRddiJ9oM76nPam1XXOr5AyQT013scA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0qPBySiQgtd5B4euCVCwF6p9r/YycXYYG8h84EVoN1I/s1FXNpiNLi1n93+s8K1Ha
	 mxyBg+p5oodzZf2L9jS4YbHlU8nDcMUcUt6Re/GQjoruFWc8ai/+Yd0U/Tf9ySO6oh
	 d2tqbIvijwg18+N3GdEjm5V1vsLrJEULTykAa6is=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeLFMBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:01:45 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40924 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeLFMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:01:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so533999edx.7;
        Thu, 06 Dec 2018 04:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5TkJhql5OBpvOowGb/KHk5rTWf30x5NqRh/BRHPLBw=;
        b=Y+de0W23ZN5Ph209xQU1akj5qP0OyROPjt6Dk8+F/xCMhvlq5UgDdDmtB23h42u0wO
         553IzL3dbT5eCP4JykllC5WYItM/tpyPteXTYpeRau6CwItRgeZ0RKu+cM08t7tdZBvU
         4OjP5xE5/EfWl2cDVuscl1pGbHGqmC9SZgKCRZq21UVXAiNlfzFvtnTvYPrjS9pg5iyf
         4B3huvxF0DRyaIbyGUC6xOam14gFffx+kpWf1zajuIzAujt56I26xch3v5/jjvpOZPAY
         gGaeEF1jE6JrzlHIX8NwyqJaFzw9amISmTmQBALuZiX9STGx/H3xCUGF1/FBbCrELM0B
         WiCg==
X-Gm-Message-State: AA+aEWatpEyYN1Th0C1whugxcoS8WmD5UuaNTh9NieIrb87CBu9vPFtY
        lhGIKtrDdziyaOCRE7HUcyv94FB9
X-Google-Smtp-Source: AFSGD/Wgk26DD5g8zxqrAg+P8SpaJgqXq/W6GG12mOCYTftAGV+enenI1QRvAYmlKEh3dx/WRciFow==
X-Received: by 2002:a50:8719:: with SMTP id i25mr25219515edb.53.1544097702144;
        Thu, 06 Dec 2018 04:01:42 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p30sm131273eda.68.2018.12.06.04.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:01:41 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
Date:   Thu,  6 Dec 2018 13:01:35 +0100
Message-Id: <20181206120135.14079-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have received a bug report that an injected MCE about faulty memory
prevents memory offline to succeed on 4.4 base kernel. The underlying
reason was that the HWPoison page has an elevated reference count and
the migration keeps failing. There are two problems with that. First
of all it is dubious to migrate the poisoned page because we know that
accessing that memory is possible to fail. Secondly it doesn't make any
sense to migrate a potentially broken content and preserve the memory
corruption over to a new location.

Oscar has found out that 4.4 and the current upstream kernels behave
slightly differently with his simply testcase
===

int main(void)
{
        int ret;
        int i;
        int fd;
        char *array = malloc(4096);
        char *array_locked = malloc(4096);

        fd = open("/tmp/data", O_RDONLY);
        read(fd, array, 4095);

        for (i = 0; i < 4096; i++)
                array_locked[i] = 'd';

        ret = mlock((void *)PAGE_ALIGN((unsigned long)array_locked), sizeof(array_locked));
        if (ret)
                perror("mlock");

        sleep (20);

        ret = madvise((void *)PAGE_ALIGN((unsigned long)array_locked), 4096, MADV_HWPOISON);
        if (ret)
                perror("madvise");

        for (i = 0; i < 4096; i++)
                array_locked[i] = 'd';

        return 0;
}
===

+ offline this memory.

In 4.4 kernels he saw the hwpoisoned page to be returned back to the LRU
list
kernel:  [<ffffffff81019ac9>] dump_trace+0x59/0x340
kernel:  [<ffffffff81019e9a>] show_stack_log_lvl+0xea/0x170
kernel:  [<ffffffff8101ac71>] show_stack+0x21/0x40
kernel:  [<ffffffff8132bb90>] dump_stack+0x5c/0x7c
kernel:  [<ffffffff810815a1>] warn_slowpath_common+0x81/0xb0
kernel:  [<ffffffff811a275c>] __pagevec_lru_add_fn+0x14c/0x160
kernel:  [<ffffffff811a2eed>] pagevec_lru_move_fn+0xad/0x100
kernel:  [<ffffffff811a334c>] __lru_cache_add+0x6c/0xb0
kernel:  [<ffffffff81195236>] add_to_page_cache_lru+0x46/0x70
kernel:  [<ffffffffa02b4373>] extent_readpages+0xc3/0x1a0 [btrfs]
kernel:  [<ffffffff811a16d7>] __do_page_cache_readahead+0x177/0x200
kernel:  [<ffffffff811a18c8>] ondemand_readahead+0x168/0x2a0
kernel:  [<ffffffff8119673f>] generic_file_read_iter+0x41f/0x660
kernel:  [<ffffffff8120e50d>] __vfs_read+0xcd/0x140
kernel:  [<ffffffff8120e9ea>] vfs_read+0x7a/0x120
kernel:  [<ffffffff8121404b>] kernel_read+0x3b/0x50
kernel:  [<ffffffff81215c80>] do_execveat_common.isra.29+0x490/0x6f0
kernel:  [<ffffffff81215f08>] do_execve+0x28/0x30
kernel:  [<ffffffff81095ddb>] call_usermodehelper_exec_async+0xfb/0x130
kernel:  [<ffffffff8161c045>] ret_from_fork+0x55/0x80

And that later confuses the hotremove path because an LRU page is
attempted to be migrated and that fails due to an elevated reference
count. It is quite possible that the reuse of the HWPoisoned page is
some kind of fixed race condition but I am not really sure about that.

With the upstream kernel the failure is slightly different. The page
doesn't seem to have LRU bit set but isolate_movable_page simply fails
and do_migrate_range simply puts all the isolated pages back to LRU and
therefore no progress is made and scan_movable_pages finds same set of
pages over and over again.

Fix both cases by explicitly checking HWPoisoned pages before we even
try to get a reference on the page, try to unmap it if it is still
mapped. As explained by Naoya
: Hwpoison code never unmapped those for no big reason because
: Ksm pages never dominate memory, so we simply didn't have strong
: motivation to save the pages.

Also put WARN_ON(PageLRU) in case there is a race and we can hit LRU
HWPoison pages which shouldn't happen but I couldn't convince myself
about that. Naoya has noted the following
: Theoretically no such gurantee, because try_to_unmap() doesn't have a
: guarantee of success and then memory_failure() returns immediately
: when hwpoison_user_mappings fails.
: Or the following code (comes after hwpoison_user_mappings block) also impli=
: es
: that the target page can still have PageLRU flag.
:
:         /*
:          * Torn down by someone else?
:          */
:         if (PageLRU(p) && !PageSwapCache(p) && p->mapping =3D=3D NULL) {
:                 action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
:                 res =3D -EBUSY;
:                 goto out;
:         }
:
: So I think it's OK to keep "if (WARN_ON(PageLRU(page)))" block in
: current version of your patch.

Debugged-by: Oscar Salvador <osalvador@suse.com>
Cc: stable
Reviewed-by: Oscar Salvador <osalvador@suse.com>
Tested-by: Oscar Salvador <osalvador@suse.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi Andrew,
this has been posted as an RFC [1] previously. It took 2 versions to get
the patch right but it seems that this one should work reasonably well.
I guess we want to have it in linux-next for some time but I do not
expect many people do test MCEs + hotremove considering the breakage is
old and nobody has noticed so far.

[1] http://lkml.kernel.org/r/20181203100309.14784-1-mhocko@kernel.org

 mm/memory_hotplug.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c6c42a7425e5..cfa1a2736876 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -34,6 +34,7 @@
 #include <linux/hugetlb.h>
 #include <linux/memblock.h>
 #include <linux/compaction.h>
+#include <linux/rmap.h>
 
 #include <asm/tlbflush.h>
 
@@ -1366,6 +1367,21 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			pfn = page_to_pfn(compound_head(page))
 				+ hpage_nr_pages(page) - 1;
 
+		/*
+		 * HWPoison pages have elevated reference counts so the migration would
+		 * fail on them. It also doesn't make any sense to migrate them in the
+		 * first place. Still try to unmap such a page in case it is still mapped
+		 * (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
+		 * the unmap as the catch all safety net).
+		 */
+		if (PageHWPoison(page)) {
+			if (WARN_ON(PageLRU(page)))
+				isolate_lru_page(page);
+			if (page_mapped(page))
+				try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS);
+			continue;
+		}
+
 		if (!get_page_unless_zero(page))
 			continue;
 		/*
-- 
2.19.2


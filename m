Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E7FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685C2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZlYIkAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E685C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbeKTC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKTC7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017AD208E3;
        Mon, 19 Nov 2018 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645325;
        bh=uRHbX74fV5Gyh/80OMCnUyH2EqVtsdo38R7N3OhS/LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZlYIkAZsE5KFjgSE3vX51BfDhNS9wyJ5qpeETjg2Kuw0Tel/S4WowX5+yCz4XI0z
         3AFROxnR/AUbzWoJIFb9PZjQKFvF95ClvbnxYH+NxM1ehaDWw/Cpu2J7JkHB+GGkF1
         V11cP3uz1O34LT3G0/CP3+x2EpHPKMIYaoTp5GYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 104/205] memory_hotplug: cond_resched in __remove_pages
Date:   Mon, 19 Nov 2018 17:26:51 +0100
Message-Id: <20181119162633.735472358@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit dd33ad7b251f900481701b2a82d25de583867708 upstream.

We have received a bug report that unbinding a large pmem (>1TB) can
result in a soft lockup:

  NMI watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [ndctl:4365]
  [...]
  Supported: Yes
  CPU: 9 PID: 4365 Comm: ndctl Not tainted 4.12.14-94.40-default #1 SLE12-SP4
  Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
  task: ffff9cce7d4410c0 task.stack: ffffbe9eb1bc4000
  RIP: 0010:__put_page+0x62/0x80
  Call Trace:
   devm_memremap_pages_release+0x152/0x260
   release_nodes+0x18d/0x1d0
   device_release_driver_internal+0x160/0x210
   unbind_store+0xb3/0xe0
   kernfs_fop_write+0x102/0x180
   __vfs_write+0x26/0x150
   vfs_write+0xad/0x1a0
   SyS_write+0x42/0x90
   do_syscall_64+0x74/0x150
   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
  RIP: 0033:0x7fd13166b3d0

It has been reported on an older (4.12) kernel but the current upstream
code doesn't cond_resched in the hot remove code at all and the given
range to remove might be really large.  Fix the issue by calling
cond_resched once per memory section.

Link: http://lkml.kernel.org/r/20181031125840.23982-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Dan Williams <dan.j.williams@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory_hotplug.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -587,6 +587,7 @@ int __remove_pages(struct zone *zone, un
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
 
+		cond_resched();
 		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
 				altmap);
 		map_offset = 0;



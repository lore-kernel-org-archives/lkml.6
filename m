Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C03C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C5720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeJaV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:57:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38955 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:57:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5-v6so13511773eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0Kz97Mz2sEmViRrO4SLpsnIpXFB+vaEvmsFGBYKUaI=;
        b=WwUQ4wyLNxlCuQW4OITfVhz5W/JBdCM6y9GpSWFW0C1ryfqQo7k590goSq7m33IYdA
         C6HuGaHuBTmiVJD37p+56/O4GfD6zEG9FKA+RXS1PDDKBGtCf8SsEv4/lFkmQs1BYIpf
         SKLTMxoAwMMYl7t66LU8KrtrZN1VSlOj0Wwn8KGI81QW57zX5/8xy4IwpC9Q/4++JD2h
         BqqKblOuAyS1b/kd7l52GwSsk3bIgoJCwRJEEunFNM1YHMie80+ulmk4Ti0im/3M458s
         XrRkXS+t1FPLJ2PM9aR3I5Libz6fQm//+T08kOjoRPIHlH4wgLrtmDU/kn/+H5vhS7Zi
         l4lw==
X-Gm-Message-State: AGRZ1gIZizk6/VPFJ/tc3b+7MpnYenl4szylPaHJLz0vlV7RRkWH/1bp
        TRbF+F00atX28+BwUhrvGqU=
X-Google-Smtp-Source: AJdET5edQ/BfT9xyMnM7Hy1SH594rplvXtvRVQmxwTHvPW9Yh/5fY5Pt3r7ig4osWYN1yskEeQ9AXg==
X-Received: by 2002:a17:906:90d9:: with SMTP id v25-v6mr1490567ejw.214.1540990754933;
        Wed, 31 Oct 2018 05:59:14 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r19-v6sm4212562edp.17.2018.10.31.05.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:59:13 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memory_hotplug: cond_resched in __remove_pages
Date:   Wed, 31 Oct 2018 13:58:40 +0100
Message-Id: <20181031125840.23982-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have received a bug report that unbinding a large pmem (>1TB)
can result in a soft lockup:
[  380.339203] NMI watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [ndctl:4365]
[...]
[  380.339316] Supported: Yes
[  380.339318] CPU: 9 PID: 4365 Comm: ndctl Not tainted 4.12.14-94.40-default #1 SLE12-SP4
[  380.339318] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
[  380.339319] task: ffff9cce7d4410c0 task.stack: ffffbe9eb1bc4000
[  380.339325] RIP: 0010:__put_page+0x62/0x80
[  380.339326] RSP: 0018:ffffbe9eb1bc7d30 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff10
[  380.339327] RAX: 000040540081c0d3 RBX: ffffeb8f03557200 RCX: 000063af40000000
[  380.339328] RDX: 0000000000000002 RSI: ffff9cce75bff498 RDI: ffff9e4a76072ff8
[  380.339329] RBP: 0000000a43557200 R08: 0000000000000000 R09: ffffbe9eb1bc7bb0
[  380.339329] R10: ffffbe9eb1bc7d08 R11: 0000000000000000 R12: ffff9e194a22a0e0
[  380.339330] R13: ffff9cce7062fc10 R14: ffff9e194a22a0a0 R15: ffff9cce6559c0e0
[  380.339331] FS:  00007fd132368880(0000) GS:ffff9cce7ea40000(0000) knlGS:0000000000000000
[  380.339332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  380.339332] CR2: 00000000020820a0 CR3: 000000017ef7a003 CR4: 00000000007606e0
[  380.339333] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  380.339334] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  380.339334] PKRU: 55555554
[  380.339334] Call Trace:
[  380.339338]  devm_memremap_pages_release+0x152/0x260
[  380.339342]  release_nodes+0x18d/0x1d0
[  380.339347]  device_release_driver_internal+0x160/0x210
[  380.339350]  unbind_store+0xb3/0xe0
[  380.339355]  kernfs_fop_write+0x102/0x180
[  380.339358]  __vfs_write+0x26/0x150
[  380.339363]  ? security_file_permission+0x3c/0xc0
[  380.339364]  vfs_write+0xad/0x1a0
[  380.339366]  SyS_write+0x42/0x90
[  380.339370]  do_syscall_64+0x74/0x150
[  380.339375]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  380.339377] RIP: 0033:0x7fd13166b3d0

It has been reported on an older (4.12) kernel but the current upstream
code doesn't cond_resched in the hot remove code at all and the given
range to remove might be really large. Fix the issue by calling cond_resched
once per memory section.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7e6509a53d79..1d87724fa558 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -587,6 +587,7 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
 
+		cond_resched();
 		ret = __remove_section(zone, __pfn_to_section(pfn), map_offset,
 				altmap);
 		map_offset = 0;
-- 
2.19.1


Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-399776-1518794502-2-15620482346977273514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518794502; b=tx4raLxLl8Us9XxK/ut5K/pbtkj6lXuxXT9jbhlCS9L8+Gz
    vr/+uwdjwNNPMzFS/+60upAlbk6VgHP3VwFz/yGfqfAU3ZKy5mAAslBYlj3Y7SRk
    r1fFF4CeoxTv160qSkI9rPsV1HwhXV9YDQSlm1gMmr0vivNSKvMsxq3FMKGY79Ks
    dNOG0HJhXgJMJ98XM4egEPC1dBOL2hnoTjpPlCHmI9vuDa9aCx0xJWocUt4sfqnn
    oAjRhbEuA/yQfepPdmbv3gXnqJaXIKxkEckTEsCHR+P5OG/hY98bLmKuhW8KIi0v
    lj34Y2pRUg1AWEzyuhpQR4OkS1QuzP0ntqIIaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518794502; bh=QxnBRRdo4X+zfZ46XzgWoFZ0RX
    X/5gllOtUYYmgR8S0=; b=rZgSHgByZPo3CE2dml0szF4smiy5S3U8cs+d2WoMYD
    Mh8YczvEKKjk2mZ+DfVCiFxcNeL06e/XOPjjXtYGhjawigPRZpoMXNoEf2XbdrCi
    d0maTcSF/sa/xMSlnpuwn/MwhvMKufpcwun7XP07KRTwJM7NdOcYYPSrLFPBhAjI
    /aMiMt0hMFfY8kd/sRMqdipONSg5QXiCU51ltxV6DHajSShOQjqlWixQ/7gHaNTJ
    zpw5i3QFuzgjcOR6WdplbGbcRa99Cd+aen3SfEUi7OvTWJHvBZHd/LDrHWLNtJzU
    FmAE9WKjf00vPlProG19cALX7OZPvyC5yNNCVpkmtJnQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeBPPVk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:21:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:33508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeBPPVk (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 10:21:40 -0500
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org
Cc: akpm@linux-foundation.org, mhocko@suse.com,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH v2] mm: don't defer struct page initialization for Xen pv guests
Date: Fri, 16 Feb 2018 16:21:19 +0100
Message-Id: <20180216152119.21821-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
memory during allocation in vmemmap") broke Xen pv domains in some
configurations, as the "Pinned" information in struct page of early
page tables could get lost. This will lead to the kernel trying to
write directly into the page tables instead of asking the hypervisor
to do so. The result is a crash like the following:

[    0.004000] BUG: unable to handle kernel paging request at ffff8801ead19008
[    0.004000] IP: xen_set_pud+0x4e/0xd0
[    0.004000] PGD 1c0a067 P4D 1c0a067 PUD 23a0067 PMD 1e9de0067 PTE 80100001ead19065
[    0.004000] Oops: 0003 [#1] PREEMPT SMP
[    0.004000] Modules linked in:
[    0.004000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.0-default+ #271
[    0.004000] Hardware name: Dell Inc. Latitude E6440/0159N7, BIOS A07 06/26/2014
[    0.004000] task: ffffffff81c10480 task.stack: ffffffff81c00000
[    0.004000] RIP: e030:xen_set_pud+0x4e/0xd0
[    0.004000] RSP: e02b:ffffffff81c03cd8 EFLAGS: 00010246
[    0.004000] RAX: 002ffff800000800 RBX: ffff88020fd31000 RCX: 0000000000000000
[    0.004000] RDX: ffffea0000000000 RSI: 00000001b8308067 RDI: ffff8801ead19008
[    0.004000] RBP: ffff8801ead19008 R08: aaaaaaaaaaaaaaaa R09: 00000000063f4c80
[    0.004000] R10: aaaaaaaaaaaaaaaa R11: 0720072007200720 R12: 00000001b8308067
[    0.004000] R13: ffffffff81c8a9cc R14: ffff88018fd31000 R15: 000077ff80000000
[    0.004000] FS:  0000000000000000(0000) GS:ffff88020f600000(0000) knlGS:0000000000000000
[    0.004000] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.004000] CR2: ffff8801ead19008 CR3: 0000000001c09000 CR4: 0000000000042660
[    0.004000] Call Trace:
[    0.004000]  __pmd_alloc+0x128/0x140
[    0.004000]  ? acpi_os_map_iomem+0x175/0x1b0
[    0.004000]  ioremap_page_range+0x3f4/0x410
[    0.004000]  ? acpi_os_map_iomem+0x175/0x1b0
[    0.004000]  __ioremap_caller+0x1c3/0x2e0
[    0.004000]  acpi_os_map_iomem+0x175/0x1b0
[    0.004000]  acpi_tb_acquire_table+0x39/0x66
[    0.004000]  acpi_tb_validate_table+0x44/0x7c
[    0.004000]  acpi_tb_verify_temp_table+0x45/0x304
[    0.004000]  ? acpi_ut_acquire_mutex+0x12a/0x1c2
[    0.004000]  acpi_reallocate_root_table+0x12d/0x141
[    0.004000]  acpi_early_init+0x4d/0x10a
[    0.004000]  start_kernel+0x3eb/0x4a1
[    0.004000]  ? set_init_arg+0x55/0x55
[    0.004000]  xen_start_kernel+0x528/0x532
[    0.004000] Code: 48 01 e8 48 0f 42 15 a2 fd be 00 48 01 d0 48 ba 00 00 00 00 00 ea ff ff 48 c1 e8 0c 48 c1 e0 06 48 01 d0 48 8b 00 f6 c4 02 75 5d <4c> 89 65 00 5b 5d 41 5c c3 65 8b 05 52 9f fe 7e 89 c0 48 0f a3
[    0.004000] RIP: xen_set_pud+0x4e/0xd0 RSP: ffffffff81c03cd8
[    0.004000] CR2: ffff8801ead19008
[    0.004000] ---[ end trace 38eca2e56f1b642e ]---

Avoid this problem by not deferring struct page initialization when
running as Xen pv guest.

Cc: <stable@vger.kernel.org> #4.15
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 81e18ceef579..681d504b9a40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -347,6 +347,9 @@ static inline bool update_defer_init(pg_data_t *pgdat,
 	/* Always populate low zones for address-constrained allocations */
 	if (zone_end < pgdat_end_pfn(pgdat))
 		return true;
+	/* Xen PV domains need page structures early */
+	if (xen_pv_domain())
+		return true;
 	(*nr_initialised)++;
 	if ((*nr_initialised > pgdat->static_init_pgcnt) &&
 	    (pfn & (PAGES_PER_SECTION - 1)) == 0) {
-- 
2.13.6

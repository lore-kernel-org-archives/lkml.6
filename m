Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CE5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D0B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bkspQSD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfAPWhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:37:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44744 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733147AbfAPWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:37:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so9178385qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iEbt3vOpW1vSXw8Y1FUZOQX7cwVTiCMvjhJS6q091Dw=;
        b=bkspQSD7184VxjjBLkKwOTG622pr36brd8Dq/hG2mn+DxTuOrgj86l9WC+tajy1NTw
         HEGnhl2KOM27ps5YVEOBOny36/OCNuPh9aYj7g4YLqsh7JulUh4Q+9OWJDaZAm3Wt7Ta
         MhhhKojyNMJGjHLa5ykvJ51BLXc34Ca3O+Al9JkfnUaoJvid1AkB4+ucbkTP7N4PIoSd
         ObO0U1PFHilL9hIgK+u43pa7C5VKmMKPkeRXEmhKbNj9W0CB55DisQI8DouVOwhgT3da
         uQDZA8xHE/u2WejORZwUnPesgjkq01O/83OJZ1Ud+Xi6gIBmMWpCsxQd3WBWZw3snnIk
         STRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iEbt3vOpW1vSXw8Y1FUZOQX7cwVTiCMvjhJS6q091Dw=;
        b=NBGxDyydwYidDgt15TC1WHuEXbbpOK1W9QG9C4aVkpMoMLf8PWBpoQBYBYrrIwEWcC
         J4eAJN9yX95ad58GkUBPibx5452stLT/E773OMfu+3pS+Xf9RMcNaRpZS1WgBzjtQO+7
         UWsLwZIFX4gqxPqI39efDNUXEnxbD0QsOkSg9sa9815267wlslEy/3LxFH+5b81tA56u
         tVh2uIerjbgeeQVll7HcVN6J+LrdL07qIMIuwhSzDumvNbERG+7uMLJMdTZ1TMEIAzof
         9j2bl1mc8V3ksxQShK2JZd7K60gsMX7N3Vef9/fJozPPvGRkasluOEp/bH4IglK/1W9r
         ytYQ==
X-Gm-Message-State: AJcUukfYhlGTkKPAhjAyhVojw9T4A4MF7tJf7TQwE/8+iavhUnUfcjRW
        ZfGGesjJOZI8BtFeNgjA4fQuDg==
X-Google-Smtp-Source: ALg8bN7XMYiVZj43cLvnPQFjWqoat8WwSgO+9DO+IrX8MEY5lR3QwMtA7Jtw3GYM/oDbVdJGp0ee4Q==
X-Received: by 2002:a0c:edcb:: with SMTP id i11mr8881817qvr.95.1547678270693;
        Wed, 16 Jan 2019 14:37:50 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p48sm59906393qtp.62.2019.01.16.14.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:37:50 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slab: kmemleak no scan alien caches
Date:   Wed, 16 Jan 2019 17:37:20 -0500
Message-Id: <20190116223720.84181-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak throws endless warnings during boot due to in
__alloc_alien_cache(),

alc = kmalloc_node(memsize, gfp, node);
init_arraycache(&alc->ac, entries, batch);
kmemleak_no_scan(ac);

Kmemleak does not track the array cache (alc->ac) but the alien cache
(alc) instead, so let it track the later by lifting kmemleak_no_scan()
out of init_arraycache().

There is another place calls init_arraycache(), but
alloc_kmem_cache_cpus() uses the percpu allocation where will never be
considered as a leak.

[   32.258841] kmemleak: Found object by alias at 0xffff8007b9aa7e38
[   32.258847] CPU: 190 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2+ #2
[   32.258851] Call trace:
[   32.258858]  dump_backtrace+0x0/0x168
[   32.258863]  show_stack+0x24/0x30
[   32.258868]  dump_stack+0x88/0xb0
[   32.258873]  lookup_object+0x84/0xac
[   32.258877]  find_and_get_object+0x84/0xe4
[   32.258882]  kmemleak_no_scan+0x74/0xf4
[   32.258887]  setup_kmem_cache_node+0x2b4/0x35c
[   32.258892]  __do_tune_cpucache+0x250/0x2d4
[   32.258896]  do_tune_cpucache+0x4c/0xe4
[   32.258901]  enable_cpucache+0xc8/0x110
[   32.258905]  setup_cpu_cache+0x40/0x1b8
[   32.258909]  __kmem_cache_create+0x240/0x358
[   32.258913]  create_cache+0xc0/0x198
[   32.258918]  kmem_cache_create_usercopy+0x158/0x20c
[   32.258922]  kmem_cache_create+0x50/0x64
[   32.258928]  fsnotify_init+0x58/0x6c
[   32.258932]  do_one_initcall+0x194/0x388
[   32.258937]  kernel_init_freeable+0x668/0x688
[   32.258941]  kernel_init+0x18/0x124
[   32.258946]  ret_from_fork+0x10/0x18
[   32.258950] kmemleak: Object 0xffff8007b9aa7e00 (size 256):
[   32.258954] kmemleak:   comm "swapper/0", pid 1, jiffies 4294697137
[   32.258958] kmemleak:   min_count = 1
[   32.258962] kmemleak:   count = 0
[   32.258965] kmemleak:   flags = 0x1
[   32.258969] kmemleak:   checksum = 0
[   32.258972] kmemleak:   backtrace:
[   32.258977]      kmemleak_alloc+0x84/0xb8
[   32.258982]      kmem_cache_alloc_node_trace+0x31c/0x3a0
[   32.258987]      __kmalloc_node+0x58/0x78
[   32.258991]      setup_kmem_cache_node+0x26c/0x35c
[   32.258996]      __do_tune_cpucache+0x250/0x2d4
[   32.259001]      do_tune_cpucache+0x4c/0xe4
[   32.259005]      enable_cpucache+0xc8/0x110
[   32.259010]      setup_cpu_cache+0x40/0x1b8
[   32.259014]      __kmem_cache_create+0x240/0x358
[   32.259018]      create_cache+0xc0/0x198
[   32.259022]      kmem_cache_create_usercopy+0x158/0x20c
[   32.259026]      kmem_cache_create+0x50/0x64
[   32.259031]      fsnotify_init+0x58/0x6c
[   32.259035]      do_one_initcall+0x194/0x388
[   32.259039]      kernel_init_freeable+0x668/0x688
[   32.259043]      kernel_init+0x18/0x124
[   32.259048] kmemleak: Not scanning unknown object at 0xffff8007b9aa7e38
[   32.259052] CPU: 190 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2+ #2
[   32.259056] Call trace:
[   32.259060]  dump_backtrace+0x0/0x168
[   32.259065]  show_stack+0x24/0x30
[   32.259070]  dump_stack+0x88/0xb0
[   32.259074]  kmemleak_no_scan+0x90/0xf4
[   32.259078]  setup_kmem_cache_node+0x2b4/0x35c
[   32.259083]  __do_tune_cpucache+0x250/0x2d4
[   32.259088]  do_tune_cpucache+0x4c/0xe4
[   32.259092]  enable_cpucache+0xc8/0x110
[   32.259096]  setup_cpu_cache+0x40/0x1b8
[   32.259100]  __kmem_cache_create+0x240/0x358
[   32.259104]  create_cache+0xc0/0x198
[   32.259108]  kmem_cache_create_usercopy+0x158/0x20c
[   32.259112]  kmem_cache_create+0x50/0x64
[   32.259116]  fsnotify_init+0x58/0x6c
[   32.259120]  do_one_initcall+0x194/0x388
[   32.259125]  kernel_init_freeable+0x668/0x688
[   32.259129]  kernel_init+0x18/0x124
[   32.259133]  ret_from_fork+0x10/0x18

Fixes: 1fe00d50a9e8 (slab: factor out initialization of array cache)
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 78eb8c5bf4e4..0aff454f007b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -550,14 +550,6 @@ static void start_cpu_timer(int cpu)
 
 static void init_arraycache(struct array_cache *ac, int limit, int batch)
 {
-	/*
-	 * The array_cache structures contain pointers to free object.
-	 * However, when such objects are allocated or transferred to another
-	 * cache the pointers are not cleared and they could be counted as
-	 * valid references during a kmemleak scan. Therefore, kmemleak must
-	 * not scan such objects.
-	 */
-	kmemleak_no_scan(ac);
 	if (ac) {
 		ac->avail = 0;
 		ac->limit = limit;
@@ -573,6 +565,14 @@ static struct array_cache *alloc_arraycache(int node, int entries,
 	struct array_cache *ac = NULL;
 
 	ac = kmalloc_node(memsize, gfp, node);
+	/*
+	 * The array_cache structures contain pointers to free object.
+	 * However, when such objects are allocated or transferred to another
+	 * cache the pointers are not cleared and they could be counted as
+	 * valid references during a kmemleak scan. Therefore, kmemleak must
+	 * not scan such objects.
+	 */
+	kmemleak_no_scan(ac);
 	init_arraycache(ac, entries, batchcount);
 	return ac;
 }
@@ -667,6 +667,7 @@ static struct alien_cache *__alloc_alien_cache(int node, int entries,
 
 	alc = kmalloc_node(memsize, gfp, node);
 	if (alc) {
+		kmemleak_no_scan(alc);
 		init_arraycache(&alc->ac, entries, batch);
 		spin_lock_init(&alc->lock);
 	}
-- 
2.17.2 (Apple Git-113)


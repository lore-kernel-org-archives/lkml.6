Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4D620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4D620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeK0Dsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:48:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:37237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeK0Dsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:48:55 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LsOsW-1fPi1s2h9U-011xcO; Mon, 26 Nov 2018 17:53:57 +0100
From:   Qian Cai <cai@gmx.us>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, longman@redhat.com, yang.shi@linux.alibaba.com,
        arnd@arndb.de, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
Subject: [PATCH] debugobjects: avoid recursive calls with kmemleak
Date:   Mon, 26 Nov 2018 11:53:43 -0500
Message-Id: <20181126165343.2339-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:Z7xs/5i9krT0NzYMsDvLcsUygqjt/jpWeQQjvMr81mWug/3PZsg
 naIaLeLjjSAUEgiQZHftT19AVpLQxrflepB1Qj5Ho8eNPXLzCpaeN9g4cjvd3t6RrORz9Hl
 A4dXdQv6kwS6VGa97rkwsGzxob+e2NuffiSK7YhIdtjJrs4KqMtwSv8h91FFV04ZiMAdJi6
 groKHWdCTJPY3maYAxtkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWEabYTnR6k=:sDbah4z6OK9H3wkI3T+gEG
 kUTuv8XhaotZjip62BP9npVQZ5TbyWUT9uOWBiGuBWMZOFPMHQoU/Yzpzl4nNgOC62Lq486Of
 aJwTyjMgzAPB4LE1JMH/22oJb3uzz3l0idLdvvTNmMC9jYyv6QGuBTVXII402ja/xeGS8muH5
 J3lqHYwM7u3wMNdiU26y/jHSrSgyH+7oXJRjc5Cqpseu4PSKSrbEoS3uFqU5HjBaUUmhwk104
 ck0AJNg5GUERsrroUOEn3Hu4TJBjZGig3fYQpr9kZ/F9gPWVFgpHBWEN7X5QAyaOilOa5PcWn
 jVlqLZLhc0VKwAGQyNOUoX7meNqwClHinR0cKds1AQ5Fmwn4+dT18R2FamiabGefgfYIohbxH
 8iguUZEq+OdZ5aCPBaaLQE1mF/no++j1X8JiDRySVxoSUfWtokNJKPZmDfmDipAEmiizH2Sip
 8155IDoiBpX67HRIUyTffB0S9NwaY1HPxlE935eeuGMyAjOZK0Ru+1X7gZEopoIuu6ISJNS0E
 W8nnPqUjKYt+aTqUxvyC40T1BSoKIj7XRalGvoxbFbQrqcIygu7NxoZW37xXAzbaUrSVPpjql
 KqTxEKt2QsXyW/FvN/PQWP8aVYJjLf2b7xplL7XrGkGX/FsXz/M+YIefqdDoB91Lh4aU21nWk
 CQn3wBniLBBdUSj4knjDdIdTAsCqHeOkdE96X5SNPdqeYSPwtJIaV9VnWlJvgDpemo6it+2Wo
 25wN06d5rJtuj1v74gX0EkGi/VFvBb4xdfRVzIOkpgM38Z7afBP11Y0L1eZQgq45v4KnWbc97
 c3Pt0UKj+xhWteKH0gnfAip91v5hCGKGlu/Bc8O/BO3Y2RIEGoHmodT1A8rxp9TPmfD8JJz2G
 KTxLpbE4Nz7FxduGydfvhGT355oSLLiyEy7YQRMzc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_OBJECTS_RCU_HEAD does not play well with kmemleak due to
recursive calls.

fill_pool
  kmemleak_ignore
    make_black_object
      put_object
        __call_rcu (kernel/rcu/tree.c)
          debug_rcu_head_queue
            debug_object_activate
              debug_object_init
                fill_pool
                  kmemleak_ignore
                    make_black_object
                      ...

Hence, adding SLAB_NOLEAKTRACE to kmem_cache_create() to not register a
newly allocated debug objects at all.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Qian Cai <cai@gmx.us>
---
 lib/debugobjects.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index eab7727b46ed..55437fd5128b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -135,7 +135,6 @@ static void fill_pool(void)
 		if (!new)
 			return;
 
-		kmemleak_ignore(new);
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		hlist_add_head(&new->node, &obj_pool);
 		debug_objects_allocated++;
@@ -1128,7 +1127,6 @@ static int __init debug_objects_replace_static_objects(void)
 		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
-		kmemleak_ignore(obj);
 		hlist_add_head(&obj->node, &objects);
 	}
 
@@ -1182,7 +1180,8 @@ void __init debug_objects_mem_init(void)
 
 	obj_cache = kmem_cache_create("debug_objects_cache",
 				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS, NULL);
+				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
+				      NULL);
 
 	if (!obj_cache || debug_objects_replace_static_objects()) {
 		debug_objects_enabled = 0;
-- 
2.17.2 (Apple Git-113)


Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE622073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+as1x8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfACB4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 20:56:53 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:57033 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfACB4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 20:56:52 -0500
Received: by mail-oi1-f202.google.com with SMTP id a62so22917135oii.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 17:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1IEdvSxiiyqFy6UrKVLcrWtjX6CPPhzM2L/LFrcQXhk=;
        b=O+as1x8BbL64S+CFz8r+7ZJq91aRp0KbfX1lcq5FkGxOGbsxhQ/zxsFmi1Vy0Kb5a/
         pJTBwBiURN4IGInYblKKXGfNVjIv4kEhu+kWwCP2Jg244NAdsqt60xBSklLEp9SYFr4R
         XdCHOT9vtQWN03lKDw0YI5Fz8Rf10w7b2rmdLTc9IMOaMxtwMZW9ckjBFAo5TAU8wt+X
         4rysTKaL+ue20yJQZUSBvY1yRsWOLVyzNwde48PuQT/YG/Dhf4F0Sid4n+Pa7c5kYf1j
         qqthVXOSIztPgmDX3ULfduwZkMJxp1KYbknVGEBC315bSoc+XPy4dsrTeU7FDQe82/P3
         hW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1IEdvSxiiyqFy6UrKVLcrWtjX6CPPhzM2L/LFrcQXhk=;
        b=s9OULA1kR7jmjvSEY2jYDXgmlcDbgbmppDkGw1G4SMGXwcFN5Y36LThepz3nDeEDkO
         74SNyPHofzGa/UTC2IXtSTrU7WiQ4FuqHH7Zii050PqaXELxvWd2UUCU1OQoPPbgtEp3
         E6nVaq9OFFAbazCFXuv+D7se3kYAvuaJM+ZPAXcTDM5l1adC/DCk4NlES4pwEP9H4dcP
         uuApywz3WVsvd3UmeYfU7w4UjFf1EhS0dRcnCNKIEcooMV4q5nv7+e9vH3NuIGrGID+X
         Uq9plC9O+Y8Ow3sS6v8KvTLr3K/ZhX/f4u8zdPepOY4wMk/mJs3p/wfmsM35GaEaXGAt
         oSgg==
X-Gm-Message-State: AJcUukcKqtAAVcAfbJ5sIfpfohlX4KIsxSJody5NrX8oTUkCayJMSUah
        5Cmw+NxM4ROwPW8NAorpJ//T7mC3JRsutQ==
X-Google-Smtp-Source: ALg8bN7jWozz13OWzQ+A70JtrRj6cJutBJTH/Gxv95lL+kAkhPL0oDZrRFq/MSfDf+Hs9Q3mRcp4KIw+BwcCqg==
X-Received: by 2002:a9d:ba8:: with SMTP id 37mr34172518oth.31.1546480611663;
 Wed, 02 Jan 2019 17:56:51 -0800 (PST)
Date:   Wed,  2 Jan 2019 17:56:38 -0800
Message-Id: <20190103015638.205424-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] memcg: schedule high reclaim for remote memcgs on high_work
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memcg is over high limit, memory reclaim is scheduled to run on
return-to-userland. However it is assumed that the memcg is the current
process's memcg. With remote memcg charging for kmem or swapping in a
page charged to remote memcg, current process can trigger reclaim on
remote memcg. So, schduling reclaim on return-to-userland for remote
memcgs will ignore the high reclaim altogether. So, punt the high
reclaim of remote memcgs to high_work.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e9db1160ccbc..47439c84667a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2302,19 +2302,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim on returning to userland.  We can perform reclaim here
 	 * if __GFP_RECLAIM but let's always punt for simplicity and so that
 	 * GFP_KERNEL can consistently be used during reclaim.  @memcg is
-	 * not recorded as it most likely matches current's and won't
-	 * change in the meantime.  As high limit is checked again before
-	 * reclaim, the cost of mismatch is negligible.
+	 * not recorded as the return-to-userland high reclaim will only reclaim
+	 * from current's memcg (or its ancestor). For other memcgs we punt them
+	 * to work queue.
 	 */
 	do {
 		if (page_counter_read(&memcg->memory) > memcg->high) {
-			/* Don't bother a random interrupted task */
-			if (in_interrupt()) {
+			/*
+			 * Don't bother a random interrupted task or if the
+			 * memcg is not current's memcg's ancestor.
+			 */
+			if (in_interrupt() ||
+			    !mm_match_cgroup(current->mm, memcg)) {
 				schedule_work(&memcg->high_work);
-				break;
+			} else {
+				current->memcg_nr_pages_over_high += batch;
+				set_notify_resume(current);
 			}
-			current->memcg_nr_pages_over_high += batch;
-			set_notify_resume(current);
 			break;
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
-- 
2.20.1.415.g653613c723-goog


Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB72C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F5C20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MMzYO6/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5C20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406053AbeKWDba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:31:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43935 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbeKWDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:31:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so8199520edq.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqCNVNv0Y8aoRKucGwKEjdCDvF336AuZYaELjzjP6Ls=;
        b=MMzYO6/waCjCYerQTkvOeF8GBYcFu0U7oI6tc9TyEKstlXpVLz2o7sa6oi3lFZfhPG
         v38/v1GFssxWyCYmgz0LqI9Sm+APanFajOvvvpBoCT/nfxyAUye3LZpj1po5QpUN12NU
         adNcLC9JNMKYMy36LmWpSDW8/uY5Z48mR9P1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqCNVNv0Y8aoRKucGwKEjdCDvF336AuZYaELjzjP6Ls=;
        b=gpT1tHhXCctHZGihc/tfYwd733Y6npspdCFOGVb+hgxX8RE/vRUe+GWYDezPdEliKe
         8112X3DT0OoaUNelD6qt7HZ/tdyqIiFTvOjn+lYkgjhR28yg5Uo5WBAYVGdL8AsTkdjn
         RnGcu5RabHNk9Ph4Ey52uelE/D6/9kqbQ6hyevTTgg3cbxmrzAbQQwvJxqpW4G2c8Nvv
         8dGafgIyrerZ+8YIU4X+6zRF4D2Zi7srPMdU8+l9ma3MTGbxybXV9wI3kqg7k0fHovx9
         HWEZUXT1CJAhRhi6fBFDQyb2FQKivpcmqE69tBtjhXKO0qFSu8doYwZwPg1WEumZ4Bb7
         7GtA==
X-Gm-Message-State: AA+aEWbOOysnaurxPFXigJNerLKhgAQ2I3ztpXA85bhJPNPXD0y/c4cz
        PBPPaUFpZnTjis7GFnkTTCZBapOgHzI=
X-Google-Smtp-Source: AFSGD/X3yt1n8EIDxKFM/dx7WPreYbLdq5CVYlgu9XO9dTU/ze5Lq/MSqa8fCcbBo2dSkl61aed9Sg==
X-Received: by 2002:a50:fd0e:: with SMTP id i14mr9994539eds.98.1542905476815;
        Thu, 22 Nov 2018 08:51:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm12914780edb.43.2018.11.22.08.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:51:16 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/3] mm, notifier: Add a lockdep map for invalidate_range_start
Date:   Thu, 22 Nov 2018 17:51:06 +0100
Message-Id: <20181122165106.18238-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a similar idea to the fs_reclaim fake lockdep lock. It's
fairly easy to provoke a specific notifier to be run on a specific
range: Just prep it, and then munmap() it.

A bit harder, but still doable, is to provoke the mmu notifiers for
all the various callchains that might lead to them. But both at the
same time is really hard to reliable hit, especially when you want to
exercise paths like direct reclaim or compaction, where it's not
easy to control what exactly will be unmapped.

By introducing a lockdep map to tie them all together we allow lockdep
to see a lot more dependencies, without having to actually hit them
in a single challchain while testing.

Aside: Since I typed this to test i915 mmu notifiers I've only rolled
this out for the invaliate_range_start callback. If there's
interest, we should probably roll this out to all of them. But my
undestanding of core mm is seriously lacking, and I'm not clear on
whether we need a lockdep map for each callback, or whether some can
be shared.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/mmu_notifier.h | 7 +++++++
 mm/mmu_notifier.c            | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 9893a6432adf..a39ba218dbbe 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -12,6 +12,10 @@ struct mmu_notifier_ops;
 
 #ifdef CONFIG_MMU_NOTIFIER
 
+#ifdef CONFIG_LOCKDEP
+extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
+#endif
+
 /*
  * The mmu notifier_mm structure is allocated and installed in
  * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
@@ -267,8 +271,11 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
 static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
 {
+	mutex_acquire(&__mmu_notifier_invalidate_range_start_map, 0, 0,
+		      _RET_IP_);
 	if (mm_has_notifiers(mm))
 		__mmu_notifier_invalidate_range_start(mm, start, end, true);
+	mutex_release(&__mmu_notifier_invalidate_range_start_map, 1, _RET_IP_);
 }
 
 static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4d282cfb296e..c6e797927376 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -23,6 +23,13 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
+#ifdef CONFIG_LOCKDEP
+struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
+	.name = "mmu_notifier_invalidate_range_start"
+};
+EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start_map);
+#endif
+
 /*
  * This function allows mmu_notifier::release callback to delay a call to
  * a function that will free appropriate resources. The function must be
-- 
2.19.1


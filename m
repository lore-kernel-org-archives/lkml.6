Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE8DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669062082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="icP2AHNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669062082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeLJKg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:36:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41402 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so9014705edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6Z9o1UxIwE7Qp4GM9ozZMxGfybJeBYWvC+NX0jB8Ig=;
        b=icP2AHNmcD+B4xLZa9BqY9xY3/IFbnZyMH88+fTJ6npgQP++AoT86deQ+1xEADFajI
         lv4tzBLHCpf4+pdhpXVTVHN6gGHV6ApiDf4REPSgiGhykR/Kvu5HBWTVUjq3FxwLwJDg
         CL0fC11rqPywTMOksfy8+IKeWwhPykofEf6os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6Z9o1UxIwE7Qp4GM9ozZMxGfybJeBYWvC+NX0jB8Ig=;
        b=dLTa4Zha6W5YAgSROOZrd+GZb5Fxw2IvhbPtPFquUndOvvti+1h1zD7bn+ivXDKbp4
         S+r2anJGMwLXAZwesO0D4RYChMaPQWaaDNVsMCsZqGNzRd8xEt0OFua1tbMx6SmKoIhC
         6A/oJ0EH3TwBNHgSRQz/Qrvb1gL/+ginVDZd6vjvjYcdQTU/Xgm1D6AcA3Xxg7EJPdDc
         lmGxmVqnSqIaMS2K0FOednzd+bbdwY6yHoDlvMbCqcYTB6o4z88L5d9kusJr/oNAhFTP
         b+B9HXAHYUKqnl0yr3BINjeL7qEfDtaYPWSsaYk+WJ6Pzs06HmNez+E70OZa0Rk6rWjK
         nDlw==
X-Gm-Message-State: AA+aEWbkvz+np84vvREOZKojfWyzmhCIUOaRlcOg43JPDwPnUh8al+Fe
        pK5QfbMP2AKfRjNW2QusllnQ+g==
X-Google-Smtp-Source: AFSGD/WNv+B6hLRHpjT8x6yzaStntdhgvwRTQuAgi9i8Mb9b50a073LY+g1tBOIcIFzXaTLDqBi5ig==
X-Received: by 2002:a50:8f44:: with SMTP id 62mr10781951edy.264.1544438213379;
        Mon, 10 Dec 2018 02:36:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm3223862edd.66.2018.12.10.02.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:36:52 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4/4] mm, notifier: Add a lockdep map for invalidate_range_start
Date:   Mon, 10 Dec 2018 11:36:41 +0100
Message-Id: <20181210103641.31259-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
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

v2: Use lock_map_acquire/release() like fs_reclaim, to avoid confusion
with this being a real mutex (Chris Wilson).

Cc: Chris Wilson <chris@chris-wilson.co.uk>
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
 include/linux/mmu_notifier.h | 6 ++++++
 mm/mmu_notifier.c            | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 9893a6432adf..19be442606c6 100644
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
@@ -267,8 +271,10 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
 static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
 {
+	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (mm_has_notifiers(mm))
 		__mmu_notifier_invalidate_range_start(mm, start, end, true);
+	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
 static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index a50ed7d1ecef..c91d58fe388b 100644
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
2.20.0.rc1


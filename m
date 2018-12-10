Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06606C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14782082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HYF4p+0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14782082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeLJKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:36:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45233 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeLJKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:36:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so8996246edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 02:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MS4TiUW3mXcW2vxlt2KruqWF3duOJRQUhvXcb4QfQyg=;
        b=HYF4p+0jjNwvgALG0WqPWvZt57NTN7mpz//Q7uyw8ZbSBmUCm7mHWB/5s4pj1VFEMy
         ByPViZ5WgGL+zSMjdQAro1toiOQcRJPPxi97KSxApGHXEVPsqDDxLnPVROccHhPH/8pk
         UaeBWOVd1ijco7dZr6+9+DYyrYSj7I3NnwoFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS4TiUW3mXcW2vxlt2KruqWF3duOJRQUhvXcb4QfQyg=;
        b=konYLvt6VB30XWK9qw4duPhxiVc3QmCWu9Hf3z7OC3ApJQxkzaIcefF64QwQgvsNkT
         1+/lSS3ZnMvguL1HVzcNlANTWDFg9AQLTFdqKzfp5+uvKD463CwURDxxw0Iq7CdZRr3y
         kVMI9VmjX64uQ2EGUaL1KiHfmHdPy3mS4ZLXgKpoCxXn1QqvY22IE0QQJoTMF/RSPeX8
         5WVbH3s3zKE0DG4QY4Eec56jgkQKOw+odQDCIEUOZYIuUdrX+xJuqf9nR8+/EUtO97u/
         503SUkSp35CcvXf2mKOKCm8fx67TfrwTzSL0t/GRlA4V5dXDwygh4/X5DNzG5SF6Ri+j
         j+qA==
X-Gm-Message-State: AA+aEWZkGlofuUz+J0yea91LXcdpfca9GJx9vd9axVeP1XGlRZtTCqx5
        y90hY/Js2rY9ANSqLYhAOBunHw==
X-Google-Smtp-Source: AFSGD/VBhwhwpXMcF/WqlfqrIFWeyUnYoYAKfyugWwKrywPx+aWhzf1Mma1LvnRSHr7+48mh4dGruw==
X-Received: by 2002:a17:906:59d6:: with SMTP id m22-v6mr9293378ejs.20.1544438212050;
        Mon, 10 Dec 2018 02:36:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm3223862edd.66.2018.12.10.02.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 02:36:51 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/4] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Mon, 10 Dec 2018 11:36:40 +0100
Message-Id: <20181210103641.31259-4-daniel.vetter@ffwll.ch>
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

We need to make sure implementations don't cheat and don't have a
possible schedule/blocking point deeply burried where review can't
catch it.

I'm not sure whether this is the best way to make sure all the
might_sleep() callsites trigger, and it's a bit ugly in the code flow.
But it gets the job done.

Inspired by an i915 patch series which did exactly that, because the
rules haven't been entirely clear to us.

v2: Use the shiny new non_block_start/end annotations instead of
abusing preempt_disable/enable.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index ccc22f21b735..a50ed7d1ecef 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -185,7 +185,13 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
 		if (mn->ops->invalidate_range_start) {
-			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
+			int _ret;
+
+			if (!blockable)
+				non_block_start();
+			_ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
+			if (!blockable)
+				non_block_end();
 			if (_ret) {
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 						mn->ops->invalidate_range_start, _ret,
-- 
2.20.0.rc1


Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9165E20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q4vTJ8Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9165E20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406062AbeKWDbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:31:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34284 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbeKWDb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:31:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so8246312ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgwJtKz/bAk5V2diWi6f2OFLQxM1W0dMUc8sKowBqdg=;
        b=Q4vTJ8GdD4KzHoedmPOhf6u2vnzIm7VaUt5yUjAKQ6T0soQqIl+0l/0ncEcEtIvjem
         z05dSmCFY7Hcm/qUPGHlGjuR6FRGsyE5NkQa8lDut75Gqo5six8q3eKJyRc8XKeO13Zx
         +DMpwbTdLPRC1Fr/h3BezrEU62/W5kyvDGAaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgwJtKz/bAk5V2diWi6f2OFLQxM1W0dMUc8sKowBqdg=;
        b=pQ6sPqRC8+jjToSPdX4BYCcVRzlcXg1gt+RlPoN9UK7X3StYxtfXt0ZLLe/SAlTsRq
         46Ku8cDo8xy0gYYsP7M+1daYMJLhPN8UHsFItZXVo9hAQM01T3HUzHn7h5x8CJOHfk7s
         9fr4qhpSx93jl7nuDKSRiWoaz32X3+8DaEFkHmHotZ8rx4ff0+OO9kqiI52i68pKrXm9
         0GE+6aFRalORNjV2fk7C5b+OrYkydEAp8hXYYF9PVsSWNvzdzK7j+LiNyd564mEMt5Fa
         zoy+awKVX/5y4HCJ951aCW9QtZLrvAjAIH/TnqjgXSwtakIjWUqpd2vagIUFHGxUYAkY
         ieiA==
X-Gm-Message-State: AA+aEWbBPmYrSjaA/ltniBwmInG7s+VrSBP2knb0IDdowpLAD8srLTY0
        yDqEDbbYZIEWqM7Ionhb8qz5Np4N6cY=
X-Google-Smtp-Source: AJdET5f7D95UNLjpN3z6CjQVNTRkjvktjeA+ZinA1S4SxGyQ/8odF3x2QRcRsfY9v4Pi6Pu0SMQitA==
X-Received: by 2002:a17:906:3b11:: with SMTP id g17-v6mr8689028ejf.210.1542905475467;
        Thu, 22 Nov 2018 08:51:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm12914780edb.43.2018.11.22.08.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:51:14 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
Date:   Thu, 22 Nov 2018 17:51:05 +0100
Message-Id: <20181122165106.18238-3-daniel.vetter@ffwll.ch>
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

We need to make sure implementations don't cheat and don't have a
possible schedule/blocking point deeply burried where review can't
catch it.

I'm not sure whether this is the best way to make sure all the
might_sleep() callsites trigger, and it's a bit ugly in the code flow.
But it gets the job done.

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
index 59e102589a25..4d282cfb296e 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -185,7 +185,13 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 	id = srcu_read_lock(&srcu);
 	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
 		if (mn->ops->invalidate_range_start) {
-			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
+			int _ret;
+
+			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
+				preempt_disable();
+			_ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
+			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
+				preempt_enable();
 			if (_ret) {
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 						mn->ops->invalidate_range_start, _ret,
-- 
2.19.1


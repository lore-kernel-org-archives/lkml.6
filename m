Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7D820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T6LI94Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7D820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406042AbeKWDb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:31:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42743 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbeKWDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:31:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so8205441edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35SA+A3zSGOUwg2DuEDiDQyYR9o/qAXgi6nZL2aj8/Q=;
        b=T6LI94Z0asV3yzmoBf2IesRD6VsGBDpIYF984cFK/5uoflQEU62+7Gv+8nL8dSimEH
         VVRZdWL4nrC7LT8+R6AClQYQf+KnkfZA92h+SBHYngfeeoFcXGNrLQCHsLR54Vv7Llds
         ZElU3K4qoo2YLnpkZIDN5WzFwtGdErLMEcxIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35SA+A3zSGOUwg2DuEDiDQyYR9o/qAXgi6nZL2aj8/Q=;
        b=K5H2jmLPoxUxNfqR/iYIPf2jLjMr9YY4WfjTelVQ6NR2TCzeTRpPU7X2RpK9uPYqvX
         x1v9ZqNKvGJ4YorLlaLYq5SbrbpMt5szAc+9Gij6Wns3XmdmDX6+ETOvc9aNlvpGGhtr
         UI1OrNvMZKjDWKB9oL/QNxmsT0iz6lR/rPY2fNHtJhQ2TyOxpW3spFZvUpKW4/eG/EWl
         Urvid0lZFRaeNB3c1FhPpOs6O3ayfkJJyskZENopG0q9kVSJNBeem6TAmceAdlxDY7wG
         NRUSPNQD/b7VyGftXmLOihtNaAgK45suO5c9yg1ucoaC2eLCriYa7Ii/UXnMDDaqGFg8
         QxXQ==
X-Gm-Message-State: AA+aEWbQkYL2TyuL3STgk3xHc50f/Q5hWT+S/ymWnvRHQB9Xg5PRwdHg
        CWfBCKTMya+TVvDtSdz3Np1vR18fpAs=
X-Google-Smtp-Source: AFSGD/UaEjvJQp9C/3K0fUJG/8rVELf5/0i7gzNYdUB5+WGaWrnZRqdyJkJ9AKcGEmio8EYKSuwHCg==
X-Received: by 2002:a50:bdc8:: with SMTP id z8mr3626337edh.46.1542905474153;
        Thu, 22 Nov 2018 08:51:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm12914780edb.43.2018.11.22.08.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:51:13 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/3] mm: Check if mmu notifier callbacks are allowed to fail
Date:   Thu, 22 Nov 2018 17:51:04 +0100
Message-Id: <20181122165106.18238-2-daniel.vetter@ffwll.ch>
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

Just a bit of paranoia, since if we start pushing this deep into
callchains it's hard to spot all places where an mmu notifier
implementation might fail when it's not allowed to.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 5119ff846769..59e102589a25 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -190,6 +190,8 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 						mn->ops->invalidate_range_start, _ret,
 						!blockable ? "non-" : "");
+				WARN(blockable,"%pS callback failure not allowed\n",
+				     mn->ops->invalidate_range_start);
 				ret = _ret;
 			}
 		}
-- 
2.19.1


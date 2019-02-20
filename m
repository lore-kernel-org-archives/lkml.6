Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB558C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA5820880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Qw7lFkV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBTUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:41:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33716 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTUlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:41:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id c55so3379430edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6f5ltKfmmbc/Y9tRkkr1Gep0E2+84qSjXYQazP6FGY=;
        b=Qw7lFkV8yfgMQI7I1KxGwt8coeYmzppBGjv89An9g4411slsQYPWkWoHK5o6qTaZY8
         mGVh03kx1JrDV9WJ5hZVsSPFHwCrg7JtjxyRHfwFNCmGCG1aNmrR3BweASg7EduzJRcC
         ZKEsPQaejvdqcHGTjwANDEGhQqLpqZ3r+9C+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6f5ltKfmmbc/Y9tRkkr1Gep0E2+84qSjXYQazP6FGY=;
        b=GTorz2qcLSobEZXyhoTDnt5siX/aPRsFRYi7yqYRuuFk7Px7xEATJ4p7i8KZaPocHz
         8reXL+vhYZAt/DqiYVc3BiXd0E2UigggBKgOCx0w0kWglOA3u7dTnV4O5/fDBtEW+vfw
         KFe750GL7SNUf0C1JCIV82rzIGhJlrwpNo0DvF2Ai3tQoOOLJDosI1yPxGQAiL47evsK
         VvxgT+nYE5B35dYv/8z0Ln/wPVy/o4xfwwXhiOgOXXo+vF8iE+/VAUYbvmSQ+Tgh2YfO
         eVfumcxnMgYjFwzV1GSSyBNr/riM46SnG5ag/efxKBQJzKX6v82uaEf2gSiAjx2zwzfu
         I+Gg==
X-Gm-Message-State: AHQUAua2+8LUVUh9pWq1rEQ4Gdo91NcCSCKtBUGoZENKpVvw1zFSQ+Mi
        jaYtKwp1//j5gz6uSWtsu5EbUw==
X-Google-Smtp-Source: AHgI3IagqA0mxBGHF+yEfWeC0mj2PH/FOucG9GisitYve7hjX3IsPJmMFQpogapUuhVj9T6XNVqoOw==
X-Received: by 2002:a17:906:1602:: with SMTP id m2mr13654457ejd.228.1550695265590;
        Wed, 20 Feb 2019 12:41:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j6sm6087946edd.43.2019.02.20.12.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 12:41:04 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-mm@kvack.org
Subject: [PATCH] mm: Don't let userspace spam allocations warnings
Date:   Wed, 20 Feb 2019 21:40:58 +0100
Message-Id: <20190220204058.11676-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memdump_user usually gets fed unchecked userspace input. Blasting a
full backtrace into dmesg every time is a bit excessive - I'm not sure
on the kernel rule in general, but at least in drm we're trying not to
let unpriviledge userspace spam the logs freely. Definitely not entire
warning backtraces.

It also means more filtering for our CI, because our testsuite
exercises these corner cases and so hits these a lot.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-mm@kvack.org
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 1ea055138043..379319b1bcfd 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -150,7 +150,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER);
+	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.20.1


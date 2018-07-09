Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3253C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF982087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K1LBemkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF982087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeGIIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:04 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42614 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeGIIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id g12-v6so13258349edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k8vn/HvfenjIobV8K5/94RK0D1EV/hUIYoYQGqLAxTk=;
        b=K1LBemkPZ93X89SBDgCdRLd/x5MmNjzY1hGzEypRHNoiW1HraT3PUUXLNVZqr3AWek
         JG7an+T7UlAY08L9DXBl6ewKQQ/NQliX7m0jboCoJpt3fitUq1wpmhr6aLiRv5bTZ/6F
         ypb/Nu9WD6mOR9AQEKD+3rw9yqx20ELrTnbQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k8vn/HvfenjIobV8K5/94RK0D1EV/hUIYoYQGqLAxTk=;
        b=bu1uhpnadiTRYy3y+BNGkyR1tGjYEImZicEIIvbgFOTLAynnnsu6y8n8h8fr53tQJ9
         WxEReFaC+x/JcbFlJLjVrV689ctQ5U/pT9hYzK15NI0E2FMPiuYhCSW/2FHRz8iHGjhR
         rd0jlQHh9y5CCSsJjp7BKLW+biKrj33q9dp42AUhCuc10dMivDiq63uwYGFPqwNzbLa1
         +E1ronYTs7wA/R/NOPWuMyokvwLvoD6/ZQb1/R+xbbLb64JmXbwjoZoMqChWF2aLoNCc
         UZ43Jz7W+F/r+GD6L5AGUMoRHGLpRuJI+is3+MuxFu8IV5HPkK67ztymWCKy14WGEd5T
         ZCgQ==
X-Gm-Message-State: APt69E2WKyvaqccXapuVaxtWxUr1oWGOsmOHQx/nC7KFgprqycRFPNhM
        N6aAiVPfvaTpMmkJmgyXykKnBrqg
X-Google-Smtp-Source: AAOMgpe4QdsPKM2s7HJalVZ6TE7Ys0ablMhEmAlQ0LKSF5sJn5STtsLXzelBTWvHn9penw9r/3Y5wQ==
X-Received: by 2002:a50:e885:: with SMTP id f5-v6mr21390996edn.39.1531125420328;
        Mon, 09 Jul 2018 01:37:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:36:59 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 03/12] cgroup: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:41 +0200
Message-Id: <20180709083650.23549-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the need to invert the condition instead of the open-coded
version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
---
 include/linux/cgroup.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c9fdf6f57913..666c6200d61d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -287,9 +287,7 @@ void css_task_iter_end(struct css_task_iter *it);
 	for ((leader) = cgroup_taskset_first((tset), &(dst_css));	\
 	     (leader);							\
 	     (leader) = cgroup_taskset_next((tset), &(dst_css)))	\
-		if ((leader) != (leader)->group_leader)			\
-			;						\
-		else
+		for_each_if ((leader) == (leader)->group_leader)
 
 /*
  * Inline functions.
-- 
2.18.0


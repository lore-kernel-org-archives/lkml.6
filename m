Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911620878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RN4KGNfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1911620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeGIIo3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:44:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47101 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeGIIhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id r17-v6so13261626edo.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OBCzw08VgKkjE2xja9WidJUg36mrD2Mca0eSXgRqBhQ=;
        b=RN4KGNfig4uWmlqC13HZQtIkX2LzpfYXXTyS54pjboNFan0jgJ76mEyt/NfuniYE/3
         vd9/Bnm2ysogUye2tM8NucRDisftotkIERnjfj2Hgjc/KOBEjC+80AgBdux3+jE1zYuP
         SvNwzwevY0+JQZq0H7LWr77GTX/A+PfxXBK5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OBCzw08VgKkjE2xja9WidJUg36mrD2Mca0eSXgRqBhQ=;
        b=osGurK42DEf4dowhBCfPrrLhwpI1cuLvUG8GrEkDr31qsri7h6ef0kMICDC0Eum5WX
         XBHeOGGmPGHybckAH85G5+IwbAW1mwmP4KMQJBLScJ5EhLlMKJFE0G/RB9vWzJYOjtsZ
         5OHfRay9l2vLThgK9sVx9TpkUbftaRof8TvwxDTWCjSy7DQB64ttDfDSKsq/YteXOlr+
         jvSG/2yCEwXa6/02JldReQ0ts7bdjHjrGESrhIOWi8VORTc61a3M79pO3GWP8pk0tRq1
         EhJ2pc07JKenBWTd97qjfM2Yx8OwT3MH0/p2U3RaL7MMvpn2K4gn5p/mgRX39Z5XydUE
         l3tQ==
X-Gm-Message-State: APt69E0BdnO9J1mjWqvfiHJEfqNvirubXhgVE2NcVjxmeA7yqoGkpbVW
        7qIAjYHY8jzh7XJWUKaQBEPzEYZW
X-Google-Smtp-Source: AAOMgpeYrfhfxKS2I9kxGPmgZGxVOhexWsI/B8PDyWi5V0LHR2pz3vZ+RRztBSlQ+J0YE5ui0VH+8g==
X-Received: by 2002:a50:8e09:: with SMTP id 9-v6mr81145edw.101.1531125419067;
        Mon, 09 Jul 2018 01:36:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:36:58 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/12] blk: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:40 +0200
Message-Id: <20180709083650.23549-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes the macros resilient against if {} else {} blocks right
afterwards.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Shaohua Li <shli@fb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/blk-cgroup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..f1c3afe42c26 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -382,7 +382,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  */
 #define blkg_for_each_descendant_pre(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_pre((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
+		for_each_if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css), \
 					      (p_blkg)->q, false)))
 
 /**
@@ -397,7 +397,7 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  */
 #define blkg_for_each_descendant_post(d_blkg, pos_css, p_blkg)		\
 	css_for_each_descendant_post((pos_css), &(p_blkg)->blkcg->css)	\
-		if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css),	\
+		for_each_if (((d_blkg) = __blkg_lookup(css_to_blkcg(pos_css), \
 					      (p_blkg)->q, false)))
 
 /**
-- 
2.18.0


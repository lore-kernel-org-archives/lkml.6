Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF47C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D53A20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LGk3+re6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D53A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeGIIn3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:43:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41390 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeGIIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id b12-v6so13261978edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMZSSU0KkKE9HYRn/+VuCD6ALLRw+y1IXpSf0Z83IAA=;
        b=LGk3+re6bBXpTOEwBTRgtKd21D7FYwlGzo7XI6fwPgKSgao/CcncC3qHh334aw/TWi
         hr299WAO338qLhG0lWfrg7rikXFypSUELoUF2AP/w9EQ+MF2cMv/nwmueFHlqYBmUGgu
         Oqdp9T9ca+KtMB922L2qOJlKl+lWDD5MpOIjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sMZSSU0KkKE9HYRn/+VuCD6ALLRw+y1IXpSf0Z83IAA=;
        b=Hoii6GGnn5YpIm84wdjNTjjYwrIOtRs0Ya0jKDke7hn3rKjSYb/nWSLB6UR7lWx7lP
         O1TEUBHMMzzUWeG5u0bo/5FpCAvYhutPm65wJ/VsIBDzJPJ+7nmQt0eYvH/6wCYHIc/7
         SDjT38T4D8TX4c7ar41Sp51J7KHjSwBxB3siD9zgOdOMGGcJETUx/ftpxsp8gO2W2NWC
         E1mxX5j0WKQbpmhe85+dFAXFeVXGMLeGxnOMzR5A2sT5vwPAWKtQgNdW/xyuFg6DTNpu
         a5ySQ8hCuALB8AGJXh5mjY2V2kSUvE4Fvqjg5gTnSOjjusrKYGk0Z9bplrt3mJHdA3sN
         WXkg==
X-Gm-Message-State: APt69E1XcLYmL692oMmvjvcZdwYQrKrARSqCF/4oNWnyf663zrP8J8zL
        TTnwzLFGYOOe62PpDy2mYbAoLMBq
X-Google-Smtp-Source: AAOMgpd9G6bm/5T0735aeEHe9fA8gQFlnb+wg42CW0ej5HQdtsZDQxsuKEqI5X/cfU6kehTEfWRxxg==
X-Received: by 2002:a50:ec0b:: with SMTP id g11-v6mr17789502edr.38.1531125423865;
        Mon, 09 Jul 2018 01:37:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:03 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-mm@kvack.org
Subject: [PATCH 06/12] mm: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:44 +0200
Message-Id: <20180709083650.23549-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted condition of the open-coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: David Rientjes <rientjes@google.com>
Cc: Kemi Wang <kemi.wang@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Petr Tesarik <ptesarik@suse.com>
Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Nikolay Borisov <nborisov@suse.com>
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2dc52a..1bd5f4c72c8b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -940,9 +940,7 @@ extern struct zone *next_zone(struct zone *zone);
 	for (zone = (first_online_pgdat())->node_zones; \
 	     zone;					\
 	     zone = next_zone(zone))			\
-		if (!populated_zone(zone))		\
-			; /* do nothing */		\
-		else
+		for_each_if (populated_zone(zone))
 
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
-- 
2.18.0


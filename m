Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C19C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44B320875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QGFDXC5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44B320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeGIIl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:41:56 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41097 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbeGIIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:11 -0400
Received: by mail-ed1-f50.google.com with SMTP id b12-v6so13262228edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h3R7WZ+HofYjSA3zK0EEGW3hNyyVWNEoKXFdh+kA3n4=;
        b=QGFDXC5/RhKylNsMmQoNAT50IHfzOO9DStGvxDKiFLfjvSrPeB5tYqp2hEpw7ZQdoq
         aDYzz8bUcOmBh0mTURufnHBZA9PF2SnXBY8w6oBaAN+VstMwi4i5kh/MewWx6uEanp/l
         2oC79Yipht3eqF/ebjN+e55QYtGjJcoqHJB94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h3R7WZ+HofYjSA3zK0EEGW3hNyyVWNEoKXFdh+kA3n4=;
        b=HxK7UuTZB24ny4ucGQIEMZ0c0GINO9AXynvQs/3ZuDayaaCY3QvdqBgorIKnCora3l
         z7LndvVC10jb4BioevD56WhmHpiCJhp9yLCClyq9xaPLS0dCqcWi9tccYjhQyTOUBG4w
         5FAAaNKlXRG+PEuXhh7PxrS369Jz0+L93v6qBkVzVoB/FuzG6SZr4s2Kj3/u+zwSCl2M
         LCLQPa+bu8/XrDZI36CsWpmPOP6E+aaW5tpygMVlIxfs+1fh+iY+m3WL0OCN73fWTkKk
         6tN4hkp7nqZyfc6TxjkThKVHs/jp7VID441zAGiOzaCANChC5Eqra6b7JgfZaHEi8G5T
         Gdcg==
X-Gm-Message-State: APt69E2JSh33IZYnN2suZxLs5Z41XVznL1l6xR4ggXeegC1L0sDForUk
        Z9Z5rmPTzIUUXosE/bgf8uokLGMG
X-Google-Smtp-Source: AAOMgpdDFj1yAJHTDVaHbPMA6olWmMDq6yY4ongqwSx41gP9JdcnFMHI8fKfgxVYkK6m34W0ZRZM0A==
X-Received: by 2002:a50:b306:: with SMTP id q6-v6mr20728396edd.264.1531125429583;
        Mon, 09 Jul 2018 01:37:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:08 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/12] sched: use for_each_if in topology.h
Date:   Mon,  9 Jul 2018 10:36:49 +0200
Message-Id: <20180709083650.23549-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids complaints from gcc about ambiguous else clauses.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..4fba5a5b148d 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -40,7 +40,7 @@
 
 #define for_each_node_with_cpus(node)			\
 	for_each_online_node(node)			\
-		if (nr_cpus_node(node))
+		for_each_if (nr_cpus_node(node))
 
 int arch_update_cpu_topology(void);
 
-- 
2.18.0


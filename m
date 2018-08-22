Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D24C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D399E208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D399E208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeHVM4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42739 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1039834wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxUagGrg5D666cpnIjgBZsQJk+sz7QTKW02cy3LKoaE=;
        b=G5fKl/fNGuEYvwT4yVnN3Zr+jyHmLiOV4KKpKmilZaAlKrMpWnBifubLj4lCpKAcG7
         Svl4qe5nyf+y9ytjOc58ODskrcQfNrTfKR8vHuhP86kPuSRnowBgwEe35bjOiGOnXKLY
         MSl6min0+iTXSX31olGe59J5sCoacI857i8QXxx7ylmFAlfpKJ1A9G4s+ovMj5T6iSFL
         NM7frzSZpGR61+uSzCwTI3T2dvKoJYPuOBuQY3affFc3b7rWptKndR4n1dWBIrm61F8Q
         RzEKWaqjyQSvz+FHzU+cChydOrrr/XR/H73jZNzilCpbvIgI50Y8yu2JQoyk/Ph0bEBU
         mPrQ==
X-Gm-Message-State: APzg51DQgscuP1fvLiTzkOzc8L5qR2gQuyFds+uWxSRHUhWhTyYNQys6
        41yBVcwBSBIJJyhN3RyyDb0=
X-Google-Smtp-Source: ANB0VdYF/NAGu5c3hvht6sSSFszgiUORPgrM7HTAMBTHGwg8K6Fg51jSrRQF6DXfaHH3XTD2dxlrKA==
X-Received: by 2002:adf:b609:: with SMTP id f9-v6mr6051323wre.14.1534930354670;
        Wed, 22 Aug 2018 02:32:34 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 144-v6sm2290164wma.19.2018.08.22.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:33 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 992EF124A16;
        Wed, 22 Aug 2018 11:32:31 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 4/5] mm/memory_hotplug: Tidy up node_states_clear_node
Date:   Wed, 22 Aug 2018 11:32:25 +0200
Message-Id: <20180822093226.25987-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180822093226.25987-1-osalvador@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

node_states_clear has the following if statements:

if ((N_MEMORY != N_NORMAL_MEMORY) &&
    (arg->status_change_nid_high >= 0))
	...

if ((N_MEMORY != N_HIGH_MEMORY) &&
    (arg->status_change_nid >= 0))
	...

N_MEMORY can never be equal to neither N_NORMAL_MEMORY nor
N_HIGH_MEMORY.
This is wrong, so let us get rid of it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0f2cf6941224..006a7b817724 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1564,12 +1564,10 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_normal >= 0)
 		node_clear_state(node, N_NORMAL_MEMORY);
 
-	if ((N_MEMORY != N_NORMAL_MEMORY) &&
-	    (arg->status_change_nid_high >= 0))
+	if (arg->status_change_nid_high >= 0)
 		node_clear_state(node, N_HIGH_MEMORY);
 
-	if ((N_MEMORY != N_HIGH_MEMORY) &&
-	    (arg->status_change_nid >= 0))
+	if (arg->status_change_nid >= 0)
 		node_clear_state(node, N_MEMORY);
 }
 
-- 
2.13.6


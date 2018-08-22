Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AECDC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F385E208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385E208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeHVM4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so1050959wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqnYEmFfSStfubGMhFL+km+dqzq3LfNEkBqGNnMeElQ=;
        b=mT127ANW4sUa5UrYAAPiV2ytdwSh/40+7xEhQVCdd3/E6YLq+ogRvD3F9tJBC4nciP
         HtnCDGRsBtsmdxmMFApmY9scd8ZVoRTSXUsnOVC5hizAx+gI6/p9OqtuZKPzDvrqDZz7
         Pq/0g8BGn8YIqaVjYjKdh6QtKibQaVpqp8iXeCoL3kxkjQvGLSGG0yEYxmmJkhu0veLD
         l3fCDbAhg2/I0AHT6E3Xy3tmknEFlFG6sVHDY39Huw2IqCxn8yleJ6GJvDMm/u0OLoO/
         cz1kWeeMpUCiE5Cl0V0zLY3lTajYWOEEB7ieIDmNeK1E1Hin95ggIrci5VAZFfPqP+34
         /8kw==
X-Gm-Message-State: APzg51AxiXDe7vbUYPVVwfvpjSBCmzHMo2lkfjJzA4qOlivhods8cgNX
        9whrgebSn/GMWM2QR57uNME=
X-Google-Smtp-Source: ANB0VdaMqTgfSCWdBjDRWYuv35U7h8b01944NhHcAT1EEOisqVc/6/il5v1eAiDgMt/VUXU7oa0A+A==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr10482285wrj.3.1534930353055;
        Wed, 22 Aug 2018 02:32:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1148938wmf.21.2018.08.22.02.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:32 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id E69A3124A13;
        Wed, 22 Aug 2018 11:32:30 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 1/5] mm/memory_hotplug: Spare unnecessary calls to node_set_state
Date:   Wed, 22 Aug 2018 11:32:22 +0200
Message-Id: <20180822093226.25987-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180822093226.25987-1-osalvador@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

In node_states_check_changes_online, we check if the node will
have to be set for any of the N_*_MEMORY states after the pages
have been onlined.

Later on, we perform the activation in node_states_set_node.
Currently, in node_states_set_node we set the node to N_MEMORY
unconditionally.
This means that we will call node_set_state for N_MEMORY every time
pages go online, but we only need to do it if the node has not yet been
set for N_MEMORY.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 60b67f09956e..4a89915e1467 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -746,7 +746,8 @@ static void node_states_set_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_high >= 0)
 		node_set_state(node, N_HIGH_MEMORY);
 
-	node_set_state(node, N_MEMORY);
+	if (arg->status_change_nid >= 0)
+		node_set_state(node, N_MEMORY);
 }
 
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
-- 
2.13.6


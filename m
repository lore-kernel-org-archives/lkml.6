Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3085C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C452148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C452148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeHVM4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:56:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53286 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeHVM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:56:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so1385011wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wz8/ynznSqcf8dsCpQK0BPCP5e0b9FrI7V6UJn+hlEA=;
        b=f2iBc+XsBiNnn1p71xWbaFzCCyD3lgwCxYBOwAPw+ibbYpLXWUWnGNemOtpERWXhJx
         oJW7D32ucy/7sa+cMgeoYafQ5yY2HAPMvKnshzXzdiP2noN8JeSA4cc72r1JnhcG0eHu
         utIzNZNJrVHi2nFplXFBd5wqJnK/YQPnPNWElSmwduVOwEcAAln2tpty7bu/fdEbbfbm
         BdQJy5CzYP7MPiUFECcaOHZvV9Zy2dPr1eXG4S141ZNRL9WOgFLsQAUIiiE63T7Kr7tq
         YsBIeEyMApd8Eul66e2W126JErBwJrVEmOR3mGk0wHMwS7brpZn7t+S06aq8hVFwK0D5
         kILg==
X-Gm-Message-State: APzg51CWBPWs0cPe9Ya0BZV/aFx+epjROpCRlZqmwQHc5BBiHvVuSQil
        RvMgJXnYKZW5/KrbFyb9nA8=
X-Google-Smtp-Source: ANB0VdbHrwXHXSCrKU8pWVOCF9UhkYpALTex3Krz0ZWw3HwbSHiQkxhOSXexVU1R2czef+JwNwC86g==
X-Received: by 2002:a1c:6f8b:: with SMTP id c11-v6mr1937798wmi.138.1534930353518;
        Wed, 22 Aug 2018 02:32:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t13-v6sm940418wrr.74.2018.08.22.02.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:32:32 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 2DF57124A14;
        Wed, 22 Aug 2018 11:32:31 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, malat@debian.org,
        david@redhat.com, Pavel.Tatashin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 2/5] mm/memory_hotplug: Avoid node_set/clear_state(N_HIGH_MEMORY) when !CONFIG_HIGHMEM
Date:   Wed, 22 Aug 2018 11:32:23 +0200
Message-Id: <20180822093226.25987-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180822093226.25987-1-osalvador@techadventures.net>
References: <20180822093226.25987-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, when !CONFIG_HIGHMEM, status_change_nid_high is being set
to status_change_nid_normal, but on such systems, N_HIGH_MEMORY equals
N_NORMAL_MEMORY.
That means that if status_change_nid_normal is not -1,
we will perform two calls to node_set_state for the same memory type.

Set status_change_nid_high to -1 for !CONFIG_HIGHMEM, so we skip the
double call in node_states_set_node.

The same goes for node_clear_state.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4a89915e1467..1cfd0b5a9cc7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -724,7 +724,11 @@ static void node_states_check_changes_online(unsigned long nr_pages,
 	else
 		arg->status_change_nid_high = -1;
 #else
-	arg->status_change_nid_high = arg->status_change_nid_normal;
+	/*
+	 * When !CONFIG_HIGHMEM, N_HIGH_MEMORY equals N_NORMAL_MEMORY
+	 * so setting the node for N_NORMAL_MEMORY is enough.
+	 */
+	arg->status_change_nid_high = -1;
 #endif
 
 	/*
@@ -1547,7 +1551,11 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 	else
 		arg->status_change_nid_high = -1;
 #else
-	arg->status_change_nid_high = arg->status_change_nid_normal;
+	/*
+	 * When !CONFIG_HIGHMEM, N_HIGH_MEMORY equals N_NORMAL_MEMORY
+	 * so clearing the node for N_NORMAL_MEMORY is enough.
+	 */
+	arg->status_change_nid_high = -1;
 #endif
 
 	/*
-- 
2.13.6


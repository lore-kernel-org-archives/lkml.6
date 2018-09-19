Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD926C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FF22150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FF22150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbeISPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:45:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36935 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbeISPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:45:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so6196455wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=thpIlUtOEixjbYz3iacVqH1ZUY3x4M6r2oBABcQxPm8=;
        b=WQEF4p4jcXmvuO3rSe9BUeg069AdmhAQTySrd3J1Ga41G/XRiOXfcLYcOguRfi9QVb
         aD1UR8YiRHtA994HYlwF9QxqnnmUfgwy7LesIF3UVB3l0HVCJSWQWJKDl9w6fRa2QBJ3
         OLipbum34Adi0bXRIsxBdzzgsfXCu47gmUCQfssEz4c4JU4hlcISW2tyH1fyvEspE4UM
         smhmABrvg2nC5Nz5ZTSU23WxStuQNgRK1krRDZfSTOpnY2+IHY1nXjzUsiyJVwX5l/9b
         bA3VgUCB3QdjKmO89KA72TZOTCz9rwmA7ieHBWsCh5Y8H6/vlm/Xy3lSBO26apEtExpe
         EEeQ==
X-Gm-Message-State: APzg51A8wQ3A6DppXR54PkdnKfl9+vTyEh81AADC5NpGCxCOwnbEzx7M
        YC4cOA5R0rV2XLGsddyPSfSKURhnG58=
X-Google-Smtp-Source: ANB0Vdb9hbUjE5up832+eC7sgpf42oWyYQuNo3UFhWu4SB5IZgjb3XeecE0Hqcf9MEGI2nfbZKd9aQ==
X-Received: by 2002:a1c:7704:: with SMTP id t4-v6mr18488447wmi.136.1537351719861;
        Wed, 19 Sep 2018 03:08:39 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g7-v6sm18529017wrw.30.2018.09.19.03.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 03:08:38 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id E9D441253C3;
        Wed, 19 Sep 2018 12:08:37 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/5] mm/memory_hotplug: Avoid node_set/clear_state(N_HIGH_MEMORY) when !CONFIG_HIGHMEM
Date:   Wed, 19 Sep 2018 12:08:16 +0200
Message-Id: <20180919100819.25518-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919100819.25518-1-osalvador@techadventures.net>
References: <20180919100819.25518-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, when !CONFIG_HIGHMEM, status_change_nid_high is being set
to status_change_nid_normal, but on such systems N_HIGH_MEMORY falls
back to N_NORMAL_MEMORY.
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
index 63facfc57224..c2c7359bd0a7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -731,7 +731,11 @@ static void node_states_check_changes_online(unsigned long nr_pages,
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
@@ -1555,7 +1559,11 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
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


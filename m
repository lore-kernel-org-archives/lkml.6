Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F348AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37152154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37152154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbeIUTPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:15:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54737 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeIUTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:15:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so3063473wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qxl2mXI3o+wV6JwzDlazHiKHGPEuy6rtVwzXjk1okdE=;
        b=YK7piOuJf+DMNmfcMPWeA9TGzAGlJwjqfK2Cv/inOpXiPxw2/gdEOtBm4gDNuhE5pT
         kvB+y3g42qhkcNjoFo8KG2AIg/jRafey0mOeXptRSgP4PUa7RZBtpi/kw3U/l7nshMtZ
         F3Lw+mgGndAaLIvzKRLaDuDMoZuwmzuTiy2yGn/RuLHmnL1hX8vFDTBh3anl0OTOuWYa
         POZE15LwM1EH1bU2C3KvRhk5ZEs3R9rrfSyZWWSEAISxBKNvDPs/+kaZ07N2gC+dj3Yg
         rbfoCsN5+PGDRdFMtdvcUxN4rBkjVt458kc3JwUbDBrRVb0aCuM55fXyCrO9a6q4LRZx
         2GVw==
X-Gm-Message-State: APzg51A4PIfcNAWZKqPrMLx+SQEup3swso0dQFXOX/5bRjlQGv1hpbHA
        3s014HXa3ViWAf1uS/Obdv8=
X-Google-Smtp-Source: ANB0VdYJqGQbcR5DVFKfPLIbcC0Qyje79CqbHhvieO3dVpxWazGjanFWB/C4Azg2y2ezAqVxUyaVHw==
X-Received: by 2002:a1c:b5d3:: with SMTP id e202-v6mr7170862wmf.23.1537536401935;
        Fri, 21 Sep 2018 06:26:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 75-v6sm7858782wml.21.2018.09.21.06.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:26:41 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 0DA31125332;
        Fri, 21 Sep 2018 15:26:40 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/4] mm/memory_hotplug: Spare unnecessary calls to node_set_state
Date:   Fri, 21 Sep 2018 15:26:31 +0200
Message-Id: <20180921132634.10103-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180921132634.10103-1-osalvador@techadventures.net>
References: <20180921132634.10103-1-osalvador@techadventures.net>
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
This means that we call node_set_state for N_MEMORY every time
pages go online, but we only need to do it if the node has not yet been
set for N_MEMORY.

Fix this by checking status_change_nid.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 38d94b703e9d..63facfc57224 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -753,7 +753,8 @@ static void node_states_set_node(int node, struct memory_notify *arg)
 	if (arg->status_change_nid_high >= 0)
 		node_set_state(node, N_HIGH_MEMORY);
 
-	node_set_state(node, N_MEMORY);
+	if (arg->status_change_nid >= 0)
+		node_set_state(node, N_MEMORY);
 }
 
 static void __meminit resize_zone_range(struct zone *zone, unsigned long start_pfn,
-- 
2.13.6


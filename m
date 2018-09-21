Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93377ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532172150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532172150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbeIUTPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:15:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35643 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeIUTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:15:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so3303570wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+jHGq6Iwq96rM0u3yCt0rOallYZv8FDz6OCFetpq3Y=;
        b=enC0TdPoo9/OnDx1cr0DHmV785ZWP+6hpVA61d9+hgYLjG/f0geD3VXvlGsJD7eCPo
         pBDQBChMZRv/rGT33nnNezBrwRk8XdmgbmljTHrxq97+4TXpFH0K166T88Bq52gxDGxn
         x8+x0xPnyQX4BjQDCdCAqbtT5pHmwvmdIAew2HETDBEpuNQ9TweDZ4yqBZbgQr2fZ6Ny
         r8+ITV+Y7yM/nZ4+V3IObOmPsrVrU1RaWD5kLDgdccJvJfDQcS8NaBIGrf4BbTJmobf2
         39ETJxH/DaSdVUWXr+jWdqNGcMZUrqBtKh8RwX2y2XK+WEMZ3n1rZtkiC8rA26003VKG
         5Asg==
X-Gm-Message-State: APzg51Ap1GfLp32HcG+S5K9nsRxxjtsdEV4oaaJA2StI5DnVOAzCm3HE
        jMCu/owXmVwxq3dua/wgBjQ=
X-Google-Smtp-Source: ACcGV63VnEIdtWdmykAmtjohRoKq43GYZCAWnbD21lKsgOQ0NIOfDFUJEGrdmBu11s3W5JMpAc74/Q==
X-Received: by 2002:a1c:148f:: with SMTP id 137-v6mr7024221wmu.61.1537536402509;
        Fri, 21 Sep 2018 06:26:42 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id x204-v6sm5567205wmg.27.2018.09.21.06.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:26:41 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 4F88D125334;
        Fri, 21 Sep 2018 15:26:40 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/4] mm/memory_hotplug: Tidy up node_states_clear_node
Date:   Fri, 21 Sep 2018 15:26:32 +0200
Message-Id: <20180921132634.10103-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180921132634.10103-1-osalvador@techadventures.net>
References: <20180921132634.10103-1-osalvador@techadventures.net>
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

Similar problem was found in [1].
Since this is wrong, let us get rid of it.

[1] https://patchwork.kernel.org/patch/10579155/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memory_hotplug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63facfc57224..561c44761f95 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1582,12 +1582,10 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
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


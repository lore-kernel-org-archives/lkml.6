Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87872218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87872218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeHQMDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:03:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51840 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeHQMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:03:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so6915668wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MfeLkrMnDV4y5R6Q7/PqTxz8z6E5Vlfpzpm0flHpXQo=;
        b=jSLJUXd0z9euIzBwGPYU1yyuf5cv4mge7SoEr9aKqSxkoyGukxD7E5PoeqMSwRL7VN
         CbeG8ZG2N/Ca0bnNNBBD2AE8wKmgtzqe2qVjiMBQWXp+XlBb2suHk8TPPqTxSuvHCwlQ
         1/WUH3VA4U0+566VzjklXDwj9yzSwVthZh28Q8fU/o5b1MdeUuGn9gwihWTN+H+M0xBG
         oW9WynZjDmIY5yvA9N/ePbkQRHcwNDIMqUTyzLd8+QG8sA1f1XfAlp26uC717iiZ9Dbx
         JLFPQNfBnew+pAh+ePHbhPoh7kjqrLsyubs6X3H0tyWPYnBH/RY6oXREvcFgMKMVSGZD
         vKlQ==
X-Gm-Message-State: AOUpUlGNcDe3/llyxrOCBbiZiKmejXFWKrEqGpmlyou3IrXEPWKSZa/4
        +1q9AsRDJ8oN6JwnTl3sECk=
X-Google-Smtp-Source: AA+uWPy/pwRZnkedISFcrKnIaUEnl/GVgL8mdCGJ851HnZDLaVDLDdDhn3xlCnxImgLL1CcmheN42A==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr17479406wmc.80.1534496424377;
        Fri, 17 Aug 2018 02:00:24 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f23-v6sm2105975wmc.42.2018.08.17.02.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:00:23 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B4EE6124938;
        Fri, 17 Aug 2018 11:00:21 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 4/4] mm/memory_hotplug: Drop node_online check in unregister_mem_sect_under_nodes
Date:   Fri, 17 Aug 2018 11:00:17 +0200
Message-Id: <20180817090017.17610-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817090017.17610-1-osalvador@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

We are getting the nid from the pages that are not yet removed,
but a node can only be offline when its memory/cpu's have been removed.
Therefore, we know that the node is still online.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 drivers/base/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 6b8c9b4537c9..01e9190be010 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -464,8 +464,6 @@ void unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 
 		if (nid < 0)
 			continue;
-		if (!node_online(nid))
-			continue;
 		if (node_test_and_set(nid, unlinked_nodes))
 			continue;
 
-- 
2.13.6


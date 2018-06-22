Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B15C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4935C240B8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4935C240B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeFVLUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:20:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55458 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFVLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:19:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1871335wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vppk5lepmis7Ld2t4g0iQZwPCZGyFSFB7nOgL3SbhDQ=;
        b=HWMFMKApzsY5CZi71H8YMLO5U6bQcphaYO141B/obu31OacNvawC41Mj4xgM/8NIq5
         WXDPxz6QLRVWrckmfFFLC4GJ6JXjzlkg0453BxwGWgENCXGWyV8xmO4M6rw8YHL6/xSe
         fQcY7su4oWjNafVnO7QB4JikZK5i1lxH8kPN3o+/GJlpmCXHHNhfxCEw8sknkduv4XgV
         sKgFRTv/QtjKfvx/faAS6Ap9Usrz7sJwZIsPv43e+UOtl6i/awFlu5yi35pK35m7E3a8
         wJQXxuL2LkgqAmx/pcVD+4hzRyMBznOJkeEIDgwdVYHK5HG4U22D59uDsXvHlucbkkU8
         OtXg==
X-Gm-Message-State: APt69E0CVetCXvXGDnqXk/29eAe1/d+Vu06OoTHv9vJLqz4i+M4KxfBk
        Zh6c+OASmHomlr8S/zccQkM=
X-Google-Smtp-Source: AAOMgpd76vLj66b1/STer3gs5tyb0NSbL8HccZoJFRnS0+QymhxxbOpi1ffZcql0hyYe8dpkvXpKhA==
X-Received: by 2002:a1c:47cf:: with SMTP id m76-v6mr1361484wmi.80.1529666374503;
        Fri, 22 Jun 2018 04:19:34 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l78-v6sm2718567wmb.39.2018.06.22.04.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 2B18612375D;
        Fri, 22 Jun 2018 13:19:32 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 4/4] mm/memory_hotplug: Drop unnecessary checks from register_mem_sect_under_node
Date:   Fri, 22 Jun 2018 13:18:39 +0200
Message-Id: <20180622111839.10071-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180622111839.10071-1-osalvador@techadventures.net>
References: <20180622111839.10071-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Callers of register_mem_sect_under_node() are always passing a valid
memory_block (not NULL), so we can safely drop the check for NULL.

In the same way, register_mem_sect_under_node() is only called in case
the node is online, so we can safely remove that check as well.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/node.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 845d5523812b..1ac4c36e13bb 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -404,12 +404,7 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
 	int ret, nid = *(int *)arg;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
 
-	if (!mem_blk)
-		return -EFAULT;
-
 	mem_blk->nid = nid;
-	if (!node_online(nid))
-		return 0;
 
 	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
 	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
-- 
2.13.6


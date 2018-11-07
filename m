Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F55C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688E92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688E92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeKGTso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:48:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37397 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so15140957wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4D3ilvRNbEdywbamB4FAtEIm3b4AWw0D1l/xvNW28A=;
        b=m8f0wYO1sTPQ3QWXKH46B1RrLVr5WtN0W3++SV4taHkLyubvJtZdRCU1WDbXMZ/a8w
         kvOPZ3i4khAi4Z5xEB9Ul6Ac8aV8BUs6owEnC7qG0fOrqrlJU4qo27B+mavu9Kub8df+
         95lgpc2qr3JO2x6CFw5kmYtPee9srEB7lG5njDqka8kUDTSyBwBq1UPb8mPl+JWEu015
         yrwVz3xeWT4anpwwxJ17ruZR+ftbQ5AFMd7LOBoOmZCC73xXD4110A4G4lqEwlqpYDSe
         unbaNmW5xcytfeVKOeTM5YfIyoFsM2PFI/gH68o8OptHaRMmEJwPWLTe8buYY11+RZCl
         SzZQ==
X-Gm-Message-State: AGRZ1gIOEwAoUSQCvWPlpwxqXji9WP0fs6AIp/LyzFDyJYFW5UIDlkBl
        cGJU2hYmqEtNBnMxz0sUvuU=
X-Google-Smtp-Source: AJdET5e39Bf8HqnTYRY869Rb3DDpMinUmxIe1N5NVJO5e00HwQZeHZ45MgeP6ywWcDyD1cpln9a53g==
X-Received: by 2002:a1c:4b12:: with SMTP id y18-v6mr1436028wma.122.1541585926771;
        Wed, 07 Nov 2018 02:18:46 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-140-85.eurotel.cz. [37.188.140.85])
        by smtp.gmail.com with ESMTPSA id w18-v6sm217527wrn.66.2018.11.07.02.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:18:46 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 3/5] mm, memory_hotplug: drop pointless block alignment checks from __offline_pages
Date:   Wed,  7 Nov 2018 11:18:28 +0100
Message-Id: <20181107101830.17405-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101830.17405-1-mhocko@kernel.org>
References: <20181107101830.17405-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

This function is never called from a context which would provide
misaligned pfn range so drop the pointless check.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2b2b3ccbbfb5..a92b1b8f6218 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1554,12 +1554,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	struct zone *zone;
 	struct memory_notify arg;
 
-	/* at least, alignment against pageblock is necessary */
-	if (!IS_ALIGNED(start_pfn, pageblock_nr_pages))
-		return -EINVAL;
-	if (!IS_ALIGNED(end_pfn, pageblock_nr_pages))
-		return -EINVAL;
-
 	mem_hotplug_begin();
 
 	/* This makes hotplug much easier...and readable.
-- 
2.19.1


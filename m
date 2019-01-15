Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C783C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C93A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547553798;
	bh=trYfmaJDwOX9LAzy70td0IJF2wO1lTFsLNep/FcIj0M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BHdCpvEhHrL0NsB3SNiLMrrVlw9s5RH9WzsEzM3UBLMi8jLyJ0prsrMjIOcjAp7SF
	 k5glgXwVjWIGwIxBSA+M4WkVKANgQSlkdJTJISb2YCxyLAHOBTDIn35D6T4HFKUVHF
	 dA9uPKozeUVuD26+i/aDCzxSzXwPtsNMY0WvOlDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfAOMDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:03:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41152 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfAOMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:03:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so2317839edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1AyYviTWrmxVZG7i6I3JwtFU3+Vu/ABOtg8aZQHEoDU=;
        b=fjphBDJnBZibZha5gDb8xZs9inb4d32Pw2idPAN7vDRQHcCWZ3D6jVs0BvzeKKQN7P
         iDW0pnG9uxvyNp/jD6452Y5bIJZk0BGxo8v3iEovsP9akPDVRNGNHrxohmQzxOXF83A+
         t6oIkIW2bJQbHppif/qWI4IBxYxEM45qj6JvRPo/10T3Wf+vi9fjNbdjWmTFKBb43UGM
         4YrVDwlWBLSHMTqzzfWp4Xrxt5ZrfAj1SQDArYbVYNIMmddUclQkUOoWwkCErcyDpgbw
         I4JxcFwv5+dOiCl0W80QxDZK94x1dtgTNi5nxOk+42Je4BbJNLJ9zLITslmrBC+Xv6ep
         +NhA==
X-Gm-Message-State: AJcUukewhUN0Qbjk8XC7Uws3/9C6xksezsH6P20UCQF1vxoqzK8jxCB9
        S1F+OcGwEn7kjRLIttYOgpU=
X-Google-Smtp-Source: ALg8bN6Pm52D1x6VWYSGwsa7PInXlY9o+bLrCPRRrH/SoMpTmVMg+eFjWY2khLL9Oin8Lv4xdLMLxQ==
X-Received: by 2002:a50:a938:: with SMTP id l53mr3060528edc.194.1547553794115;
        Tue, 15 Jan 2019 04:03:14 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n10sm4749260edq.33.2019.01.15.04.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:03:12 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Oscar Salvador <OSalvador@suse.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, memory_hotplug: __offline_pages fix wrong locking
Date:   Tue, 15 Jan 2019 13:03:07 +0100
Message-Id: <20190115120307.22768-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Jan has noticed that we do double unlock on some failure paths when
offlining a page range. This is indeed the case when test_pages_in_a_zone
respp. start_isolate_page_range fail. This was an omission when forward
porting the debugging patch from an older kernel.

Fix the issue by dropping mem_hotplug_done from the failure condition
and keeping the single unlock in the catch all failure path.

Reported-by: Jan Kara <jack@suse.cz>
Fixes: 7960509329c2 ("mm, memory_hotplug: print reason for the offlining failure")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b9a667d36c55..faeeaccc5fae 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1576,7 +1576,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	   we assume this for now. .*/
 	if (!test_pages_in_a_zone(start_pfn, end_pfn, &valid_start,
 				  &valid_end)) {
-		mem_hotplug_done();
 		ret = -EINVAL;
 		reason = "multizone range";
 		goto failed_removal;
@@ -1591,7 +1590,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 				       MIGRATE_MOVABLE,
 				       SKIP_HWPOISON | REPORT_FAILURE);
 	if (ret) {
-		mem_hotplug_done();
 		reason = "failure to isolate range";
 		goto failed_removal;
 	}
-- 
2.20.1


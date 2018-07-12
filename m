Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C65C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512B220C10
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbk3IXL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512B220C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeGLA4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:56:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46818 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733280AbeGLAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:55:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so3225491pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=kW4BM2WWRZgHzBJjvfunU+jFFOLoLG6zcw7MdzGSoY8=;
        b=hbk3IXL/J3lLHXjCpQ0wUvt/ZBhy/THLwHBhA/TCLhr3cB8NYU/OeqPaNAaUJYCxfq
         Va7HzMln8Z2FHz4/czpOZo5fF/v1jL5d+uNunGZetb7NFJMBbWsYefIdKkLKaqfFjwxv
         tK/7EKHVRIQYukvws6RDFHBBAE2V/EPI93DVgf9FyRRftvykthULCNjzfFfRAUu+fTm+
         yZv6fcmgdggnNo1mEIOip8vrc3N3N7a67vp2EGBj5ooMjMDVDm9rY5R77GYg9ZoBzVfq
         L3Vx7KJrpIDWz6lE+W5HqvVfyy3do4bp1eAwXxkEoG3/PN7IIqfU8nHFSR1YlvWo1Wqs
         QrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=kW4BM2WWRZgHzBJjvfunU+jFFOLoLG6zcw7MdzGSoY8=;
        b=sJJCtKME924Oh1lhnzOHMoZa0aDIbybYDFzBjHy4KPua2ZcrOUwQXs8sGkcvAi09/s
         r0IA01JXhQSSt9XVBbmmkQH1hYn1kOu7wsKpcmOiqdJHuXoGaoiFdGiqPkY/DKaMEn4a
         hqJs0+Gn8g6zNQ7cB+lH6Y/PRMsiFODUk6QSRccGK8XHfmConYWOACFZY5YQ9pAAXQIR
         +BKgVRJqZtVAnUvf0fgKTUJODsKCZ4FSrK7JhLX6/Lp601vxes/e5u17Df3me7xwtBa+
         dwJzkj66nr3iZGw8AdBeTT6zqi7VBwlQAyNIP85N3R5PyjzZb9lPD5H8xP3ZAhC5Ewl5
         gaaw==
X-Gm-Message-State: AOUpUlHX8spvrhcODSLO5e0tPaaazsu0SWkiMmlK8wsHaS5B4q1RIIfI
        76q/4RIODm3mI5Yv3Jcp/lWa5Q==
X-Google-Smtp-Source: AAOMgpe1Jb5+rYyiTjNAJ5u+GyEF9eUmej8W1rcCrQKWsBb+B0MJPCrO9xYgCemHYrdeqmGN6LwBlg==
X-Received: by 2002:a63:4f1a:: with SMTP id d26-v6mr87450pgb.121.1531356542232;
        Wed, 11 Jul 2018 17:49:02 -0700 (PDT)
Received: from [100.112.75.225] ([104.133.8.97])
        by smtp.gmail.com with ESMTPSA id t192-v6sm33362567pgc.74.2018.07.11.17.49.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 17:49:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:48:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Ashwin Chaugule <ashwinch@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] thp: fix data loss when splitting a file pmd
Message-ID: <alpine.LSU.2.11.1807111741430.1106@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__split_huge_pmd_locked() must check if the cleared huge pmd was dirty,
and propagate that to PageDirty: otherwise, data may be lost when a huge
tmpfs page is modified then split then reclaimed.

How has this taken so long to be noticed?  Because there was no problem
when the huge page is written by a write system call (shmem_write_end()
calls set_page_dirty()), nor when the page is allocated for a write fault
(fault_dirty_shared_page() calls set_page_dirty()); but when allocated
for a read fault (which MAP_POPULATE simulates), no set_page_dirty().

Fixes: d21b9e57c74c ("thp: handle file pages in split_huge_pmd()")
Reported-by: Ashwin Chaugule <ashwinch@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # v4.8+
---

 mm/huge_memory.c |    2 ++
 1 file changed, 2 insertions(+)

--- 4.18-rc4/mm/huge_memory.c	2018-06-16 18:48:22.029173363 -0700
+++ linux/mm/huge_memory.c	2018-07-10 20:11:29.991011603 -0700
@@ -2084,6 +2084,8 @@ static void __split_huge_pmd_locked(stru
 		if (vma_is_dax(vma))
 			return;
 		page = pmd_page(_pmd);
+		if (!PageDirty(page) && pmd_dirty(_pmd))
+			set_page_dirty(page);
 		if (!PageReferenced(page) && pmd_young(_pmd))
 			SetPageReferenced(page);
 		page_remove_rmap(page, true);

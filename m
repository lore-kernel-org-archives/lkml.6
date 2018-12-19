Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79D21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gl+dIS4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeLSB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:57:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33737 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeLSB5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:57:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so20616194qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 17:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ylSNxws7yRH0Tnc8ZV0TAxgbUx7pmh6/NS2B97YcY8g=;
        b=gl+dIS4CUnowjrEWlgPfuH+czU5e88dthgXl+5dT8yzfx7Vbir1LSKi5eWeO0rjKfY
         tpfYDbP05ygCBhO5G6sQ8qPOiEidju83pXaIBPm2/e7YVYhM1AgzmGSsfnraTp5/aURN
         QNbW2+aTXsyTRm0v3v/CEVIWVfFXn2g1GUFeF2GjIWzv/6A0fDQabZOskAkYARr+iiZV
         ZkMuF7MSdnKZW8lzvAqtVu3ZjdNF0RlSv4bK+EZpDu+k76iYKQBngodoz/vcZMeasNK3
         XcbemKyLgSKzrbpFnCWY4eQIShaQXzjJCSQ9P7F+xAfQ4gwWqRYxe5L/YfjyYscGM7lp
         QP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylSNxws7yRH0Tnc8ZV0TAxgbUx7pmh6/NS2B97YcY8g=;
        b=Jyt6me0UdmHvr0w/Sfeav8jkPXqxL7Mu+0FfBtVnN1nzT5TvSTdzoMIDursJjbsyam
         oK6NG/7nBwy0+FNk0BSxd5+DLMDefpuokr+lml7E2OBw0SKIQPGztT0aTEPxP4to8rN1
         mutN0uqZj1/KUUhGU7mUbnY5YqZ7ei5SFm8ZNMWzqHD6u4JbqYjf7L5xXziS/cEtxoVF
         +pLmoINw0MLEAd8B1y46SWup46uWUjnV/1l1aS5pTWIE6KpuFzPPLoOXr2UCv+V68lW3
         zNPQaGQXxh92kwwyuwt8Oc76zk2oFAbRnnwX+6JQOiK0qJqtICy7gD4bkj+ND7GNZLrb
         VsTw==
X-Gm-Message-State: AA+aEWbw5sIxwFg0lPmmJxOUnRwClxDVX2V650/5cJe6IwLX2cPbvN+9
        B+8Ar6fINMIbCDJAAlqk4BQlcw==
X-Google-Smtp-Source: AFSGD/V4xgyqnXDv3c3TSQb/hDDbthvOe2opq0qRW1voeEKjOL8UyX7eAXZpi6b6hrP8J80uMXTOVw==
X-Received: by 2002:a0c:98a1:: with SMTP id f30mr19045949qvd.224.1545184658791;
        Tue, 18 Dec 2018 17:57:38 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f8sm1123924qkf.96.2018.12.18.17.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 17:57:38 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mingo@kernel.org, mhocko@suse.com, hpa@zytor.com,
        mgorman@techsingularity.net, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm: skip checking poison pattern for page_to_nid()
Date:   Tue, 18 Dec 2018 20:57:32 -0500
Message-Id: <20181219015732.26179-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1545172285.18411.26.camel@lca.pw>
References: <1545172285.18411.26.camel@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic with page_owner=on

CONFIG_DEBUG_VM_PGFLAGS=y
PAGE_OWNER=y
NODE_NOT_IN_PAGE_FLAGS=n

This is due to f165b378bbd (mm: uninitialized struct page poisoning
sanity checking) shoots itself in the foot.

[   11.917212] page:ffffea0004200000 is uninitialized and poisoned
[   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[   11.926498] page_owner info is not active (free page?)
[   12.329560] kernel BUG at include/linux/mm.h:990!
[   12.337632] RIP: 0010:init_page_owner+0x486/0x520

At first,

start_kernel
  setup_arch
    pagetable_init
      paging_init
        sparse_init
          sparse_init_nid
            sparse_buffer_init
              memblock_virt_alloc_try_nid_raw

It poisons all the allocated pages there.

memset(ptr, PAGE_POISON_PATTERN, size)

Later,

page_ext_init
  invoke_init_callbacks
    init_section_page_ext
      init_page_owner
        init_early_allocated_pages
          init_zones_in_node
            init_pages_in_zone
              lookup_page_ext
                page_to_nid
                  PF_POISONED_CHECK <--- panic here.

This because all allocated pages are not initialized until later.

init_pages_in_zone
  __set_page_owner_handle

Fixes: f165b378bbd (mm: uninitialized struct page poisoning
sanity checking)
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/mm.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5411de93a363..f083f366ea90 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -985,9 +985,7 @@ extern int page_to_nid(const struct page *page);
 #else
 static inline int page_to_nid(const struct page *page)
 {
-	struct page *p = (struct page *)page;
-
-	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
+	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
 }
 #endif
 
-- 
2.17.2 (Apple Git-113)


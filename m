Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROIfurfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D315520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeLMTUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:20:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36589 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLMTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:20:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so1509122plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ATSRWqJA/mIg1C3W1wosnMOEVk+pcrr2xWTpQzcRCQ=;
        b=ROIfurfnO8cagb8JjBMmaBNaBV6FeFIS/QJJApq39wMJghoXxr9OZKyahfd5eAs9pl
         I/Jd1yI9+bHVd/qCX/ns7H++u540A9iCT2t6bY0jGd0isHubgGx6uB6yAYznBdPD01fU
         /YSIKS741Z51LBUOlzNOJLyKa499nSM9ynZ0t2cklIMM73lyu5vZU8qS+8/L9/E0ICH0
         LGFtFztWTPoTw4KWd+3VR0V+JPWw2Oxx+5yphE/Ju2F0rRyEpRyjuyc+V5+M3IyE837E
         qURrXDjec/Qwi9FRpPmGciEL+6SeXx0pB9uLyANWj8gONPVHYVj50O8Jb3GG1B7R275P
         bOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ATSRWqJA/mIg1C3W1wosnMOEVk+pcrr2xWTpQzcRCQ=;
        b=bg073ClHGgRpRevIA/43skfFG/ctytlyyuSl1e/RLQb05Ms/g0WFU6UgvOsAprlOT2
         iJjAcQcoJYjFsBAKjupxLFcced3OJWuBz0LbolarePvRLJbs+/BFe5J3oosaLqCkemA3
         3MYnzomNj4/MZ5FYpakTinjHEzZedYP4HS8eCRRlq87SMlXcakmXRnUvXtQJgvTIG/4A
         DBL4R2eq8+6O7o1C0b2dTHLTrUTnWpyD3bq9lQp0jE1kPyUgMeLFgwdWoI19kLPcJiIM
         U6DR0+Pg5bNZUasxHqW4+iOHBq6w+DJ9UF03j2U+QF+PE8MnqCd+MGP4TLS1FLVEAmOm
         +dgg==
X-Gm-Message-State: AA+aEWZbnxt7MMJcqgGxSbsBAq7GPMKB0exBnQFB4ywx3mFLazgTiGXX
        n9nj89tCi0Cqk4RNLrB+AXNqQbqyYyw=
X-Google-Smtp-Source: AFSGD/Ud0vm4Tf31+lFr7mgmflAhO0HQA6Me2EfLWSUzLg4fBZIfMTJEvz6dyUpCsdorJYfTIxsMRw==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4mr32748plr.298.1544728822792;
        Thu, 13 Dec 2018 11:20:22 -0800 (PST)
Received: from gmail.com (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id j21sm3749377pfn.175.2018.12.13.11.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 11:20:21 -0800 (PST)
From:   zhangjun <openzhangj@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: [PATCH v2] ubifs: fix page_count in ->ubifs_migrate_page()
Date:   Thu, 13 Dec 2018 14:20:17 -0500
Message-Id: <1544728817-2870-1-git-send-email-openzhangj@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the PagePrivate() in UBIFS is different meanings,
alloc_cma() will fail when one dirty page cache located in
the type of MIGRATE_CMA

If not adjust the 'extra_count' for dirty page,
ubifs_migrate_page() -> migrate_page_move_mapping() will
always return -EAGAIN for:
	expected_count += page_has_private(page)
This causes the migration to fail until the page cache is cleaned

In general, PagePrivate() indicates that buff_head is already bound
to this page, and at the same time page_count() will also increase.
But UBIFS set private flag when the cache is dirty, and page_count()
not increase.
Therefore, the expected_count of UBIFS is different from the general
case.

Signed-off-by: zhangjun <openzhangj@gmail.com>
---
 fs/ubifs/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 1b78f2e..890dfce 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1480,8 +1480,17 @@ static int ubifs_migrate_page(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode)
 {
 	int rc;
+	int extra_count = 0;
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
+	/*
+	 * UBIFS uses PG_private as marker and does not raise the page counter.
+	 * migrate_page_move_mapping() expects a incremented counter if
+	 * PG_private is set. Therefore pass -1 as extra_count for this case.
+	 */
+	if (page_has_private(page))
+		extra_count = -1;
+	rc = migrate_page_move_mapping(mapping, newpage, page,
+			NULL, mode, extra_count);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-- 
2.7.4


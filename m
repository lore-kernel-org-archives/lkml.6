Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EABECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410CA2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue7QFdTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410CA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeISW3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:29:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39961 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbeISW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:29:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id l63-v6so3021904pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LgKwM64f/DncxKA5cuArIvnc6ftrDf7DjKi23qGL/Kc=;
        b=Ue7QFdTwAQdgX23WFITq5N5mzyOqtW6rPKP/GIsiEw3kOZxLDdX7qC9K8ZUBuq+rH8
         T4uZApl2t8OL0OICrLBFiOye15APzDdY23OIa9EDYt5MZW8p4fgKtzfs2ac68IKfs2kU
         eaxSDMUys20t9IX7DXOQo6B6sQLrI6/oPFEJnDgFFfeP5cvQZIbOoc5JexDe3TEZLxwM
         vk9zaKZQ+Bq20wSJ0gc0NDCJ2Cll7kcCxh/DCVjZ88HVgcABBUIQHaF/Zdsaqznkosh0
         eC7nRiD+zCVBEJm7RKGbD6NEeP5zvfkPvhE30RlZpLQMdGYpjfHWVLiS0CXsRvdfD/WA
         hQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LgKwM64f/DncxKA5cuArIvnc6ftrDf7DjKi23qGL/Kc=;
        b=Z84UZMrnA9qodXYbCODksrk2ujqVTaPltHnWJ50fkD8QA3CBZQi48G9uaSM4QpQO8b
         Z2MsluWSjFfR5HDRYfnHjYEl+QkSGRh848l7mkwaoEj016k91ifTTx9NiFv0sgRxYaTi
         Nt2Qh5IKnCFvsmx60WeGdCE5Ohh/97/QlodjYRxvsI/oMConZBOSB4zjm6RUvocG/Ps0
         KbgxHcU/XLy0sQQqywDc/PgfUQY4RqYjweoy3dcNw2r2JW19Lw5oIrem3E9d7muO1/vo
         i6bzC+7bOzH6dlngchyWStN3Z5qg3j5qUOjimgGNgUbhplVOxBbCglyNJU1O4GzKCRen
         HFHQ==
X-Gm-Message-State: APzg51BUHpxCOuM410ecrUJZdVeIVl8ylthD7bFgTiByCHpjeEZmLP7S
        Qm1v+ug4KOEAYNrxGQbSUeo=
X-Google-Smtp-Source: ANB0VdZod216dxhE/r4lodZSJFGGxGyaweU/o/RngPp0GXVUT7eaQZtyrON55O/KL06mtZXQsWwiBw==
X-Received: by 2002:a62:2483:: with SMTP id k3-v6mr37429326pfk.195.1537375865700;
        Wed, 19 Sep 2018 09:51:05 -0700 (PDT)
Received: from vultr.guest ([45.76.104.171])
        by smtp.gmail.com with ESMTPSA id 70-v6sm30586863pfz.27.2018.09.19.09.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 09:51:05 -0700 (PDT)
From:   "haiqing.shq" <leviathan0992@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jack@suse.cz, mgorman@techsingularity.net, ak@linux.intel.com,
        yang.s@alibaba-inc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "haiqing.shq" <leviathan0992@gmail.com>
Subject: [PATCH] mm/filemap.c: Use existing variable
Date:   Wed, 19 Sep 2018 16:50:55 +0000
Message-Id: <1537375855-2088-1-git-send-email-leviathan0992@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "haiqing.shq" <leviathan0992@gmail.com>

Use the variable write_len instead of ov_iter_count(from).

Signed-off-by: haiqing.shq <leviathan0992@gmail.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f2..4a699ef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3012,7 +3012,7 @@ int pagecache_write_end(struct file *file, struct address_space *mapping,
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* If there are pages to writeback, return */
 		if (filemap_range_has_page(inode->i_mapping, pos,
-					   pos + iov_iter_count(from)))
+					   pos + write_len))
 			return -EAGAIN;
 	} else {
 		written = filemap_write_and_wait_range(mapping, pos,
-- 
1.8.3.1


Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105E3C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26752087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="eZ98C133"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26752087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJHGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45518 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeJHGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so11075310qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JxqdOd9EE4Ud6puwZksYGvYwfqlVV7E/378up8LtBB8=;
        b=eZ98C133Cg6t4d/yvCyQe/cGvBE5x653m4uYQeiFz7NsdRMIUMrUdXAIjhUcwnsOdN
         zuTOR7Bb0vaAhD6L2Sv/XiR7eWXN76EiNZTIn6u8dNgc6hJVy5d3sqR3tP6AXgCUSRaB
         dN9oQrOEKJZENOey4TN3pxX7b+yOfn8Nv48i15QX5FfXZz0Uj09iubgZdAnT4ZcKv3Fg
         ldwiVUq99Rjn4JT3aN2dY6gizwI42BKVJjfoAhb3G/k2oASU27toCx+Tdm3D6Oj1aKwh
         BOAM20DSyDXIBE2moID6ElGXT24ZfP40S6zF0aBGNJ6IjPcZMaod4o2BBiCwmqNiJiXd
         4nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JxqdOd9EE4Ud6puwZksYGvYwfqlVV7E/378up8LtBB8=;
        b=JK+l8BbpjGcQBFAqNX4uLq9A4dAUYNsuotrBup26mzoqh5L9CipKBKB19jBmVlZy0M
         PbFVR7FFuw2/YFBRg10sZodQE1/yDOzRDRxj20lTY9oxhxXdsQ8leVRWnuohvXvBmLB/
         R2sGgudNsw0lFU9A0Ojd38HIiBJHvYfQivMECfaQF74O6+SP0+P40gG8zETDHns+WNov
         w+TAy2eQaMvIIfZzmZ1HOwsdD3mT+21zI4IO9v+pmt9erYe93rQdVW55MeliKshDfRDw
         WvRSQXau+T8bwSgjbjiFUG8O9SCYIM2c0UkwRUkvAO4vgyKmGkKvZwgwLMLBYjIXwM2s
         rAvQ==
X-Gm-Message-State: ABuFfoglQJ6/B6FsOUSYLvV3HDSEmy/G8puDKFbcoFiUWihYWocobvo/
        /1NhX5rDl2sugndJMb2IWdLgWg==
X-Google-Smtp-Source: ACcGV63vsfGDqknILwS/ZrX5g32lqkNO38GFafasozFY5YR6KLeC/a04+EH62gQ7ON6uFZ5DbwE87w==
X-Received: by 2002:a37:8245:: with SMTP id e66-v6mr16947463qkd.335.1538954900623;
        Sun, 07 Oct 2018 16:28:20 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:19 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 19/19] orangefs: do writepages_work if a single page must be written
Date:   Sun,  7 Oct 2018 23:27:36 +0000
Message-Id: <20181007232736.3780-20-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the next page can't possibly be an append and it'll
just sit there and write pages one by one until it flushes the
saved region at the very end.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 20950f3f758a..cd1263c45bb2 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -307,6 +307,10 @@ static int orangefs_writepages_callback(struct page *page,
 	wr = (struct orangefs_write_request *)page_private(page);
 
 	if (wr->len != PAGE_SIZE) {
+		if (ow->npages) {
+			orangefs_writepages_work(ow, wbc);
+			ow->npages = 0;
+		}
 		ret = orangefs_writepage_locked(page, wbc);
 		mapping_set_error(page->mapping, ret);
 		unlock_page(page);
@@ -335,6 +339,10 @@ static int orangefs_writepages_callback(struct page *page,
 		}
 done:
 		if (ret == -1) {
+			if (ow->npages) {
+				orangefs_writepages_work(ow, wbc);
+				ow->npages = 0;
+			}
 			ret = orangefs_writepage_locked(page, wbc);
 			mapping_set_error(page->mapping, ret);
 			unlock_page(page);
-- 
2.19.0


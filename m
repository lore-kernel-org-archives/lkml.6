Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4015EC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6D6208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLiZYv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6D6208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeGIIHD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:07:03 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39065 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeGIIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:06:36 -0400
Received: by mail-yb0-f193.google.com with SMTP id k127-v6so6848979ybk.6;
        Mon, 09 Jul 2018 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2+WL8Rrlts600OCqicqhny0TcWAgvVOfv4W3BQrKIQ=;
        b=RaLiZYv39bsHaziAru4/noM+SDyHObOMsrsJgUL4YlK4Glsi7kGTSqUkwBauUPrrQi
         WUFQGfOv/TUhm8+tp5lIY1pjLsOJZqNRhuvh9e9qBGHF/bv/K48/fsYQFK9AJGTkBTW6
         d+cVUdUi/x4z6j3ot1KI7hMqlQXsza4x7Ue8A31N2M/wUj39oI5IQYvJYH6paLlul3x1
         yrrjgsli6JraA7kPqSVCgyUaj1ng8IQlKq23Q/USZQjLKiIkPktbQ4cPvIDQ/n0EYBpG
         XZMmg5ZXPk9/3avGATYgVU8IjPJDyUbjqi1ls5gEmTY1RbBW2i3kdHKoTA3As7qNPw1/
         /ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2+WL8Rrlts600OCqicqhny0TcWAgvVOfv4W3BQrKIQ=;
        b=hf9Py0jZEo1+0Cb4ommWesNSFKzGl8J1Ui/mRDsRaOMNtR/mFPaUEi+zaiz4kqnWTP
         SUz7DMgADHI3U0SORqC2kOF4w8WxPqOspTkOHQ17MydY9FqXlY5ka8YTvlsJ7L7GYhbO
         t5wrG0ta9tsB0+hAj362eUXMHWbO7llxIrzJmWZQ6tl470PS3Wx+04i5OPx5pc0IuzSe
         4oouJMZ/HUdo4YPQ7uZz/yJ+lPZ87jCA1ecFdvDjs7LaPBCknqXHhdSt7Gy+9MF9WAf2
         PBDqUYCMg/bhPfYDJqFlZK5OitiD77klSNpMTVPcN4UhGb+0X+J0MYRMhH1D55L1ILIC
         u4KQ==
X-Gm-Message-State: APt69E12dxdi2OXOZWKOV+O9vWe2gMWRnNtm0J55+qr5JwcbBZNenkJh
        /Sf3PMrfphR/nSPuSzoNB58=
X-Google-Smtp-Source: AAOMgpdOwqQpiUPkW27UmGytBiJQqrFk6dn7J0w18f9b/lbKUB4ZpN+/KH9EbMUKn2n/lyf0LTbc1g==
X-Received: by 2002:a25:2b06:: with SMTP id r6-v6mr3351455ybr.380.1531123595969;
        Mon, 09 Jul 2018 01:06:35 -0700 (PDT)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id w64-v6sm6339514ywe.46.2018.07.09.01.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:06:35 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] goldfish_pipe/mm: convert to the new put_user_page() call
Date:   Mon,  9 Jul 2018 01:05:54 -0700
Message-Id: <20180709080554.21931-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709080554.21931-1-jhubbard@nvidia.com>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For code that retains pages via get_user_pages*(),
release those pages via the new put_user_page(),
instead of put_page().

Also: rename release_user_pages(), to avoid a naming
conflict with the new external function of the same name.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 3e32a4c14d5f..3ab871c22a88 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -331,7 +331,7 @@ static int pin_user_pages(unsigned long first_page, unsigned long last_page,
 
 }
 
-static void release_user_pages(struct page **pages, int pages_count,
+static void __release_user_pages(struct page **pages, int pages_count,
 	int is_write, s32 consumed_size)
 {
 	int i;
@@ -339,7 +339,7 @@ static void release_user_pages(struct page **pages, int pages_count,
 	for (i = 0; i < pages_count; i++) {
 		if (!is_write && consumed_size > 0)
 			set_page_dirty(pages[i]);
-		put_page(pages[i]);
+		put_user_page(pages[i]);
 	}
 }
 
@@ -409,7 +409,7 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 
 	*consumed_size = pipe->command_buffer->rw_params.consumed_size;
 
-	release_user_pages(pages, pages_count, is_write, *consumed_size);
+	__release_user_pages(pages, pages_count, is_write, *consumed_size);
 
 	mutex_unlock(&pipe->lock);
 
-- 
2.18.0


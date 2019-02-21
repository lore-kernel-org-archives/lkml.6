Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E168E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550780763;
	bh=V/IEXmsuqvt9Na+MEFmN7P1mMYAkl9do3dB58LJe59U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0baB3XnB1Yaw4O6x6AJub4Vo2TtUwz3oSev784UIwllKy28uiGzmfqnh0tLYSXFju
	 MPk1lcXme/tF8t9Mq5MF4h2dgJCQ26hIWJBYe1Nth8EbCxmtK3VNyUNQzETF9J25Ss
	 DhEZnB3mx7kaNF2e1KAe6S77iqoUK/pDbJUsyC7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBUU0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:26:01 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39745 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:26:01 -0500
Received: by mail-yw1-f66.google.com with SMTP id f192so2481809ywh.6;
        Thu, 21 Feb 2019 12:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KrijerxTyGVa0Sr/JiCT9Xom8mVGoOuXytTBdA4zzLc=;
        b=DZeRQ1Cx7lSU4Ewf7c3n/VbPqOwguzYkWwq9jJP8WWr5192LlpWzYQkbsSJriptOoY
         uvCYi/Ll680AWqmDZKiJWXBAleqLCOCxh7NwsL1fTmXIp2fJjk7D+gYQo79iayalLDaw
         lI4M49V06cNbRJZcZsoNuGVW699Y09iKvwPTnVDeEyu1Zn6Wbl7lgLNJpE4CWxOiLEZS
         9Q8BSVsh9wTevREaLjjOxtrmyAQW7bkvUIeDxNV5RyxpWNj1Q6XZ9/XkPfMO2h1YgZlV
         e6tNf0MHk0JbUH0V0T6kwjx9xnBi0ugkqZ2pUq7MgV56wWhJpivR/xQO+AIQwfkps0wo
         Eo4A==
X-Gm-Message-State: AHQUAub4deBc1ZyHYDDtnpLjhfHJIeGidqnictDCQ3n/8tiR3uRq1QDP
        kyWkRmPQWk8oiKYCMwZRR80=
X-Google-Smtp-Source: AHgI3IYYriZGDkk14SK/cXRoYRHeOjBsovRy5vJNCDZWaxi4vahhSAGmn8xqGBA/6PCiKXFXGwz3vw==
X-Received: by 2002:a81:6584:: with SMTP id z126mr369424ywb.216.1550780760256;
        Thu, 21 Feb 2019 12:26:00 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.133])
        by smtp.gmail.com with ESMTPSA id a4sm6570047ywa.14.2019.02.21.12.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Feb 2019 12:25:59 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Nick Terrell <terrelln@fb.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] btrfs: zstd ensure reclaim timer is properly cleaned up
Date:   Thu, 21 Feb 2019 15:25:56 -0500
Message-Id: <20190221202556.42447-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer function, zstd_reclaim_timer_fn(), reschedules itself under
certain conditions. Switch to del_timer_sync() to ensure that the timer
function hasn't rescheduled itself.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 3e418a3aeb11..62de9a211321 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -195,7 +195,7 @@ static void zstd_cleanup_workspace_manager(void)
 	struct workspace *workspace;
 	int i;
 
-	del_timer(&wsm.timer);
+	del_timer_sync(&wsm.timer);
 
 	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
 		while (!list_empty(&wsm.idle_ws[i])) {
-- 
2.17.1


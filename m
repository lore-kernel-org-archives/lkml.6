Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A8421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhqvWFcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A8421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJSW1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:27:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeJSW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:27:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so31586348edb.11;
        Fri, 19 Oct 2018 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kd2/0m64kV3/nOg/y6IXCidXjqVVaGVawvBjizuENIA=;
        b=EhqvWFcRAXVrm/jdrJEVW32JA2yX05Z/qhPskesO1lrfrKdyRZPH4j6RBNI15pwlUB
         oGUhWh4TlWONxYHzQOWnOYXy8e854ExHjedx3l+8J+FKAsMuaWiD6ar0vWzQXN4Mf+3y
         d/nVNn5fLCKPDAf2LLaZYUawlkRLAZ1fmXP/AUgQ4rzZmLo9w37LbCgogF2apD1Ox6RY
         EVg3jf0UwHgIwsyKRD3pAOtJWughTltJTKZnhB8rVihcewBB+YumABJg8x1oMDSATEF9
         lQO2/6sPUjEfTvl6aPJvQPwqqIxYY66x2LpZtnc+/PfepL31BEbW3vX1QPawgq+zi1aa
         BbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kd2/0m64kV3/nOg/y6IXCidXjqVVaGVawvBjizuENIA=;
        b=Z0AYaKnQ+g2IqQO3xC/PKEjrfvbcoJnWRBwyTktQB+/rcab0SswOuSkCrVo5UA8YBG
         ISUAqXdtj0LntYIMy0jFW05B+9MuDXuVSGcMLMa5IgENx3InEPfq3po/1hCOsKw6aW03
         aR/PHJ8+84rTcOFXN1LaCxaHunxghOrn2RnDbT94sBBEkOszNfZWxiBVKX0XYZ3ZalX0
         uP/GBJngK5D3WlHR66WA+OCQIITA525nXBpKBctBSAkM4uFOMdX+E9u90dn/dAZg20X0
         Ytw1eBIv9ReLkVkVPeJlzehdK0LcxVBfynIv9KCIm1KiF+m5ylkvL9dOLET6yvo6AkeD
         3Qrw==
X-Gm-Message-State: ABuFfojMIgPupIUTeVfj9RcR1awPGvIDuHS9Wwr1SwE0f7swivMJ+FmT
        7g/2mRDl/RiRm4aD5BfxX54=
X-Google-Smtp-Source: ACcGV63EL+/AuqO3N6wZEosTebCwh8oVEX/tlgnj6XTvFSwBfRFRJhbx6L4hGGxOMSXcjzDUcea1Ww==
X-Received: by 2002:a17:906:6686:: with SMTP id z6-v6mr31258806ejo.144.1539958892993;
        Fri, 19 Oct 2018 07:21:32 -0700 (PDT)
Received: from jinpu-GA-870A-USB3.pb.local ([2001:1438:4010:254c:1e6f:65ff:fed4:d10])
        by smtp.googlemail.com with ESMTPSA id j22-v6sm9960996edh.47.2018.10.19.07.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 07:21:32 -0700 (PDT)
From:   Jack Wang <xjtuwjp@gmail.com>
X-Google-Original-From: Jack Wang <jinpuwang@gmail.com>
To:     shli@fb.com, linux-raid@vger.kernel.org
Cc:     xni@redhat.com, linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH] md: fix memleak for mempool
Date:   Fri, 19 Oct 2018 16:21:31 +0200
Message-Id: <1539958891-12412-1-git-send-email-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Wang <jinpu.wang@profitbricks.com>

I noticed kmemleak report memory leak when run create/stop
md in a loop, backtrace:
[<000000001ca975e7>] mempool_create_node+0x86/0xd0
[<0000000095576bcd>] md_run+0x1057/0x1410 [md_mod]
[<000000007b45c5fc>] do_md_run+0x15/0x130 [md_mod]
[<000000001ede9ec0>] md_ioctl+0x1f49/0x25d0 [md_mod]
[<000000004142cacf>] blkdev_ioctl+0x680/0xd00

The root cause is we alloc mddev->flush_pool and
mddev->flush_bio_pool in md_run, but from do_md_stop
will not call into md_stop but __md_stop, move the
mempool_destroy to __md_stop fixes the problem for me.

The bug was introduced in 5a409b4f56d5, the fixes should go to
4.18+

Cc: Xiao Ni <xni@redhat.com>
Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 drivers/md/md.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4c0f3e0331d5..feb6145097da 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5904,14 +5904,6 @@ static void __md_stop(struct mddev *mddev)
 		mddev->to_remove = &md_redundancy_group;
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-}
-
-void md_stop(struct mddev *mddev)
-{
-	/* stop the array and free an attached data structures.
-	 * This is called from dm-raid
-	 */
-	__md_stop(mddev);
 	if (mddev->flush_bio_pool) {
 		mempool_destroy(mddev->flush_bio_pool);
 		mddev->flush_bio_pool = NULL;
@@ -5920,6 +5912,14 @@ void md_stop(struct mddev *mddev)
 		mempool_destroy(mddev->flush_pool);
 		mddev->flush_pool = NULL;
 	}
+}
+
+void md_stop(struct mddev *mddev)
+{
+	/* stop the array and free an attached data structures.
+	 * This is called from dm-raid
+	 */
+	__md_stop(mddev);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 }
-- 
2.7.4


Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E47C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24872077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hIkKANY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24872077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIGUey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:34:54 -0400
Received: from m12-12.163.com ([220.181.12.12]:60089 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGUey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=YlA09FTrFSif2jJoTs
        XEIJ3wvjQcI6KEOsUb+cld66Y=; b=hIkKANY23LkvdBqt0CPG7qicKAqRxduXst
        HilkQUI3FTTQj4hL1lZlNOF3aKAp9yYKuGQjw+ksFQlgUJ1FllDtr5k4/8T/2e/Z
        OQ4axNnNU08DIgvhrNMbH4QiPRB30UCyU4envuvJ6yJtqZSjHCrwYZhaQIsBocaC
        cYxjhuwmI=
Received: from localhost (unknown [183.156.140.9])
        by smtp8 (Coremail) with SMTP id DMCowAD37ZK5npJbrHGiPw--.5446S5;
        Fri, 07 Sep 2018 23:52:27 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
Subject: [PATCH] drivers:s390:char:move spin_lock_bh to spin_lock in tasklet
Date:   Fri,  7 Sep 2018 08:52:13 -0700
Message-Id: <20180907155213.46439-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowAD37ZK5npJbrHGiPw--.5446S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr43KryfCF1Dtr4kKrW7urg_yoWDZrb_uF
        y09Fy2q3yjgrnFyr9Yqw1S9r98K3WkuF10kFyqgFW3Z34Sqa93W3yDZFsxGrn8CF43X3s8
        J34ft34Ska4agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUuWlPUUUUU==
X-Originating-IP: [183.156.140.9]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiNxu6R1WBY-y2agAAsG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/s390/char/tty3270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5b8af2782282..fb1bc0db7e68 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -563,7 +563,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 	char *input;
 	int len;
 
-	spin_lock_bh(&tp->view.lock);
+	spin_lock(&tp->view.lock);
 	/*
 	 * Two AID keys are special: For 0x7d (enter) the input line
 	 * has to be emitted to the tty and for 0x6d the screen
@@ -590,7 +590,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 		tp->update_flags = TTY_UPDATE_ALL;
 		tty3270_set_timer(tp, 1);
 	}
-	spin_unlock_bh(&tp->view.lock);
+	spin_unlock(&tp->view.lock);
 
 	/* Start keyboard reset command. */
 	raw3270_request_reset(tp->kreset);
-- 
2.17.1




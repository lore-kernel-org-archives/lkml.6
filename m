Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EA3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64F020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOVP4yIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64F020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeJPMBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeJPMBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902C121486;
        Tue, 16 Oct 2018 04:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663199;
        bh=QeMX3OJ58npZBni8Er0V1zM0cg/WOodn4QkuJ5oTh0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOVP4yIkgF6FXF8aXU8yQMjpNSSB5sc1pbU+kjsNiDrWDDOnC9gXgc7/XmBkAapHL
         LHjDYFFa+Ljldm6YWKxQmmpznwXXhEyM2EtUi5cYLoYk/syB0A8myjKSrxUg3qhJ2u
         HEgvT4ShFMFoapZ/N7/vzE2WlQtwpjURi4Zja7V8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 063/100] tun: initialize napi_mutex unconditionally
Date:   Tue, 16 Oct 2018 00:11:44 -0400
Message-Id: <20181016041221.135528-63-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c7256f579f8302ce2c038181c30060d0b40017b2 ]

This is the first part to fix following syzbot report :

console output: https://syzkaller.appspot.com/x/log.txt?x=145378e6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
dashboard link: https://syzkaller.appspot.com/bug?extid=e662df0ac1d753b57e80

Following patch is fixing the race condition, but it seems safer
to initialize this mutex at tfile creation anyway.

Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+e662df0ac1d753b57e80@syzkaller.appspotmail.com
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index dc2fcddb625d..410c03564a69 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -319,7 +319,6 @@ static void tun_napi_init(struct tun_struct *tun, struct tun_file *tfile,
 		netif_napi_add(tun->dev, &tfile->napi, tun_napi_poll,
 			       NAPI_POLL_WEIGHT);
 		napi_enable(&tfile->napi);
-		mutex_init(&tfile->napi_mutex);
 	}
 }
 
@@ -3241,6 +3240,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 		return -ENOMEM;
 	}
 
+	mutex_init(&tfile->napi_mutex);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;
-- 
2.17.1


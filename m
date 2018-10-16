Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714072098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="epy406gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714072098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJQBC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9422098A;
        Tue, 16 Oct 2018 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709893;
        bh=4fov1EAoCm3yRX75UW1GbcExLZzZo72c5U4YX87C/EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=epy406gz6RVMJozMyPPpIjqvSkdspnP/sXCnAobMIQI51IxQNHGxhR/HDOvXtwP4p
         fOf3yB9tKL8svw89uwyrAv2WLZk3xZtH/6orZKBzZe2YIszOG37BdWn9s42LYIcTP7
         kN462AgDS3ph8f28nbSUStDlnOyppmF+DUY9h9SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot+e662df0ac1d753b57e80@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 031/135] tun: initialize napi_mutex unconditionally
Date:   Tue, 16 Oct 2018 19:04:21 +0200
Message-Id: <20181016170517.200157017@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -319,7 +319,6 @@ static void tun_napi_init(struct tun_str
 		netif_napi_add(tun->dev, &tfile->napi, tun_napi_poll,
 			       NAPI_POLL_WEIGHT);
 		napi_enable(&tfile->napi);
-		mutex_init(&tfile->napi_mutex);
 	}
 }
 
@@ -3241,6 +3240,7 @@ static int tun_chr_open(struct inode *in
 		return -ENOMEM;
 	}
 
+	mutex_init(&tfile->napi_mutex);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;



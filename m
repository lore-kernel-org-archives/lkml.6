Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38E8EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEA4208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSnelJ2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEA4208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeFLREt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934548AbeFLQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CC4208B0;
        Tue, 12 Jun 2018 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822038;
        bh=wmPWBfgcB9mLcS3CYuZ+hrFlDc2dvnIIMp9oRXnCyyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSnelJ2qQUYEcgz9HMhHyQbIH/82Mg/LjI+Vo8h6M3bfA6QQ1R5RoAVAdglXljAN/
         WMTgo7qYzqAvGZFVgUX20XpYQwtnG1m14ULSwN3zUdkjawPKgiuR3qnYJ3JqDytrRE
         R0XhbBLkSK/STzKrR82crQff/q0TP53viSCk6rVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 14/31] kcm: Fix use-after-free caused by clonned sockets
Date:   Tue, 12 Jun 2018 18:46:17 +0200
Message-Id: <20180612164621.360578922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit eb7f54b90bd8f469834c5e86dcf72ebf9a629811 ]

(resend for properly queueing in patchwork)

kcm_clone() creates kernel socket, which does not take net counter.
Thus, the net may die before the socket is completely destructed,
i.e. kcm_exit_net() is executed before kcm_done().

Reported-by: syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/kcm/kcmsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1671,7 +1671,7 @@ static struct file *kcm_clone(struct soc
 	__module_get(newsock->ops->owner);
 
 	newsk = sk_alloc(sock_net(osock->sk), PF_KCM, GFP_KERNEL,
-			 &kcm_proto, true);
+			 &kcm_proto, false);
 	if (!newsk) {
 		sock_release(newsock);
 		return ERR_PTR(-ENOMEM);



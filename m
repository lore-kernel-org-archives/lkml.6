Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fv5MIJ3zG1sKZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D6B70608C8; Sat,  9 Jun 2018 15:35:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hinZo+JP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 539BF608B8;
	Sat,  9 Jun 2018 15:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 539BF608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeFIPfl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933082AbeFIPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A18208A3;
        Sat,  9 Jun 2018 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558536;
        bh=KVJ5efoQC2WbQnSojLJwtybRt+WOS3J6dHbKyXfwOME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hinZo+JP2uanL4LwduuESwMaiSWn1tVQqhv4aHIUzwQr3Ok1MVJtnEiKmMSM7Y76h
         h6uw4hQ4+fjrj7cM33dggUiLHcaGu9jQQgcmdVi32S7Xzdsmu3rSY59TXzvEqYe14J
         M97CZz2GU+uxSeUvD5RMESHrnkavYIysU7cNwFIw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5f1a04e374a635efc426@syzkaller.appspotmail.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/41] kcm: Fix use-after-free caused by clonned sockets
Date: Sat,  9 Jun 2018 17:29:49 +0200
Message-Id: <20180609152927.362515824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1672,7 +1672,7 @@ static struct file *kcm_clone(struct soc
 	__module_get(newsock->ops->owner);
 
 	newsk = sk_alloc(sock_net(osock->sk), PF_KCM, GFP_KERNEL,
-			 &kcm_proto, true);
+			 &kcm_proto, false);
 	if (!newsk) {
 		sock_release(newsock);
 		return ERR_PTR(-ENOMEM);

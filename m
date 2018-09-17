Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78786ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331C62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeIREgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeIREgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED90DC49;
        Mon, 17 Sep 2018 23:06:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@virtuozzo.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.14 124/126] tuntap: fix use after free during release
Date:   Tue, 18 Sep 2018 00:42:52 +0200
Message-Id: <20180917211712.100481625@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit 7063efd33bb15abc0160347f89eb5aba6b7d000e upstream.

After commit b196d88aba8a ("tun: fix use after free for ptr_ring") we
need clean up tx ring during release(). But unfortunately, it tries to
do the cleanup blindly after socket were destroyed which will lead
another use-after-free. Fix this by doing the cleanup before dropping
the last reference of the socket in __tun_detach().

Backport Note :-
Upstream commit moves the ptr_ring_cleanup call from tun_chr_close to
__tun_detach. Upstream applied that patch after replacing skb_array with
ptr_ring. This patch moves the skb_array_cleanup call from
tun_chr_close to __tun_detach.

Reported-by: Andrei Vagin <avagin@virtuozzo.com>
Acked-by: Andrei Vagin <avagin@virtuozzo.com>
Fixes: b196d88aba8a ("tun: fix use after free for ptr_ring")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -575,6 +575,7 @@ static void __tun_detach(struct tun_file
 			    tun->dev->reg_state == NETREG_REGISTERED)
 				unregister_netdevice(tun->dev);
 		}
+		skb_array_cleanup(&tfile->tx_array);
 		sock_put(&tfile->sk);
 	}
 }
@@ -2646,7 +2647,6 @@ static int tun_chr_close(struct inode *i
 	struct tun_file *tfile = file->private_data;
 
 	tun_detach(tfile, true);
-	skb_array_cleanup(&tfile->tx_array);
 
 	return 0;
 }



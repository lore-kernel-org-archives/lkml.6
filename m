Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9490C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D50720883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D50720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeFUFLj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:11:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932278AbeFUFLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A76D81A4EB6;
        Thu, 21 Jun 2018 05:11:37 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27BEE2156880;
        Thu, 21 Jun 2018 05:11:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost_net: validate sock before trying to put its fd
Date:   Thu, 21 Jun 2018 13:11:31 +0800
Message-Id: <1529557891-4828-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 05:11:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 05:11:37 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sock will be NULL if we pass -1 to vhost_net_set_backend(), but when
we meet errors during ubuf allocation, the code does not check for
NULL before calling sockfd_put(), this will lead NULL
dereferencing. Fixing by checking sock pointer before.

Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..b97a994 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1208,7 +1208,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	if (ubufs)
 		vhost_net_ubuf_put_wait_and_free(ubufs);
 err_ubufs:
-	sockfd_put(sock);
+	if (sock)
+		sockfd_put(sock);
 err_vq:
 	mutex_unlock(&vq->mutex);
 err:
-- 
2.7.4


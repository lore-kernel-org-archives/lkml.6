Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F240C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F8C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544785;
	bh=wpP0ShPa1k4VQ1t41wQj8SiDYbQCwmHbAzEqukTXxpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rkcs2rM3nUP/vshUdXJEsnKNuoUtD6ORg0K+B3UEvFl/CZa0IF2UpBoLYn1Pg8IQf
	 E7G1EJw0pwh+4LIazCJCorXDG3AkD94VNDWZvJz1Yjj1eMipVEd74G3sMaCVgASKgt
	 Vrm9nOKQjuTivKUoEXzaL5JszjdVT0U/4G8yHex0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F8C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeLKPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeLKPuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0ADE2146E;
        Tue, 11 Dec 2018 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543401;
        bh=wpP0ShPa1k4VQ1t41wQj8SiDYbQCwmHbAzEqukTXxpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/8KlxM0CGT3yxPM9SC8ry4yVduFa/08RVaBf9syIkV1yu9hyP38qqCAGMkIGcq9s
         CkC96WgxB8uTkCHW7iKB4ltgf412h3mYDdZqCx9o40qH4jUjT/61jwcz3u4fxKXtni
         Oba1wPoeZcPdSvqnZ+Z6MzIzEqsg4LHhGeZcDiUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao feng <omarapazanadi@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 37/51] vsock: lookup and setup guest_cid inside vhost_vsock_lock
Date:   Tue, 11 Dec 2018 16:41:45 +0100
Message-Id: <20181211151617.095483033@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6c083c2b8a0a110cad936bc0a2c089f0d8115175 ]

Multi vsocks may setup the same cid at the same time.

Signed-off-by: Gao feng <omarapazanadi@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0ec970ca64ce..6bca57896915 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -50,11 +50,10 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *__vhost_vsock_get(u32 guest_cid)
 {
 	struct vhost_vsock *vsock;
 
-	spin_lock_bh(&vhost_vsock_lock);
 	list_for_each_entry(vsock, &vhost_vsock_list, list) {
 		u32 other_cid = vsock->guest_cid;
 
@@ -63,15 +62,24 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 			continue;
 
 		if (other_cid == guest_cid) {
-			spin_unlock_bh(&vhost_vsock_lock);
 			return vsock;
 		}
 	}
-	spin_unlock_bh(&vhost_vsock_lock);
 
 	return NULL;
 }
 
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+{
+	struct vhost_vsock *vsock;
+
+	spin_lock_bh(&vhost_vsock_lock);
+	vsock = __vhost_vsock_get(guest_cid);
+	spin_unlock_bh(&vhost_vsock_lock);
+
+	return vsock;
+}
+
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
@@ -607,11 +615,12 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 		return -EINVAL;
 
 	/* Refuse if CID is already in use */
-	other = vhost_vsock_get(guest_cid);
-	if (other && other != vsock)
-		return -EADDRINUSE;
-
 	spin_lock_bh(&vhost_vsock_lock);
+	other = __vhost_vsock_get(guest_cid);
+	if (other && other != vsock) {
+		spin_unlock_bh(&vhost_vsock_lock);
+		return -EADDRINUSE;
+	}
 	vsock->guest_cid = guest_cid;
 	spin_unlock_bh(&vhost_vsock_lock);
 
-- 
2.19.1




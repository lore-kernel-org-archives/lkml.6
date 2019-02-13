Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFD2222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025553;
	bh=eWsSZbjbDrVArJOI3n83hPN+X+JWLwk21l7xUq0V/98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tMg25eKmAtpoqvgdT0BifIT/M3T0SJQu5espEP0XZ71nX9AvvTVkBWw6HS6lC5ZdL
	 WiAKVRiDRwJscehzUA62v46+wTB7J0LCznh21PGTm74XA6L6XamnQ8Ab7VQ1tSt08F
	 jAbD9PX4q1+Z1gj7ID/ZfPwi4IXvrWF7ooo+fKsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbfBMCir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbfBMCip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF13C222C7;
        Wed, 13 Feb 2019 02:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025524;
        bh=eWsSZbjbDrVArJOI3n83hPN+X+JWLwk21l7xUq0V/98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK9FgDw1g2hcdRXUqDvzeecQtL08On3faXdY/iy5KOXWMQXOdx8/MoX/RL0v48Bkk
         8OUux9ONQ5FzKsCmxH8GYjmVS4Cq7YtWNMuhhOerbcgcxfA7NGS7DZqAmXuzXgX9Gp
         mrZYKvSMeTOOwR4xEAJ54wVOdl3vkHAVhFxDnhVg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/83] vhost: return EINVAL if iovecs size does not match the message size
Date:   Tue, 12 Feb 2019 21:36:39 -0500
Message-Id: <20190213023701.20286-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

[ Upstream commit 74ad7419489ddade8044e3c9ab064ad656520306 ]

We've failed to copy and process vhost_iotlb_msg so let userspace at
least know about it. For instance before these patch the code below runs
without any error:

int main()
{
  struct vhost_msg msg;
  struct iovec iov;
  int fd;

  fd = open("/dev/vhost-net", O_RDWR);
  if (fd == -1) {
    perror("open");
    return 1;
  }

  iov.iov_base = &msg;
  iov.iov_len = sizeof(msg)-4;

  if (writev(fd, &iov,1) == -1) {
    perror("writev");
    return 1;
  }

  return 0;
}

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vhost.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cf82e7266397..7a07b0e86644 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1035,8 +1035,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 	int type, ret;
 
 	ret = copy_from_iter(&type, sizeof(type), from);
-	if (ret != sizeof(type))
+	if (ret != sizeof(type)) {
+		ret = -EINVAL;
 		goto done;
+	}
 
 	switch (type) {
 	case VHOST_IOTLB_MSG:
@@ -1055,8 +1057,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 
 	iov_iter_advance(from, offset);
 	ret = copy_from_iter(&msg, sizeof(msg), from);
-	if (ret != sizeof(msg))
+	if (ret != sizeof(msg)) {
+		ret = -EINVAL;
 		goto done;
+	}
 	if (vhost_process_iotlb_msg(dev, &msg)) {
 		ret = -EFAULT;
 		goto done;
-- 
2.19.1


Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9449C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C40B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C40B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeLMOyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:54:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:37262 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbeLMOyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:54:01 -0500
Received: from [172.16.24.163] (helo=snorch.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ptikhomirov@virtuozzo.com>)
        id 1gXSNA-0004sZ-VA; Thu, 13 Dec 2018 17:53:57 +0300
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] vhost: return EINVAL if iovecs size does not match the message size
Date:   Thu, 13 Dec 2018 17:53:50 +0300
Message-Id: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/vhost/vhost.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3a5f81a66d34..03014224ef13 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1024,8 +1024,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 	int type, ret;
 
 	ret = copy_from_iter(&type, sizeof(type), from);
-	if (ret != sizeof(type))
+	if (ret != sizeof(type)) {
+		ret = -EINVAL;
 		goto done;
+	}
 
 	switch (type) {
 	case VHOST_IOTLB_MSG:
@@ -1044,8 +1046,10 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 
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
2.17.1


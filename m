Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A3A21852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129818;
	bh=n7TF+xSzDu8HYgrTyBlaVQJI+rnsY81MQVVn1m6itqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YfGtUdiHm2Zf4UrWHq+K1cKtlwsI+T4mtQsW10I7G2eB+4jYokodGO+QcCYjBGRj1
	 +po7LAM1KSWvBhLiQdP4EsTKG100jhBdUL4mDU2k1zItn/kQE2BNh2SwqCJI9x4ByZ
	 x15WSVMFVIMQRkpMk2YCWO6Ds7cY2F98/3LLr2sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfBYVXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfBYVXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478B121855;
        Mon, 25 Feb 2019 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129812;
        bh=n7TF+xSzDu8HYgrTyBlaVQJI+rnsY81MQVVn1m6itqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSsOXqGUNalsVcSPFv1/ruiiXRraS2+6PTA5IDONRM9yhaYmzV6OLzKsjtSebze2Y
         SA1T/fCoON7aKQmHldcXRWZ1WSGq0YTvFqgAoiTHAkYYrCCdn4FAuOxlAVdlBoLB2k
         h0VL0YZBGlOLF/T8tORTLNB6+Uj/4aiPplIe/x3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/152] vhost: return EINVAL if iovecs size does not match the message size
Date:   Mon, 25 Feb 2019 22:11:08 +0100
Message-Id: <20190225195048.396634611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5eaeca805c95c..b214a72d5caad 100644
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




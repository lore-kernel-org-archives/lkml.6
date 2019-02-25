Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2520652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130947;
	bh=rPK8IA8JJ5/DghMAIZKKs091BdJC0Aa+nqtS/4imRfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfcV1lyuIX+E5/7rv7+kd6yaFtsOMLkoXjhJjD5kQFtW06BGs3nFeT4ti/irOexgt
	 ms1dBysT4XZ0Nvwiv/HvdEsuj1DvXYhlb8ZBgu8r9rQzMQmkCbhTjiy/E119PMazsy
	 bNFYmpik3+f39pu031/WHjlXHRWvOkcz34S/6AT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfBYVcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732461AbfBYVcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C7CF21841;
        Mon, 25 Feb 2019 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130337;
        bh=rPK8IA8JJ5/DghMAIZKKs091BdJC0Aa+nqtS/4imRfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o39L/JJZWNzvIrTUwLiTfQZAobc+/nyYdRyS0URHCgsneUWiTNxbN4SraB08mWfBN
         2awnM2XQ2+hLgohdCBaJaFo8gnlKO8K1HqqBErNZH9R067U4+flLDvQD7IvMnab7k5
         DnYIrLpAiN8TrmjlTBZ7+HjMSsRUV7FsvIeJVQtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 088/183] vhost: return EINVAL if iovecs size does not match the message size
Date:   Mon, 25 Feb 2019 22:11:01 +0100
Message-Id: <20190225195109.411544857@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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




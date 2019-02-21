Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376B220700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760246;
	bh=aYvx4gQA6EkZrFEeVV+qaFjeINyZtyJjmxP2HXVVGvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdN4TveU5ScGSHKNGad6V46AINBlsmiW145TUTTujnplbg/+vueb+oyHv0hYHbvs5
	 VwmYmrULUW3FMXEk/fE4NK+Z5eLRNbuh+tgQ8HI23U++vR/PWHQNpev8wy018S48fm
	 cc/TfFYHWexB3IqwEC/d8f9u3nUreO4fD0Mcdnoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfBUOoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfBUOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF2F20700;
        Thu, 21 Feb 2019 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760239;
        bh=aYvx4gQA6EkZrFEeVV+qaFjeINyZtyJjmxP2HXVVGvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZoYjxWWrnUuoig3sKeYvpW/NGFM73M5SMljVuFdGQNKikzJUDlXeL7hlrYinacdI
         +WB/xJhelTO9V1BbEmZYqdjkbRC0vn6aSV2RcGjQurGeloItecdqrok/i4C77/iMM5
         8BCSxWClP+/JE4KTP2YoFRNYtg3jKI169rFfOJCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 15/32] vhost: correctly check the return value of translate_desc() in log_used()
Date:   Thu, 21 Feb 2019 15:36:03 +0100
Message-Id: <20190221125251.753664872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

[ Upstream commit 816db7663565cd23f74ed3d5c9240522e3fb0dda ]

When fail, translate_desc() returns negative value, otherwise the
number of iovs. So we should fail when the return value is negative
instead of a blindly check against zero.

Detected by CoverityScan, CID# 1442593:  Control flow issues  (DEADCODE)

Fixes: cc5e71075947 ("vhost: log dirty page correctly")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cf82e72663976..5eaeca805c95c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1784,7 +1784,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
 
 	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
 			     len, iov, 64, VHOST_ACCESS_WO);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < ret; i++) {
-- 
2.19.1




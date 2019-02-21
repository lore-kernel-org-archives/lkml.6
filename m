Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B312080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759993;
	bh=yT6xKSNdPxXMa26GRq6rdRU0mi74A3IV+b+8GEuqQPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TfE4Mv/4gc7nxmqpvpVMME37+LouwZrnsYNKYV+VngNnRhH8DkGlJSza1NVWocr4j
	 ZzOoZGXcTzJRE2UnqKnGxw9IGfhEXpbFkv0TRj3z5mEzft85vjZjV1L1exZ2ETUFDI
	 v0l+O+mbPG4ODsnjAscoN/TnLJM3gVztKqugMe9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfBUOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfBUOjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F71F2080D;
        Thu, 21 Feb 2019 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759988;
        bh=yT6xKSNdPxXMa26GRq6rdRU0mi74A3IV+b+8GEuqQPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1k3aSRh9wLbdet2aqDxRbOve/Ar2EA8EIvOZ3yEveJoNlghamijAlwUVri/XbFuz
         GzI+qoXbqQJyUhvBbzQxjaHVcuxMqRDyyxW8Ji2kxbdSPLEdo8W/p1wPV6eIJ7WdNM
         Z5V5Ytc/aAg3WKKMvLTi7M/VBoBZEt+NxciQnglk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/23] vhost: correctly check the return value of translate_desc() in log_used()
Date:   Thu, 21 Feb 2019 15:35:57 +0100
Message-Id: <20190221125247.454208547@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1776,7 +1776,7 @@ static int log_used(struct vhost_virtque
 
 	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
 			     len, iov, 64, VHOST_ACCESS_WO);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < ret; i++) {



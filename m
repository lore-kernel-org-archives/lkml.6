Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E6ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC0D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXIL11Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC0D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeJSCJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbeJSCJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:11 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8E1204FD;
        Thu, 18 Oct 2018 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886023;
        bh=5Vbl6A0NUE6qRVXTbD3/fBJGtVmAGFMc6/HCqLDyE/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXIL11JinmolID1IUcsT1GSFa75yJJnrvQ69rOr/5TFJoQlvcPROIYIDR0hif52oB
         UJuihECtTH8wDRkvSxjb5oS0ofaZFa1tGHhaUmgPvwAfBxf8nJHtZB8TSE+6j6bHu7
         bt5zQqwlteqEnYqeeAcjYUmZW7IiBtZkBeflqE1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jozef Balga <jozef.balga@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 35/48] media: af9035: prevent buffer overflow on write
Date:   Thu, 18 Oct 2018 19:55:10 +0200
Message-Id: <20181018175429.813937162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozef Balga <jozef.balga@gmail.com>

[ Upstream commit 312f73b648626a0526a3aceebb0a3192aaba05ce ]

When less than 3 bytes are written to the device, memcpy is called with
negative array size which leads to buffer overflow and kernel panic. This
patch adds a condition and returns -EOPNOTSUPP instead.
Fixes bugzilla issue 64871

[mchehab+samsung@kernel.org: fix a merge conflict and changed the
 condition to match the patch's comment, e. g. len == 3 could
 also be valid]
Signed-off-by: Jozef Balga <jozef.balga@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/dvb-usb-v2/af9035.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -389,8 +389,10 @@ static int af9035_i2c_master_xfer(struct
 			    msg[0].addr == (state->af9033_i2c_addr[1] >> 1))
 				reg |= 0x100000;
 
-			ret = af9035_wr_regs(d, reg, &msg[0].buf[3],
-					msg[0].len - 3);
+			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
+							         &msg[0].buf[3],
+							         msg[0].len - 3)
+					        : -EOPNOTSUPP;
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];



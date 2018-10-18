Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8191ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C321480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP2fK+OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9C321480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeJSCE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbeJSCE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:27 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A4121479;
        Thu, 18 Oct 2018 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885740;
        bh=sNM/uklTRzpuf1DpOU1o7QcEMtw704TBnGfFT95hkRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IP2fK+OUSTi7cOJ7TnG2wTLVsNX93jTSamyEkT2SpTlgRFvR+g9t9mvLlsEy4D/PW
         7mipvxpOBEGgK9ZK4JMeG5jXMzIypEdWgwcdnYvS/66yyjljV4siQWqvWWixG144ql
         +6aGTxN3TuyNuWuaHinGXI+Isyi5nXt55bcvHB3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jozef Balga <jozef.balga@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 01/35] media: af9035: prevent buffer overflow on write
Date:   Thu, 18 Oct 2018 19:54:30 +0200
Message-Id: <20181018175422.665119275@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -406,8 +406,10 @@ static int af9035_i2c_master_xfer(struct
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



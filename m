Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EADBC67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECE820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108049;
	bh=r6cq+FbqMDiU4mdKnP4W2IRrXinrx92qm3jdB4nH+H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gsf1M3yNUwZTb0xQHyaL6YrsIjBug1sCej9mEnY1LWtB0qDcSERh0CTb4BASlLaRW
	 iIH3SCDk/d98w3v3TMUNrENi4bIBZonqoeoHlmQwxjLXDi5/qu7h2FxXVeaI4N7qt2
	 lBYkloC3M4b1Fw8XYcLn9HKDdTgFNBrsa85JPEzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECE820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLFOyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:54:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLFOo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:44:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD23D21479;
        Thu,  6 Dec 2018 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107497;
        bh=r6cq+FbqMDiU4mdKnP4W2IRrXinrx92qm3jdB4nH+H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z78NMmhz+RtkfNGdyfXq4Y5lbEj1t9fgBuVuhAfa+G4r2gDg/S4YHnj/+fAJjfb2H
         LOCqzRPSUseh3VmXffHC+jnNUk8ihJFlSyBrsHJjl45VS2HRXqJIk6dgqXqzyfHM3P
         vCZ1UpW8iBm2LsU6RG89olBruj1V+DoRrZO3A03o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 028/101] Input: xpad - quirk all PDP Xbox One gamepads
Date:   Thu,  6 Dec 2018 15:38:27 +0100
Message-Id: <20181206143013.194415822@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Cameron Gutman <aicommander@gmail.com>

commit a6754fae1e66e9a40fed406290d7ca3f2b4d227c upstream.

Since we continue to find tons of new variants [0,1,2,3,4,5,6] that
need the PDP quirk, let's just quirk all devices from PDP.

[0]: https://github.com/paroj/xpad/pull/104
[1]: https://github.com/paroj/xpad/pull/105
[2]: https://github.com/paroj/xpad/pull/108
[3]: https://github.com/paroj/xpad/pull/109
[4]: https://github.com/paroj/xpad/pull/112
[5]: https://github.com/paroj/xpad/pull/115
[6]: https://github.com/paroj/xpad/pull/116

Fixes: e5c9c6a885fa ("Input: xpad - add support for PDP Xbox One controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/joystick/xpad.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -483,18 +483,18 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init1[] = {
 	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init2[] = {
 	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
@@ -530,12 +530,8 @@ static const struct xboxone_init_packet
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),



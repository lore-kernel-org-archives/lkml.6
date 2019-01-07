Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CB82070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfAGSfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:35:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:44551 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfAGSfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:35:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 047B0FFDA1;
        Mon,  7 Jan 2019 19:35:28 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id siTQYubJCDJH; Mon,  7 Jan 2019 19:35:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A13E2FFCD0;
        Mon,  7 Jan 2019 19:34:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 543ik-S_BM0c; Mon,  7 Jan 2019 19:34:46 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id EA742FFD8D;
        Mon,  7 Jan 2019 19:34:45 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 06/16] Platform: OLPC: Avoid a warning if the EC didn't register yet
Date:   Mon,  7 Jan 2019 19:34:29 +0100
Message-Id: <20190107183439.50626-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just return EPROBE_DEFER, so that whoever attempted to use the EC call ca=
n
defer their work.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Adjust the commit message for the s/ENODEV/EPROBE_DEFER/ change

Changes since v1:
- EPROBE_DEFER instead of ENODEV

 drivers/platform/olpc/olpc-ec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 35a21c66cd0d..9ee993d5d54b 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 =
*outbuf, size_t outlen)
 	struct olpc_ec_priv *ec =3D ec_priv;
 	struct ec_cmd_desc desc;
=20
-	/* Ensure a driver and ec hook have been registered */
-	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
+	/* Driver not yet registered. */
+	if (!ec_driver)
+		return -EPROBE_DEFER;
+
+	if (WARN_ON(!ec_driver->ec_cmd))
 		return -ENODEV;
=20
 	if (!ec)
--=20
2.20.1


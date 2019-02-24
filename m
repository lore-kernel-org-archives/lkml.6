Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703F7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C7D20645
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfBXMBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:01:03 -0500
Received: from shell.v3.sk ([90.176.6.54]:50047 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfBXMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:01:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 80FDD10218B;
        Sun, 24 Feb 2019 13:01:00 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e26DaGzKBi3A; Sun, 24 Feb 2019 13:00:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 48CF5102190;
        Sun, 24 Feb 2019 13:00:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j0JVo7oGJ0wc; Sun, 24 Feb 2019 13:00:57 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A463310218B;
        Sun, 24 Feb 2019 13:00:57 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        stable@vger.kernel.org
Subject: [PATCH] serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart
Date:   Sun, 24 Feb 2019 13:00:53 +0100
Message-Id: <20190224120053.13682-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two other drivers that bind to mrvl,mmp-uart and both of them
assume register shift of 2 bits. There are device trees that lack the
property and rely on that assumption.

If this driver wins the race to bind to those devices, it should behave
the same as the older deprecated driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/=
8250_of.c
index a1a85805d010..2488de1c4bc4 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -130,6 +130,10 @@ static int of_platform_serial_setup(struct platform_=
device *ofdev,
 		port->flags |=3D UPF_IOREMAP;
 	}
=20
+	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. *=
/
+	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
+		port->regshift =3D 2;
+
 	/* Check for registers offset within the devices address range */
 	if (of_property_read_u32(np, "reg-shift", &prop) =3D=3D 0)
 		port->regshift =3D prop;
--=20
2.20.1


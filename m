Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEBDC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13192171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="pnX2D/k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbeLOOky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:40:54 -0500
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:35663
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbeLOOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id E3D331430BAF2; Sat, 15 Dec 2018 15:35:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1544884532; bh=Sq4cgqjxpSpggNqzyKKmQaYtC1F/PX6yQBz9TkzITq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnX2D/k8IKlAk6PNnSzYD/BHnrF/O1cphecyZbpZmQujEVsYVpIQCovMDivdjeY0m
         axRJCSv3kzqD55Pm9HFweutOzkp9WdI96BnA3g8vf62MrOIH4p5sc30tJ6pVPr0/Pw
         FxKioDH6EP5MEUgvkbv84lpL0rtGP0mFq/dsFN+b1l1k+k9hjee7cGYvOFZP6qQjNS
         xVKKajUj/TvnUOqLpL43/t2g5eM+BkyvHuNWKqSfzLE0gq0/Noy/dcalHX5FdeW+WX
         wXjrQeSPaktql2NnK4B3P1ZDIXILYYPHIseFJS281kSBAkIbr1zwh5Z+Cl0ppG+O9B
         tmfHda9y9LuPA==
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>,
        Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 2/4] vt: Implement parsing for >, =, < private sequences.
Date:   Sat, 15 Dec 2018 15:34:21 +0100
Message-Id: <20181215143423.4556-3-textshell@uchuujin.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181215143423.4556-1-textshell@uchuujin.de>
References: <20181215143423.4556-1-textshell@uchuujin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Private sequences can start with '>', '=' and (in theory) '<'.
Implement correct parsing for these. The newly parsable sequences are
cleanly ignored as it is customary with terminal emulators.

This allows the vt to ignore various sequences used by more capable
terminal implementations such as "Secondary Device Attributes",
"Tertiary Device Attributes" and various advanced configuration commands
that don't have dedicated terminfo entries.

Signed-off-by: Martin Hostettler <textshell@uchuujin.de>
---
 drivers/tty/vt/vt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 75826a97b0c3..448b4f6be7d1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2235,9 +2235,21 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_state=ESfunckey;
 			return;
 		}
-		vc->vc_priv = (c == '?') ? EPdec : EPecma;
-		if (vc->vc_priv != EPecma)
+		switch (c) {
+		case '?':
+			vc->vc_priv = EPdec;
+			return;
+		case '>':
+			vc->vc_priv = EPgt;
+			return;
+		case '=':
+			vc->vc_priv = EPeq;
 			return;
+		case '<':
+			vc->vc_priv = EPlt;
+			return;
+		}
+		vc->vc_priv = EPecma;
 	case ESgetpars:
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
 			vc->vc_npar++;
@@ -2250,10 +2262,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		vc->vc_state = ESnormal;
 		switch(c) {
 		case 'h':
-			set_mode(vc, 1);
+			if (vc->vc_priv <= EPdec)
+				set_mode(vc, 1);
 			return;
 		case 'l':
-			set_mode(vc, 0);
+			if (vc->vc_priv <= EPdec)
+				set_mode(vc, 0);
 			return;
 		case 'c':
 			if (vc->vc_priv == EPdec) {
-- 
2.11.0


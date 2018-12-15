Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A89C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284642084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="Yk5piCHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeLOOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:40:53 -0500
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:48473
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLOOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 598A91430BAF4; Sat, 15 Dec 2018 15:35:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1544884534; bh=LIoCc86wGNbCgELiXdML6TEo8hELMxVteKpb++SJsQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yk5piCHaE36xFzfwH+6cZtYWcAh3NJ5uRVaUXTC/y3nWKEXVBWPkvyg4lNdA9jjH6
         4a8elP8xvC8lIVyI6zhYqzP4BQVNAn+3cqGnPK9mAdAdy5k+igAMuhciQtzE23rnhf
         0VmcaHO16IvJKtDJ+1TIFY3ybtIM5PAwy7RQEJ+mx95X2kAHr+3naPN2pgDNOvUF7H
         fxcv8CCfBuY6p7jcBq7q1JXzDTdlXFeh7tfRaFX4xddeVSM27AlK2jceLrPj2a8Ujt
         QMI/sRt41Zs1Gpuh0DqfglJAwoxAcwADJfw60USnVbmPsyOOyU52HXWRPcuRSTySol
         z0qDtHtmBXHlg==
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>,
        Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 3/4] vt: ignore csi sequences with intermediate characters.
Date:   Sat, 15 Dec 2018 15:34:22 +0100
Message-Id: <20181215143423.4556-4-textshell@uchuujin.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181215143423.4556-1-textshell@uchuujin.de>
References: <20181215143423.4556-1-textshell@uchuujin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various csi sequences contain intermediate characters between the
parameters and the final character. Introduce a additional state that
cleanly ignores these sequences.

This allows the vt to ignore these sequences used by more capable
terminal implementations such as "request mode", etc.

Signed-off-by: Martin Hostettler <textshell@uchuujin.de>
---
 drivers/tty/vt/vt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 448b4f6be7d1..24cd0e9c037b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2023,7 +2023,7 @@ static void restore_cur(struct vc_data *vc)
 }
 
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
-	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
+	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
 	ESpalette, ESosc };
 
 /* console_lock is held (except via vc_init()) */
@@ -2259,6 +2259,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
 		}
+		if (c >= 0x20 && c <= 0x2f) {
+			vc->vc_state = EScsiignore;
+			return;
+		}
 		vc->vc_state = ESnormal;
 		switch(c) {
 		case 'h':
@@ -2421,6 +2425,11 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			return;
 		}
 		return;
+	case EScsiignore:
+		if (c >= 20 && c <= 0x3f)
+			return;
+		vc->vc_state = ESnormal;
+		return;
 	case ESpercent:
 		vc->vc_state = ESnormal;
 		switch (c) {
-- 
2.11.0


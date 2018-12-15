Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7703C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791E82084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uchuujin.de header.i=@uchuujin.de header.b="SxCmz2PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeLOOkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 09:40:52 -0500
Received: from static.85-10-192-230.clients.your-server.de ([85.10.192.230]:40497
        "EHLO mxout.uchuujin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeLOOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 09:40:51 -0500
Received: by neutronstar.dyndns.org (Postfix, from userid 1000)
        id 8A99C1430BAF6; Sat, 15 Dec 2018 15:35:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=uchuujin.de; s=h;
        t=1544884535; bh=kO+8JQKEHghETcTGMp8B7N1A9HZLjDbi6GLuJYNtF/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxCmz2PEcby3uXgmsInM7n2/9BnKJh+qvljUZ9INEuOyye5LQzReAb1AAmgOq5uiC
         VIrpo7UYWudx3Ns7KSaa5ylS6ztTj1y2owS5lw6DUu56AmNr1Jy0MovGorV+RVqGyF
         FpBRzyoJBYbobOgnVDK7ES9IwnGaucRSsrEk7PU9++MFRLWvehc0vj8xg30OpEc1dL
         O26HM4otmrxOKByuln0x6z2nh8TG1fERfleY6CAQg5ImrNcmXsJEx1JGPKhJmc9wF8
         /m0X4KYbE1wSTfUZlSFci3Gpbm5/0/RnsvEnaJC6km4XgLQH2pvkTF0din+TX1cnS0
         jN9CGTSfF05qQ==
From:   Martin Hostettler <textshell@uchuujin.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Egmont Koblinger <egmont@gmail.com>,
        Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 4/4] vt: ignore sequences that contain ':' in parameters.
Date:   Sat, 15 Dec 2018 15:34:23 +0100
Message-Id: <20181215143423.4556-5-textshell@uchuujin.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181215143423.4556-1-textshell@uchuujin.de>
References: <20181215143423.4556-1-textshell@uchuujin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csi sequences can contain subparameters delimited by ':' characters. For
now just ignore the whole sequence in this case. Such sequences are used by
more capable terminal implementations with T.416 high color modes or
extended underline rendition attributes.

Also ignore sequences with private use characters '?', '>', '='
and '>' that are not at the initial position.

Signed-off-by: Martin Hostettler <textshell@uchuujin.de>
---
 drivers/tty/vt/vt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 24cd0e9c037b..0aaa15c723fa 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1629,9 +1629,9 @@ static void rgb_background(struct vc_data *vc, const struct rgb *c)
 
 /*
  * ITU T.416 Higher colour modes. They break the usual properties of SGR codes
- * and thus need to be detected and ignored by hand. Strictly speaking, that
- * standard also wants : rather than ; as separators, contrary to ECMA-48, but
- * no one produces such codes and almost no one accepts them.
+ * and thus need to be detected and ignored by hand. That standard also
+ * wants : rather than ; as separators but sequences containing : are currently
+ * completely ignored by the parser.
  *
  * Subcommands 3 (CMY) and 4 (CMYK) are so insane there's no point in
  * supporting them.
@@ -2259,7 +2259,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
 		}
-		if (c >= 0x20 && c <= 0x2f) {
+		if (c >= 0x20 && c <= 0x3f) { /* 0x2x, 0x3a and 0x3c - 0x3f */
 			vc->vc_state = EScsiignore;
 			return;
 		}
-- 
2.11.0


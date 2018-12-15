Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0208BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB322171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbeLOQX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 11:23:58 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47270 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbeLOQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 11:23:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5E03B1801377B;
        Sat, 15 Dec 2018 17:23:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org
Subject: [PATCH] jffs2: Fix integer underflow in jffs2_rtime_compress
Date:   Sat, 15 Dec 2018 17:23:50 +0100
Message-Id: <20181215162350.12489-1-richard@nod.at>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtime compressor assumes that at least two bytes are
compressed.
If we try to compress just one byte, the loop condition will
wrap around and an out-of-bounds write happens.

Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/jffs2/compr_rtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jffs2/compr_rtime.c b/fs/jffs2/compr_rtime.c
index 406d9cc84ba8..cbf700001fc9 100644
--- a/fs/jffs2/compr_rtime.c
+++ b/fs/jffs2/compr_rtime.c
@@ -39,6 +39,9 @@ static int jffs2_rtime_compress(unsigned char *data_in,
=20
 	memset(positions,0,sizeof(positions));
=20
+	if (*dstlen < 2)
+		return -1;
+
 	while (pos < (*sourcelen) && outpos <=3D (*dstlen)-2) {
 		int backpos, runlen=3D0;
 		unsigned char value;
--=20
2.20.0


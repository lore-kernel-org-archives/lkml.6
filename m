Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A511C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AA6214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAUJY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:24:26 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:47542 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfAUJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:24:26 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id SxQP1z02C3XaVaC01xQPZz; Mon, 21 Jan 2019 10:24:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1glVod-000217-PF; Mon, 21 Jan 2019 10:24:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1glVod-0004pp-Mj; Mon, 21 Jan 2019 10:24:23 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] dio: Fix buffer overflow in case of unknown board
Date:   Mon, 21 Jan 2019 10:24:22 +0100
Message-Id: <20190121092422.18544-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 8.2.0:

    drivers/dio/dio.c: In function ‘dio_init’:
    drivers/dio/dio.c:240:17: warning: ‘strcpy’ writing 69 or more bytes into a region of size 64 overflows the destination [-Wstringop-overflow=]
		     strcpy(dev->name,dio_getname(dev->id));
		     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Indeed, if an unknown board is present, the target buffer will overflow.
Shorten the unknown board name string to fix this, and declare it as an
array while at it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Declare unknowndioname as an array.
---
 drivers/dio/dio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 92e78d16b476550c..c9aa15fb86a9aed0 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -89,8 +89,8 @@ static struct dioname names[] =
 #undef DIONAME
 #undef DIOFBNAME
 
-static const char *unknowndioname 
-        = "unknown DIO board -- please email <linux-m68k@lists.linux-m68k.org>!";
+static const char unknowndioname[]
+	= "unknown DIO board, please email linux-m68k@lists.linux-m68k.org";
 
 static const char *dio_getname(int id)
 {
-- 
2.17.1


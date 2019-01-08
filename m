Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD012C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A448206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfAHOGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:06:10 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:46034 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfAHOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:06:10 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Mq671z00e3XaVaC01q674B; Tue, 08 Jan 2019 15:06:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggs19-0001Le-Ee; Tue, 08 Jan 2019 15:06:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggs19-0003BH-D1; Tue, 08 Jan 2019 15:06:07 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Kars de Jong <jongk@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dio: Fix buffer overflow in case of unknown board
Date:   Tue,  8 Jan 2019 15:06:06 +0100
Message-Id: <20190108140606.12184-1-geert@linux-m68k.org>
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
Shorten the unknown board name string to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dio/dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 92e78d16b476550c..4ff65c690b04b50b 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -90,7 +90,7 @@ static struct dioname names[] =
 #undef DIOFBNAME
 
 static const char *unknowndioname 
-        = "unknown DIO board -- please email <linux-m68k@lists.linux-m68k.org>!";
+	= "unknown DIO board, please email linux-m68k@lists.linux-m68k.org";
 
 static const char *dio_getname(int id)
 {
-- 
2.17.1


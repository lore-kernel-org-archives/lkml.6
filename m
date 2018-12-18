Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E535C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2696F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLRLf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:35:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56570 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeLRLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:35:57 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gZDfF-00089R-7a; Tue, 18 Dec 2018 11:35:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: most: sound: replace snprintf with strscpy
Date:   Tue, 18 Dec 2018 11:35:52 +0000
Message-Id: <20181218113552.26916-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Using snprintf without a format specifier is potentially risky if
the string device_name contains format specifiers. Replace this with
the safer and more efficient strscpy.

Cleans up clang warning:
drivers/staging/most/sound/sound.c:673:41: warning: format string is not
a string literal (potentially insecure) [-Wformat-security]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/most/sound/sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 29a4c72e6357..ccabf5922a73 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -670,7 +670,7 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 		goto err_free_adpt;
 
 	pcm->private_data = channel;
-	snprintf(pcm->name, sizeof(pcm->name), device_name);
+	strscpy(pcm->name, device_name, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, direction, &pcm_ops);
 
 	if (create) {
-- 
2.19.1


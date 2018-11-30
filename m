Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26950C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EE62082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FC7h9H+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EE62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeLAKEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:04:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40998 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLAKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:04:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so3486725pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI0KI725ppQ0QeLybOn4zRDFbG68JsgaLaeS7ewMwVs=;
        b=FC7h9H+DMLKizpZo+y0wAxjKBRzX9yld/uScHN2kAY8wmn3wW3yEbDrCuu6kZiB0hS
         tDhgTBzWsbzx4Rb6Lh3sKonl3Li5VQN6uzO3sDwamOBOvdy6krnrPLAQslLDgILE6gLD
         CKrFVMBgiM7LJpFsbMU1qmka3pJ3AURjHWE6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vI0KI725ppQ0QeLybOn4zRDFbG68JsgaLaeS7ewMwVs=;
        b=l8zHlEOprLoVUDZrX5aZahikc+MfvtaAF2vYZEUV8aeyXZI/B2xfPQZ0TPjWTMazrP
         qCQPRZ05prTGBJACrwh/P7ODQIOnOmI7xll8b1Y0HDdFU/t8npJp4L4GJbl66nfZ21iN
         z5pZphogKytZwqk5twgWdr94O966ZC6D0FSNH/Ggu/2drbgfFrjfHuTZCOUE0dtGr2ot
         XPoVTdOZGuWiY+7cOcvt42Vb9elkcSwBRBXvEgXOMO0OqaxG1aVqCiouVConakI3DyQR
         jM2yRyk9ZJ2gb0JMGSWXL1wEAA2AmMzNKWFrKwFyU7BBk4ibK1Db9t600YMbNd5U/F+p
         IVtw==
X-Gm-Message-State: AA+aEWZVg0p1IsxYDTl35Tdo2EluOUokXA6CGdAlq/c4fTFxGScUpX1Y
        Eqk2//y7YgPCbla67/j0v3XYMg==
X-Google-Smtp-Source: AFSGD/U2ai+4OERoKbpzYCn/NSuldX/3K+5nLpm7A2GZ7CSD1EXdlWv3Ij2GzDnSslIOvbfks0q2rg==
X-Received: by 2002:a63:580a:: with SMTP id m10mr6234892pgb.332.1543618410248;
        Fri, 30 Nov 2018 14:53:30 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id 7sm25542478pfm.8.2018.11.30.14.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:53:29 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/3] mwifiex: debugfs: correct histogram spacing, formatting
Date:   Fri, 30 Nov 2018 14:53:01 -0800
Message-Id: <20181130225303.143409-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, snippets of this file look like:

rx rates (in Mbps): 0=1M   1=2M2=5.5M  3=11M   4=6M   5=9M  6=12M
7=18M  8=24M  9=36M  10=48M  11=54M12-27=MCS0-15(BW20) 28-43=MCS0-15(BW40)
44-53=MCS0-9(VHT:BW20)54-63=MCS0-9(VHT:BW40)64-73=MCS0-9(VHT:BW80)
...
noise_flr[--96dBm] = 22
noise_flr[--95dBm] = 149
noise_flr[--94dBm] = 9
noise_flr[--93dBm] = 2

We're missing some spaces, and we're adding a minus sign ('-') on values
that are already negative signed integers.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index cce70252fd96..65e48e16cb49 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -273,14 +273,14 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 		     "total samples = %d\n",
 		     atomic_read(&phist_data->num_samples));
 
-	p += sprintf(p, "rx rates (in Mbps): 0=1M   1=2M");
+	p += sprintf(p, "rx rates (in Mbps): 0=1M   1=2M ");
 	p += sprintf(p, "2=5.5M  3=11M   4=6M   5=9M  6=12M\n");
-	p += sprintf(p, "7=18M  8=24M  9=36M  10=48M  11=54M");
+	p += sprintf(p, "7=18M  8=24M  9=36M  10=48M  11=54M ");
 	p += sprintf(p, "12-27=MCS0-15(BW20) 28-43=MCS0-15(BW40)\n");
 
 	if (ISSUPP_11ACENABLED(priv->adapter->fw_cap_info)) {
-		p += sprintf(p, "44-53=MCS0-9(VHT:BW20)");
-		p += sprintf(p, "54-63=MCS0-9(VHT:BW40)");
+		p += sprintf(p, "44-53=MCS0-9(VHT:BW20) ");
+		p += sprintf(p, "54-63=MCS0-9(VHT:BW40) ");
 		p += sprintf(p, "64-73=MCS0-9(VHT:BW80)\n\n");
 	} else {
 		p += sprintf(p, "\n");
@@ -310,7 +310,7 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	for (i = 0; i < MWIFIEX_MAX_NOISE_FLR; i++) {
 		value = atomic_read(&phist_data->noise_flr[i]);
 		if (value)
-			p += sprintf(p, "noise_flr[-%02ddBm] = %d\n",
+			p += sprintf(p, "noise_flr[%02ddBm] = %d\n",
 				(int)(i-128), value);
 	}
 	for (i = 0; i < MWIFIEX_MAX_SIG_STRENGTH; i++) {
-- 
2.20.0.rc1.387.gf8505762e3-goog


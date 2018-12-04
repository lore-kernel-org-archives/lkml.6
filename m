Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37787214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="byu89OFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37787214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeLDLCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeLDLCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0016A214DB;
        Tue,  4 Dec 2018 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921366;
        bh=xJRoD4wmBoxglBlrqb0HVvW4JYZqV3pKDZEQxMq3rHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byu89OFJicWD1nyng5dhWBW5nOQtLgMcP+dZ/snZjyhrWQlFcUIgkp0X/m8J/StsZ
         tAiVAsCTiiVYqX/7DO02PouYtLVfdXQDF2HfFIjpDnWtc/m5mSZPFwvbhU+ZEHnNDj
         NBdPPFdDHZTWX8mp2ryM5dYtWaL67kkdvLJNlJRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <qca_liord@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 026/146] wil6210: missing length check in wmi_set_ie
Date:   Tue,  4 Dec 2018 11:48:32 +0100
Message-Id: <20181204103727.910576369@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit b5a8ffcae4103a9d823ea3aa3a761f65779fbe2a upstream.

Add a length check in wmi_set_ie to detect unsigned integer
overflow.

Signed-off-by: Lior David <qca_liord@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index ffdd2fa401b1..d63d7c326801 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1380,8 +1380,14 @@ int wmi_set_ie(struct wil6210_priv *wil, u8 type, u16 ie_len, const void *ie)
 	};
 	int rc;
 	u16 len = sizeof(struct wmi_set_appie_cmd) + ie_len;
-	struct wmi_set_appie_cmd *cmd = kzalloc(len, GFP_KERNEL);
+	struct wmi_set_appie_cmd *cmd;
 
+	if (len < ie_len) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	cmd = kzalloc(len, GFP_KERNEL);
 	if (!cmd) {
 		rc = -ENOMEM;
 		goto out;
-- 
2.17.1




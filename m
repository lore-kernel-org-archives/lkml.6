Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2860C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702502177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297637;
	bh=DeImVgYHwnFtxp9gBy/j/J22ioUWckRCnHBmMF9Np1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5yoUnF2nBZsEUNlyzcYMHR3QLONgTlf+uatRPXG1zJwz0MSWw3n29mSmBJSgbtQ5
	 fs9j5lu90yBWZt0HhM447A9nhQRV5NhXM5Og3NjkvNfZ+guuDJDivb7gv23HIZjv5c
	 tiZ8/Moeuhbgw19u9lF1J1OZaSMGuLi5glKIESI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbeLTJUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbeLTJUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263FD2177E;
        Thu, 20 Dec 2018 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297633;
        bh=DeImVgYHwnFtxp9gBy/j/J22ioUWckRCnHBmMF9Np1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u//HtAX1eMS/c9ohXyuA7Qp1s6z7nWbdC29qxn15KjoVqhQq62yOk3Yqap5DLNxpe
         FQQXSUS9xZmJ0MVAbCDc3g1d2v4rby3dcbDzmDEy9O8eDY4WPzg7dueFYSGbDPYsgs
         7HFv4fr+yo5tl0ensf2oZFQmqXs0IqMXrzF+W+1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <qca_liord@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 31/31] wil6210: missing length check in wmi_set_ie
Date:   Thu, 20 Dec 2018 10:18:43 +0100
Message-Id: <20181220085743.827719854@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lior David <qca_liord@qca.qualcomm.com>

commit b5a8ffcae4103a9d823ea3aa3a761f65779fbe2a upstream.

Add a length check in wmi_set_ie to detect unsigned integer
overflow.

Signed-off-by: Lior David <qca_liord@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -969,7 +969,12 @@ int wmi_set_ie(struct wil6210_priv *wil,
 {
 	int rc;
 	u16 len = sizeof(struct wmi_set_appie_cmd) + ie_len;
-	struct wmi_set_appie_cmd *cmd = kzalloc(len, GFP_KERNEL);
+	struct wmi_set_appie_cmd *cmd;
+
+	if (len < ie_len)
+		return -EINVAL;
+
+	cmd = kzalloc(len, GFP_KERNEL);
 
 	if (!cmd)
 		return -ENOMEM;



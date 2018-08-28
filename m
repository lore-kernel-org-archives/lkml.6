Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4040D208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QK5avBe1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QK5avBe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4040D208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeH1IFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:05:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39494 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1IFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:05:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5443604BE; Tue, 28 Aug 2018 04:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535429754;
        bh=cTxzjBicUfOUpaaiuELzJu3B0U9bKJ+DoMujygNXJuU=;
        h=From:To:Cc:Subject:Date:From;
        b=QK5avBe1oxpSmxKPXj79R1XGdL2jFd8LAYcZDtPQhrsBxSamPDE1n38qbpGh51Lkv
         8ZfReLcmvyDVFrfmfHy0nwRIxcnkbQUtbmjLF3ERwXHQ4pHv7CtKQEcjR3SA6XJZhX
         yZj2G3qC6XjcTFWOtYa8wLEwF5p+L5KFQfzu5aSk=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgoswami@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC1F3602AE;
        Tue, 28 Aug 2018 04:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535429754;
        bh=cTxzjBicUfOUpaaiuELzJu3B0U9bKJ+DoMujygNXJuU=;
        h=From:To:Cc:Subject:Date:From;
        b=QK5avBe1oxpSmxKPXj79R1XGdL2jFd8LAYcZDtPQhrsBxSamPDE1n38qbpGh51Lkv
         8ZfReLcmvyDVFrfmfHy0nwRIxcnkbQUtbmjLF3ERwXHQ4pHv7CtKQEcjR3SA6XJZhX
         yZj2G3qC6XjcTFWOtYa8wLEwF5p+L5KFQfzu5aSk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC1F3602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
From:   bgoswami@codeaurora.org
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Banajit Goswami <bgoswami@codeaurora.org>
Subject: [PATCH] component: fix loop condition to call unbind() if bind() fails
Date:   Mon, 27 Aug 2018 21:15:39 -0700
Message-Id: <1535429739-17962-1-git-send-email-bgoswami@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Banajit Goswami <bgoswami@codeaurora.org>

During component_bind_all(), if bind() fails for any
particular component associated with a master, unbind()
should be called for all previous components in that
master's match array, whose bind() might have completed
successfully. As per the current logic, if bind() fails
for the component at position 'n' in the master's match
array, it would start calling unbind() from component in
'n'th position itself and work backwards, and will always
skip calling unbind() for component in 0th position in the
master's match array.
Fix this by updating the loop condition, and the logic to
refer to the components in master's match array, so that
unbind() is called for all components starting from 'n-1'st
position in the array, until (and including) component in
0th position.

Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 drivers/base/component.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 8946dfe..e8d676f 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -536,9 +536,9 @@ int component_bind_all(struct device *master_dev, void *data)
 		}
 
 	if (ret != 0) {
-		for (; i--; )
-			if (!master->match->compare[i].duplicate) {
-				c = master->match->compare[i].component;
+		for (; i > 0; i--)
+			if (!master->match->compare[i - 1].duplicate) {
+				c = master->match->compare[i - 1].component;
 				component_unbind(c, master, data);
 			}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


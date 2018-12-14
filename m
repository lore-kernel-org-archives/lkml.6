Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2288C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87862148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789956;
	bh=cXxVJQOJd81blBIOU3TguTPpKNcj+JFsuWfUHw6U9IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VFIjkYfXtxxizxT8WwUp0KlF/xQrGEo8QiSgbdzN+7mzMM+dOXt81a+m61fbf3JxH
	 m6be0J5yZQGI7C2MnDr/5PvYJ6BvyhtVJYUfdAdabM5SOPoiziWNhSIOI80RwiNTOs
	 +vGb3ExvvU0fxVWQ1Ts9pDol3BHL5x31hC1ZuEBk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87862148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbeLNMTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732033AbeLNMP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA7B321486;
        Fri, 14 Dec 2018 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789758;
        bh=cXxVJQOJd81blBIOU3TguTPpKNcj+JFsuWfUHw6U9IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsGYF1UrPMTUa+3W2CTcp55gOOxqAufo+wdty+xvp/NA7W+ASr4OJ5qPytnOuDCid
         0q6D9jCE4fTZTdBPFi2X61SwGvjfJMn8I+wWn0H81/Yzq0q04sXGscItz4kXH+XIfs
         zKnr2RRr8Mf2LJaNeU56G762l5ltg5vbObT1z1bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <qca_liord@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 66/88] wil6210: missing length check in wmi_set_ie
Date:   Fri, 14 Dec 2018 13:00:40 +0100
Message-Id: <20181214115707.758817601@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/wireless/ath/wil6210/wmi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1035,8 +1035,14 @@ int wmi_set_ie(struct wil6210_priv *wil,
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



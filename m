Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559AF214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107590;
	bh=FA50cmMUeTcTfgMqkG1YndB+TUAw+8PB80N2BlJIRAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0/zcbd1uN4GEnHS/R4fgZKtQSPObUX7ouOScYJvBPGHORNqBx3C+YeXOeCMfiglYE
	 TRSwrkkkfuy0FmKimzN1hSc5basQMjI36fOnJuYSY9AhKWuqS0z7fZHrHZgM5PC62i
	 vrYPPMqo7o1ZPvEV1tt4usyXszJvQsDmPTC86aR8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559AF214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeLFOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbeLFOqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6824120892;
        Thu,  6 Dec 2018 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107584;
        bh=FA50cmMUeTcTfgMqkG1YndB+TUAw+8PB80N2BlJIRAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZ78dKSHokYysLf9ygUJgx8k2PCviC9/MmmLNO0oiVCE8nQT1oBhmULk1ccq0hHmd
         m6iOaVMro7JY3kiFuDiY0D0/JDsrY/IEe+ul5xpreFljMWzAzCi6wcBbouMtSyP1x1
         e+BBagbOmDlYpCac4YfIY7BTd/ExAgLt4vk3823E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <qca_liord@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 061/101] wil6210: missing length check in wmi_set_ie
Date:   Thu,  6 Dec 2018 15:39:00 +0100
Message-Id: <20181206143015.150112618@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1302,8 +1302,14 @@ int wmi_set_ie(struct wil6210_priv *wil,
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



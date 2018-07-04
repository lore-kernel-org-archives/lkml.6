Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62EC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220323E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OaADQ5Zr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OaADQ5Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220323E10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeGDOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:20:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeGDOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:20:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E80F260B67; Wed,  4 Jul 2018 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530714021;
        bh=rJOnCCkkQ7MNAgqRKZ1loRLMtFHptSn0pOKqW5Jg0d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaADQ5ZrqI6PBgLmyoLTfvCtXFNQwUjhYgyuO4dvwCvWMVVp5+swIqviJaxrQhWvp
         E+mYW/1e4nz0QnVfIeZ+MZM9ERu9fMTGsIr7RqxFVpbD9P78Nfcigk4pkivqluJCN1
         QbZ9sHYZr/9D3xLE2KRbWaNbPG0XhpgyavPyTZMk=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C51F5607EB;
        Wed,  4 Jul 2018 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530714021;
        bh=rJOnCCkkQ7MNAgqRKZ1loRLMtFHptSn0pOKqW5Jg0d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaADQ5ZrqI6PBgLmyoLTfvCtXFNQwUjhYgyuO4dvwCvWMVVp5+swIqviJaxrQhWvp
         E+mYW/1e4nz0QnVfIeZ+MZM9ERu9fMTGsIr7RqxFVpbD9P78Nfcigk4pkivqluJCN1
         QbZ9sHYZr/9D3xLE2KRbWaNbPG0XhpgyavPyTZMk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C51F5607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     davem@davemloft.net, bjorn.andersson@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Florian Westphal <fw@strlen.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 1/2] net: qrtr: Broadcast messages only from control port
Date:   Wed,  4 Jul 2018 19:49:32 +0530
Message-Id: <1530713973-26696-2-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530713973-26696-1-git-send-email-aneela@codeaurora.org>
References: <1530713973-26696-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broadcast node id should only be sent with the control port id.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 net/qrtr/qrtr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 2aa07b5..7ffc9a3 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -764,6 +764,10 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	node = NULL;
 	if (addr->sq_node == QRTR_NODE_BCAST) {
 		enqueue_fn = qrtr_bcast_enqueue;
+		if (addr->sq_port != QRTR_PORT_CTRL) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
 	} else if (addr->sq_node == ipc->us.sq_node) {
 		enqueue_fn = qrtr_local_enqueue;
 	} else {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


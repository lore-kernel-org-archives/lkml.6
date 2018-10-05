Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A8FC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F721477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUX/1/d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeJEXOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbeJEXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218852148D;
        Fri,  5 Oct 2018 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756083;
        bh=Acp24Y/qNpg5h5uol7Ywa/4dJXI+vM6T1hk/KNtLNlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUX/1/d/PfNTqHfWZu+wR87Fkc923cKBki5I+sZZqmAA2UKAXFZzMwTrluZpW+DVV
         FG6NFXWqcnjuKc4xdUZJ6RaMy+n48cul7G2+A8WY35/noibs2xaEDsRFKBVdw3itNM
         dQdoLu9+CsxaqDvLdAdngnYilhHY6Zc+9QTR3QkY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 20/48] Bluetooth: SMP: Fix trying to use non-existent local OOB data
Date:   Fri,  5 Oct 2018 12:13:56 -0400
Message-Id: <20181005161424.20521-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hedberg <johan.hedberg@intel.com>

[ Upstream commit 94f14e4728125f979629b2b020d31cd718191626 ]

A remote device may claim that it has received our OOB data, even
though we never geneated it. Add a new flag to track whether we
actually have OOB data, and ignore the remote peer's flag if haven't
generated OOB data.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/smp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ae91e2d40056..9752879fdd3a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -83,6 +83,7 @@ enum {
 
 struct smp_dev {
 	/* Secure Connections OOB data */
+	bool			local_oob;
 	u8			local_pk[64];
 	u8			local_rand[16];
 	bool			debug_key;
@@ -599,6 +600,8 @@ int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16])
 
 	memcpy(rand, smp->local_rand, 16);
 
+	smp->local_oob = true;
+
 	return 0;
 }
 
@@ -1785,7 +1788,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (req->oob_flag == SMP_OOB_PRESENT)
+	if (req->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	/* SMP over BR/EDR requires special treatment */
@@ -1967,7 +1970,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (rsp->oob_flag == SMP_OOB_PRESENT)
+	if (rsp->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
@@ -3230,6 +3233,7 @@ static struct l2cap_chan *smp_add_cid(struct hci_dev *hdev, u16 cid)
 		return ERR_CAST(tfm_ecdh);
 	}
 
+	smp->local_oob = false;
 	smp->tfm_aes = tfm_aes;
 	smp->tfm_cmac = tfm_cmac;
 	smp->tfm_ecdh = tfm_ecdh;
-- 
2.17.1


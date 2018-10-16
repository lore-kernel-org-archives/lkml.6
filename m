Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B6C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A8B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtNIzq3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8B2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeJQBGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJQBGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8664220866;
        Tue, 16 Oct 2018 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710123;
        bh=W/ZaNt1vcv3XCCHC19Z0meflUBvX4y+pZQwwMCDR1G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtNIzq3y2VZ+pF4AbBR5J5QP1MIUeJyTH8LW2abm9yBR99l6ewV4rHpiajlu3B6vK
         +t7FZzgtPwKLpYGG7VLCKC6enYVq0SQ7s1M0bLafjbfL1JyqslCltqPgPgNiHJzVkd
         2c9DYlUDkAeg1mBvLXT9d+jzyfa60l7qWg9Bzsbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 082/135] Bluetooth: SMP: Fix trying to use non-existent local OOB data
Date:   Tue, 16 Oct 2018 19:05:12 +0200
Message-Id: <20181016170520.860885266@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hedberg <johan.hedberg@intel.com>

[ Upstream commit 94f14e4728125f979629b2b020d31cd718191626 ]

A remote device may claim that it has received our OOB data, even
though we never geneated it. Add a new flag to track whether we
actually have OOB data, and ignore the remote peer's flag if haven't
generated OOB data.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/smp.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -83,6 +83,7 @@ enum {
 
 struct smp_dev {
 	/* Secure Connections OOB data */
+	bool			local_oob;
 	u8			local_pk[64];
 	u8			local_rand[16];
 	bool			debug_key;
@@ -599,6 +600,8 @@ int smp_generate_oob(struct hci_dev *hde
 
 	memcpy(rand, smp->local_rand, 16);
 
+	smp->local_oob = true;
+
 	return 0;
 }
 
@@ -1785,7 +1788,7 @@ static u8 smp_cmd_pairing_req(struct l2c
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (req->oob_flag == SMP_OOB_PRESENT)
+	if (req->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	/* SMP over BR/EDR requires special treatment */
@@ -1967,7 +1970,7 @@ static u8 smp_cmd_pairing_rsp(struct l2c
 	 * successfully received our local OOB data - therefore set the
 	 * flag to indicate that local OOB is in use.
 	 */
-	if (rsp->oob_flag == SMP_OOB_PRESENT)
+	if (rsp->oob_flag == SMP_OOB_PRESENT && SMP_DEV(hdev)->local_oob)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
@@ -3230,6 +3233,7 @@ static struct l2cap_chan *smp_add_cid(st
 		return ERR_CAST(tfm_ecdh);
 	}
 
+	smp->local_oob = false;
 	smp->tfm_aes = tfm_aes;
 	smp->tfm_cmac = tfm_cmac;
 	smp->tfm_ecdh = tfm_ecdh;



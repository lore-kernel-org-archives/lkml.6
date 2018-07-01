Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B206C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A5B25249
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A5B25249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030392AbeGAQa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:30:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030360AbeGAQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF0D492B;
        Sun,  1 Jul 2018 16:30:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 028/157] Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader
Date:   Sun,  1 Jul 2018 18:21:40 +0200
Message-Id: <20180701160853.714702973@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Pundir <amit.pundir@linaro.org>

commit 7dc5fe0814c35ec4e7d2e8fa30abab72e0e6a172 upstream.

AOSP use userspace firmware loader to load firmwares, which will
return -EAGAIN in case qca/rampatch_00440302.bin is not found.
Since there is no rampatch for dragonboard820c QCA controller
revision, just make it work as is.

CC: Loic Poulain <loic.poulain@linaro.org>
CC: Nicolas Dechesne <nicolas.dechesne@linaro.org>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_qca.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -936,6 +936,12 @@ static int qca_setup(struct hci_uart *hu
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
+	} else if (ret == -EAGAIN) {
+		/*
+		 * Userspace firmware loader will return -EAGAIN in case no
+		 * patch/nvm-config is found, so run with original fw/config.
+		 */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */



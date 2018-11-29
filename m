Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E74C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC693208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/wOAGFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC693208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeK3B2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbeK3B2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCFE205C9;
        Thu, 29 Nov 2018 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501392;
        bh=4GZ7dmvh/ONfLlNd+onzg+k77P+gQiCvuKSJMAVDudo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/wOAGFEU5/i7nqWZIQvurv00dlOH0y7NTd0dQ5xsQ1JuzsO4qb1ueEde6TtqPQTb
         GsohoXg/dx9STvv4e7JdRFg0ijV1/VGCZss7fCPE/ThpPqbYyUiw5gM4rTnWa64gv2
         HO7Yt1Cl56Z2olK1FecSWAYd6zlwhJIuhpRyab2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 72/92] mwifiex: report error to PCIe for suspend failure
Date:   Thu, 29 Nov 2018 15:12:41 +0100
Message-Id: <20181129140112.215992142@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amitkumar Karwar <akarwar@marvell.com>

commit 5190f2e405919cd30ba2f12c58129fb2d71cd6b6 upstream.

When host_sleep_config command fails, we should return an error to
PCIe, instead of continuing (and possibly panicking, when we try to keep
processing a timed-out ioctl after we return "successfully" from
suspend).

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/pcie.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -101,7 +101,6 @@ static int mwifiex_pcie_suspend(struct d
 {
 	struct mwifiex_adapter *adapter;
 	struct pcie_service_card *card;
-	int hs_actived;
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (pdev) {
@@ -117,7 +116,14 @@ static int mwifiex_pcie_suspend(struct d
 
 	adapter = card->adapter;
 
-	hs_actived = mwifiex_enable_hs(adapter);
+	/* Enable the Host Sleep */
+	if (!mwifiex_enable_hs(adapter)) {
+		mwifiex_dbg(adapter, ERROR,
+			    "cmd: failed to suspend\n");
+		adapter->hs_enabling = false;
+		return -EFAULT;
+	}
+
 	flush_workqueue(adapter->workqueue);
 
 	/* Indicate device suspended */



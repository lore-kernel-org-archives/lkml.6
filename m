Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8653420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vh+J51UT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8653420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJYWoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeJYWo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804DD2054F;
        Thu, 25 Oct 2018 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476694;
        bh=S+cQtJiWXkeba1uEGfzSI7rh/p33OKmGOscBHVnpezA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vh+J51UTIUS5YBCUT1tGhQad1oVQk14LCd1j1GFrOLkNprpzesGP5BNmxkE0rrlYH
         wIMA7KUXVZ7TBoPyQi2RhVaRkszxiZYcwh5xGijAtQomA/ViPljaAroZj88iQqGox/
         0JIa9antHDp1ByM25bpDO6mU7dv9Tw/kH9ZunaQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 28/46] tpm: tpm_crb: relinquish locality on error path.
Date:   Thu, 25 Oct 2018 10:10:35 -0400
Message-Id: <20181025141053.213330-28-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Winkler, Tomas" <tomas.winkler@intel.com>

[ Upstream commit 1fbad3028664e114d210dc65d768947a3a553eaa ]

In crb_map_io() function, __crb_request_locality() is called prior
to crb_cmd_ready(), but if one of the consecutive function fails
the flow bails out instead of trying to relinquish locality.
This patch adds goto jump to __crb_relinquish_locality() on the error path.

Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_crb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 5c7ce5aaaf6f..b4ad169836e9 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -520,8 +520,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
-	if (IS_ERR(priv->regs_t))
-		return PTR_ERR(priv->regs_t);
+	if (IS_ERR(priv->regs_t)) {
+		ret = PTR_ERR(priv->regs_t);
+		goto out_relinquish_locality;
+	}
 
 	/*
 	 * PTT HW bug w/a: wake up the device to access
@@ -529,7 +531,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	ret = __crb_cmd_ready(dev, priv);
 	if (ret)
-		return ret;
+		goto out_relinquish_locality;
 
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
@@ -574,6 +576,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	__crb_go_idle(dev, priv);
 
+out_relinquish_locality:
+
 	__crb_relinquish_locality(dev, priv, 0);
 
 	return ret;
-- 
2.17.1


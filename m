Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58455C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9852084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScB8GfEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9852084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeKCECh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeKCECg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:02:36 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9B420848;
        Fri,  2 Nov 2018 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184860;
        bh=EKPNk6esp2RhNk9XH4qbv4Ca6VFNeMy+vTU0fBRRwiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScB8GfEuaZ5oM5E9FzU38Y88XkWgzjwIyHDPJVyoohxqDpyk4zJQCggk9cwvfwazQ
         nuC6eC60LpIXCuq/qfvCC2Vetg5qbp67ZNktFj0Nt0badfTNTMOJc2AB3eJ7ZXwXw3
         g85QlPTY2mYngc89pb3OFmz3k2X2VGFGKXBosMaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 077/143] tpm: tpm_crb: relinquish locality on error path.
Date:   Fri,  2 Nov 2018 19:34:22 +0100
Message-Id: <20181102182903.668798740@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -574,6 +576,8 @@ out:
 
 	__crb_go_idle(dev, priv);
 
+out_relinquish_locality:
+
 	__crb_relinquish_locality(dev, priv, 0);
 
 	return ret;
-- 
2.17.1




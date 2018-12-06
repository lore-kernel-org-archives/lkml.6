Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F9C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947A120850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="RzpUaCjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947A120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infineon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeLFSHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:07:55 -0500
Received: from mail.dice.at ([217.10.52.18]:29916 "EHLO smtp2.infineon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeLFSHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:07:55 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 13:07:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1544119699; x=1575655699;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Vj11rthUJOzzcJQez56EA0KjttwsIJa2K86w87xVAWA=;
  b=RzpUaCjdjQqIoUxJ84AHn3cZDamVLk19CFBgpCKJzQTWJ2n3xAuFM8YM
   6+Ai5KSDwY+LPfb+LRbKBVhm9P1a89SVBckZqo6q3/QNPvzhfXzupU6pt
   +Xw+F0FKmi1o2UfQv1M/aQErCjdYS9S+mAjamumvPSeFtt7+MC7s+6Cz5
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,9099"; a="91670674"
X-IronPort-AV: E=Sophos;i="5.56,323,1539640800"; 
   d="scan'208";a="91670674"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2018 18:58:34 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  6 Dec 2018 18:58:09 +0100 (CET)
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE708.infineon.com (172.23.7.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1531.3; Thu, 6 Dec 2018 18:58:08 +0100
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
CC:     <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH] tpm-dev: Require response to be read only if there actually is a response
Date:   Thu, 6 Dec 2018 18:58:01 +0100
Message-ID: <20181206175801.23048-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.18.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE713.infineon.com (172.23.7.71) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tpm_transmit call in tpm_common_write fails for any reason, there is
no response that could be read. Therefore, do not require the application
to issue a read call before sending further commands. This restores the
behavior from before support for partial reads was introduced.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
Feel free to merge this into Tadeusz' original commit.

 drivers/char/tpm/tpm-dev-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 344739223451..5eecad233ea1 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -140,7 +140,8 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
 	 * tpm_read or a user_read_timer timeout. This also prevents split
 	 * buffered writes from blocking here.
 	 */
-	if (!priv->response_read || priv->command_enqueued) {
+	if ((!priv->response_read && priv->response_length) ||
+	    priv->command_enqueued) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.17.1


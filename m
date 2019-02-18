Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EE321901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499508;
	bh=0ivW29iiCsU60gPWFshDFo8KQpmXv23fcSr4wPDK+9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E6tW040WbXf+AigZBg5ARaQpCtRrwrxUmXfkyUZop7/iKdWJdpogYjTgrz+woDNf3
	 F9NAqQGyYNgE4ScaId2h/XIHvzl7cN99piFDyK7o5AuI2CRaKhpxtkMQtMKX2o5Y5V
	 q36m7EIPHqoOf9ryVQWFhtmcsa0dhnmw0yVj7oYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfBROS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391029AbfBROIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:08:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FA321902;
        Mon, 18 Feb 2019 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498931;
        bh=0ivW29iiCsU60gPWFshDFo8KQpmXv23fcSr4wPDK+9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uyu6JjzgTLh9wLwDRD/IT6RQ/+de8KejrshCmnyDBNZZ+2sVPxinsl/SNPRjrBKk9
         hjlBWi79uDzik8mnR7xrEsBOA2udd0YU7QZn1bAuyVa6lzozf9rqCWkFEdeWd6CI3J
         ntC7r+xdpORH+p8gOwhHa4U5lROpqZpLKsn36Unw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 005/108] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Mon, 18 Feb 2019 14:43:01 +0100
Message-Id: <20190218133519.766528626@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5b3f5c408d8cc59b87e47f1ab9803dbd006e4a91 ]

The previous commit, "of: overlay: add missing of_node_get() in
__of_attach_node_sysfs" added a missing of_node_get() to
__of_attach_node_sysfs().  This results in a refcount imbalance
for nodes attached with dlpar_attach_node().  The calling sequence
from dlpar_attach_node() to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

For more detailed description of the node refcount, see
commit 68baf692c435 ("powerpc/pseries: Fix of_node_put() underflow
during DLPAR remove").

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 80d175dca68e..85bd29475987 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -299,6 +299,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
2.19.1




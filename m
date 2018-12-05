Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF36C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039622;
	bh=ql3Cj5np76jVgQNVcq6gfEFJDd22uWvtE3LhfPbSIdI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mO44V7m4D88KJMaMAWupneIxPsaQMOTG0lY3cMOvS0FHtID01HAHDMIAkFYRXf2Wi
	 qvFiOyJhe/Hy95J+WcyD2cfEfLq3qtmCGAbGbWny0/RuoqFExRyedGlISEX0OcyUa5
	 kzccgxOsdauu1npt2p1gmRVECCeBT1x9BsfCxrh4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84B020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeLETxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33057 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeLETvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so18672475oib.0;
        Wed, 05 Dec 2018 11:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95v299N8kaDRKNE2Prutd/fuPK+JAW7Lyf4TJG2OQ3w=;
        b=uBnfKQ8lMD60ikIuiq5gWlcBcX0RS2kJXiGoQWlxAHGJcqBlEdmHwKz4D3JurbeMVH
         0zkVwH9jiPI3tD/ORIoAVZiAh/tVEGX/C2ld3SW08OiXdtFuK6ch/xMA+toSsFbtEOK2
         bpB53ZZ59kgH+asl/CyG7j5m5YCvjNXxLOan7mlV0Dvwrzcw+Lene1P1fatxRd3xhoHX
         ciqz0GxeV4ubZD9C/A8eqMgTsHGElwMk+yUQBf7rKbN3L+RuyA4wmeriZcrhQVRPFGXl
         Rtz/JKk2kpOoYtW1x7YIuqAYy6dxRzZ9nwVAXGxZwvWkFuKvnaJkWtLKvUd4iQuObKuJ
         dang==
X-Gm-Message-State: AA+aEWYqhIYEQcF2QkRZbz+DLaZvMyz3t/PahuXnbbGBKWwYPbM28Bja
        QLgMr1CWLcJODcG/C1FtShLVb94=
X-Google-Smtp-Source: AFSGD/U/BhIK5HWrmu8AYPyJZr/C+BCGzlNsvIP4c9x60R84Yomzon+HhAD85vVQOIe9LLy3bCa9LA==
X-Received: by 2002:aca:d644:: with SMTP id n65mr15258115oig.287.1544039459973;
        Wed, 05 Dec 2018 11:50:59 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:59 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] i2c: powermac: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:24 -0600
Message-Id: <20181205195050.4759-8-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/i2c/busses/i2c-powermac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f6f4ed8afc93..281113c28314 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -229,9 +229,9 @@ static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 		return (be32_to_cpup(prop) & 0xff) >> 1;
 
 	/* Now handle some devices with missing "reg" properties */
-	if (!strcmp(node->name, "cereal"))
+	if (of_node_name_eq(node, "cereal"))
 		return 0x60;
-	else if (!strcmp(node->name, "deq"))
+	else if (of_node_name_eq(node, "deq"))
 		return 0x34;
 
 	dev_warn(&adap->dev, "No i2c address for %pOF\n", node);
@@ -304,7 +304,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 	}
 
 	/* Now look for known workarounds */
-	if (!strcmp(node->name, "deq")) {
+	if (of_node_name_eq(node, "deq")) {
 		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */
 		if (addr == 0x34) {
 			snprintf(type, type_size, "MAC,tas3001");
@@ -331,7 +331,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 	 * case we skip this function completely as the device-tree will
 	 * not contain anything useful.
 	 */
-	if (!strcmp(adap->dev.of_node->name, "via-pmu"))
+	if (of_node_name_eq(adap->dev.of_node, "via-pmu"))
 		return;
 
 	for_each_child_of_node(adap->dev.of_node, node) {
-- 
2.19.1


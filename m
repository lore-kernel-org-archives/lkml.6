Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B60205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039455;
	bh=HeBHBogfyeZTULUjqkGZVoWTYnj14VxtOmbEcCGP8O0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j+NcBvxxee7ZFaFgKXdoOzB+s2AAfbQIlODxtYtUL15S8m0OhvNQO9Fc1woKpmdpO
	 PRsL+bIrwsNVYSl8+t21o8/XRYyEpCsaCQW5F+RNJlBfRbKP0Rn/uFjxlUo3T3SZIe
	 9a5PGUyu87SJOGAh+YVng7JJe4XmlyMSkJhQ0F+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B60205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeLETuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:50:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35658 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeLETux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so18644152oif.2;
        Wed, 05 Dec 2018 11:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eacEPZ/q29QHdXEtgllpAxXndz/of7y8zfxjsQnjWw=;
        b=QjJISFXyu2cMooOQIUtusFEW6VIJkdQmhhETDWOiv7IfPuPcBtaC0/bA/PPQmjtm20
         7SiIe24PF3h0PBA6j1FJvqzJHm7h7vCJxwuvOeqySybKuSU68yKYWStp6MbNn/IVACF/
         bTmzPZP3X8jw1aOwLTvpNq4ToYjeXMrHPAlytmcxqoFIcvECOtJRodnZKubGHpZ06fy4
         ijZ5f2REV0ZEt2forqV9cZU5a1zmnpOkqPL6Kf+X2DEvICJDTqiIndgxjJxzPgUbzho6
         H5GEYCfjbjki0wcnaebyRsE8FaCKpIvAI5QHD9Hp9cLMyA8w4BCsO/udct/MHk38TDMH
         wLCQ==
X-Gm-Message-State: AA+aEWaSX4oKaHmD1yUbKGG9n4lQAptFGpRWP60D3XY0CSCwiqeKcccb
        ocpMWC4ezHwMmHMu35oVrPmHJBo=
X-Google-Smtp-Source: AFSGD/URpix61sQvCxE1cgkH52X1QspSG78AH0Y+CfPHhNX+ApN3AH0WS9juWTX2F2S4rIs5iyw6Sw==
X-Received: by 2002:aca:d644:: with SMTP id n65mr15257858oig.287.1544039451943;
        Wed, 05 Dec 2018 11:50:51 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:51 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: pseries: pmem: Convert to using %pOFn instead of device_node.name
Date:   Wed,  5 Dec 2018 13:50:17 -0600
Message-Id: <20181205195050.4759-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier. pmem.c was
recently added and missed the initial conversion.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/pseries/pmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index a27f40eb57b1..27f0a915c8a9 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -52,8 +52,8 @@ static ssize_t pmem_drc_add_node(u32 drc_index)
 	/* NB: The of reconfig notifier creates platform device from the node */
 	rc = dlpar_attach_node(dn, pmem_node);
 	if (rc) {
-		pr_err("Failed to attach node %s, rc: %d, drc index: %x\n",
-			dn->name, rc, drc_index);
+		pr_err("Failed to attach node %pOF, rc: %d, drc index: %x\n",
+			dn, rc, drc_index);
 
 		if (dlpar_release_drc(drc_index))
 			dlpar_free_cc_nodes(dn);
@@ -93,8 +93,8 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
 
 	rc = dlpar_release_drc(drc_index);
 	if (rc) {
-		pr_err("Failed to release drc (%x) for CPU %s, rc: %d\n",
-			drc_index, dn->name, rc);
+		pr_err("Failed to release drc (%x) for CPU %pOFn, rc: %d\n",
+			drc_index, dn, rc);
 		dlpar_attach_node(dn, pmem_node);
 		return rc;
 	}
-- 
2.19.1


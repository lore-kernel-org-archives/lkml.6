Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB498C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xvbD90V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeJQBPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B614120658;
        Tue, 16 Oct 2018 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710616;
        bh=VCTWqIn/klZHrPOwg4oBDJyJyr6J45C1i65lQhj6Egc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvbD90V04jCbxTX2Q7K9uMkFRS/BCJcwOupwyb+Nhmca98We/x+A5YqhLZe0MVxhC
         Ys91Ly0uISLWfxp3o5s5kXvrC/eaiAtn6xpdTfCAZpnzFmL34P/oZtSJW1DMtP7haL
         oxadpI4gnrZcpLHFxd7NAVP3T1O/aA+7A24ihi14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 28/71] net: dsa: bcm_sf2: Call setup during switch resume
Date:   Tue, 16 Oct 2018 19:09:25 +0200
Message-Id: <20181016170540.816116714@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 54baca096386d862d19c10f58f34bf787c6b3cbe ]

There is no reason to open code what the switch setup function does, in
fact, because we just issued a switch reset, we would make all the
register get their default values, including for instance, having unused
port be enabled again and wasting power and leading to an inappropriate
switch core clock being selected.

Fixes: 8cfa94984c9c ("net: dsa: bcm_sf2: add suspend/resume callbacks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -744,7 +744,6 @@ static int bcm_sf2_sw_suspend(struct dsa
 static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 {
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
-	unsigned int port;
 	int ret;
 
 	ret = bcm_sf2_sw_rst(priv);
@@ -756,12 +755,7 @@ static int bcm_sf2_sw_resume(struct dsa_
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-	for (port = 0; port < DSA_MAX_PORTS; port++) {
-		if ((1 << port) & ds->enabled_port_mask)
-			bcm_sf2_port_setup(ds, port, NULL);
-		else if (dsa_is_cpu_port(ds, port))
-			bcm_sf2_imp_setup(ds, port);
-	}
+	ds->ops->setup(ds);
 
 	return 0;
 }



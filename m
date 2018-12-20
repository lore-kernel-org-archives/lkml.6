Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B49217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298227;
	bh=FJ20MwyGf6RkRDp5dyhsxzlFY0QsaBk83uAdNOAfOoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNoJTHw+6cIEUAdBb2g3xf4lhGnxGIWwM2TtLqlaUr1szQCNTHhitP+Rxz/0ngHMY
	 k0jlOahuLDFmyXNyI/U3QbL0OvU5MA4RC0asD3eMbDjPue7FGMvQZQRfTbAiGoIEyo
	 mkgDFCMx62tXOxOwvzQZ62s5xCU/ZmWtKnQYb9Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbeLTJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbeLTJaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6489621741;
        Thu, 20 Dec 2018 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298220;
        bh=FJ20MwyGf6RkRDp5dyhsxzlFY0QsaBk83uAdNOAfOoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQrIZulB1Okax6d5lHmDhxY28vYXEJC4ARGz2fPDxyHcP+uiD7zy/1ifnJEeguNmP
         Q6QEuPaPy9++jUm8SLF5PXn2evyWmpTz1UPfPWIGIjW8KziT9E7EsUpIm32vl/qeGD
         H0X76UaOaA4fG9CYpwL+16eZsXinaytn/JdeZyEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anderson Luiz Alves <alacn1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/67] mv88e6060: disable hardware level MAC learning
Date:   Thu, 20 Dec 2018 10:18:56 +0100
Message-Id: <20181220085905.289517922@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a74515604a7b171f2702bdcbd1e231225fb456d0 ]

Disable hardware level MAC learning because it breaks station roaming.
When enabled it drops all frames that arrive from a MAC address
that is on a different port at learning table.

Signed-off-by: Anderson Luiz Alves <alacn1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6060.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 65f10fec25b3..0b3e51f248c2 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -116,8 +116,7 @@ static int mv88e6060_switch_reset(struct dsa_switch *ds)
 	/* Reset the switch. */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
 		  GLOBAL_ATU_CONTROL_SWRESET |
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	/* Wait up to one second for reset to complete. */
 	timeout = jiffies + 1 * HZ;
@@ -142,13 +141,10 @@ static int mv88e6060_setup_global(struct dsa_switch *ds)
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_CONTROL, GLOBAL_CONTROL_MAX_FRAME_1536);
 
-	/* Enable automatic address learning, set the address
-	 * database size to 1024 entries, and set the default aging
-	 * time to 5 minutes.
+	/* Disable automatic address learning.
 	 */
 	REG_WRITE(REG_GLOBAL, GLOBAL_ATU_CONTROL,
-		  GLOBAL_ATU_CONTROL_ATUSIZE_1024 |
-		  GLOBAL_ATU_CONTROL_ATE_AGE_5MIN);
+		  GLOBAL_ATU_CONTROL_LEARNDIS);
 
 	return 0;
 }
-- 
2.19.1




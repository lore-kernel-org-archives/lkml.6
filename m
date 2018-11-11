Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73089C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F238214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F238214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbeKLFsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51006 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730628AbeKLFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvso-0000oJ-Jx; Sun, 11 Nov 2018 19:58:58 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsX-0001lJ-O5; Sun, 11 Nov 2018 19:58:41 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "Nicholas Mc Guire" <hofrat@osadl.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.532732100@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 279/366] can: mpc5xxx_can: check of_iomap return
 before use
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit b5c1a23b17e563b656cc9bb76ce5323b997d90e8 upstream.

of_iomap() can return NULL so that return needs to be checked and NULL
treated as failure. While at it also take care of the missing
of_node_put() in the error path.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct
 		return 0;
 	}
 	cdm = of_iomap(np_cdm, 0);
+	if (!cdm) {
+		of_node_put(np_cdm);
+		dev_err(&ofdev->dev, "can't map clock node!\n");
+		return 0;
+	}
 
 	if (in_8(&cdm->ipb_clk_sel) & 0x1)
 		freq *= 2;


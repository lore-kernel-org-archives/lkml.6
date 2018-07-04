Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C887C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38345208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="QkW8l5vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38345208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933832AbeGDJNR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:13:17 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53962 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGDJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:13:15 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3B55E5C015F;
        Wed,  4 Jul 2018 11:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530695593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=3Y/R3AgEMCLpbsMlLirs+dWh1bOyKipwoGbykZXM+A4=;
        b=QkW8l5vCPPH7dMQneuvgLA0are1O7PIcHLE3wQ6YkGItUMKiJUk6lf/6/DqL3kbY0kCOUc
        JDEDqICBXKWfy365SKV0aG1OsR7IzswJ+F1WEnpqjl+SG8tUB91EbTynfOQC6rwRjpkDZo
        me7XW5TPiw46FpcWTYyfx6DH9YMatF8=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, dan.carpenter@oracle.com, dev@lynxeye.de,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org,
        digetx@gmail.com, benjamin.lindqvist@endian.se,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mtd: rawnand: tegra: check bounds of die_nr properly
Date:   Wed,  4 Jul 2018 11:13:10 +0200
Message-Id: <20180704091310.22003-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[18];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra driver currently only support a single chip select, hence
check boundaries accordingly. This fixes a off by one issue catched
with Smatch:
    drivers/mtd/nand/raw/tegra_nand.c:476 tegra_nand_select_chip()
    warn: array off by one? 'nand->cs[die_nr]'

Also warn in case the stack asks for a chip select we currently do
not support.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/raw/tegra_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 4daa88d814134..e65ef584df0b9 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -468,7 +468,9 @@ static void tegra_nand_select_chip(struct mtd_info *mtd, int die_nr)
 	struct tegra_nand_chip *nand = to_tegra_chip(chip);
 	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
 
-	if (die_nr < 0 || die_nr > 1) {
+	WARN_ON(die_nr >= ARRAY_SIZE(nand->cs));
+
+	if (die_nr < 0 || die_nr > 0) {
 		ctrl->cur_cs = -1;
 		return;
 	}
-- 
2.18.0


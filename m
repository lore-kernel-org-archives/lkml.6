Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D056C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0787D20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0787D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934911AbeFRIRp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934884AbeFRIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32F62C7A;
        Mon, 18 Jun 2018 08:17:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 017/279] spi: sh-msiof: Fix bit field overflow writes to TSCR/RSCR
Date:   Mon, 18 Jun 2018 10:10:02 +0200
Message-Id: <20180618080609.521743434@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

[ Upstream commit 10b4640833e95eeacaef8060bc1b35e636df3218 ]

The change fixes a bit field overflow which allows to write to higher
bits while calculating SPI transfer clock and setting BRPS and BRDV
bit fields, the problem is reproduced if 'parent_rate' to 'spi_hz'
ratio is greater than 1024, for instance

  p->min_div      = 2,
  MSO rate        = 33333333,
  SPI device rate = 10000

results in

  k          = 5, i.e. BRDV = 0b100 or 1/32 prescaler output,
  BRPS       = 105,
  TSCR value = 0x6804, thus MSSEL and MSIMM bit fields are non-zero.

Fixes: 65d5665bb260 ("spi: sh-msiof: Update calculation of frequency dividing")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sh-msiof.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -283,6 +283,7 @@ static void sh_msiof_spi_set_clk_regs(st
 	}
 
 	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_div_table) - 1);
+	brps = min_t(int, brps, 32);
 
 	scr = sh_msiof_spi_div_table[k].brdv | SCR_BRPS(brps);
 	sh_msiof_write(p, TSCR, scr);



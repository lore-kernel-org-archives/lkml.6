Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE2BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573AE20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="B5mtwSVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfAVHpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:45:08 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:62777 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfAVHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:45:07 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0M7h55U025355;
        Tue, 22 Jan 2019 16:43:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0M7h55U025355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548142986;
        bh=/EAQzAfgjQMPjJopeHVd+BRs6kFnnDKEQM2Nkxq5rFc=;
        h=From:To:Cc:Subject:Date:From;
        b=B5mtwSVLLFEemzEsPQyIL2J4v+p+jam/DCKTQ4+t65wj9hFw3wf8CYFMeDfWBoDHU
         WQqc/HLApvjvrdsCB2cPlsZUu1t6kraXGN+YCr/AfD885qA/N/E3YWhiDa352RUc8W
         OfoVkFfvS5R17bbFpIlFX4GFVoQyHzXaYwgPFXSO6IuCwShch7QDhbE46Ahi5LvqOv
         YP0mXHLsIOXCIWwr92k1yfloT/p3aTa8IlVlfwveELhxIwm2Dtbphq+Vd7dda8Y47C
         j9ECGjU7b7kyGvkhv0+x+74lt9aaH1XACav8iqIp01QfseLH4NUQXudY83vjj1Cvq6
         3VbVbU3UUZU8w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-tegra@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Lucas Stach <dev@lynxeye.de>
Subject: [PATCH 0/2] mtd: nand: use unnamed union field
Date:   Tue, 22 Jan 2019 16:42:53 +0900
Message-Id: <1548142975-14219-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new exec_op() scheme takes advantage of union
in order to store instruction private data, which is mutually
exclusive.

I felt a bit annoyed with the long accessors.
At least, we can omit "ctx." by making the union anonymous.

I converted nand_op_instr and nand_op_parser_pattern_elem.

I still see more instances, e.g.

  struct nand_op_data_instr {
          unsigned int len;
          union {
                  void *in;
                  const void *out;
          } buf;
          bool force_8bit;
  };

We could convert this into:

  struct nand_op_data_instr {
          unsigned int len;
          union {
                  void *ibuf;
                  const void *obuf;
          };
          bool force_8bit;
  };

Or, if we want to match the struct to NAND_OP_*_INSTR,
we can split it into two structures.

  struct nand_op_data_in_instr {
          unsigned int len;
          void *buf;
          bool force_8bit;
  };

  struct nand_op_data_out_instr {
          unsigned int len;
          const void *buf;
          bool force_8bit;
  };

Anyway, let's see if people are positive about
this shortning.



Masahiro Yamada (2):
  mtd: rawnand: use unnamed union in struct nand_op_instr
  mtd: rawnand: use unnamed union in struct nand_op_parser_pattern_elem

 drivers/mtd/nand/raw/ams-delta.c    | 18 +++++------
 drivers/mtd/nand/raw/fsmc_nand.c    | 41 +++++++++++-------------
 drivers/mtd/nand/raw/marvell_nand.c | 16 +++++-----
 drivers/mtd/nand/raw/nand_base.c    | 64 ++++++++++++++++++-------------------
 drivers/mtd/nand/raw/tegra_nand.c   | 10 +++---
 drivers/mtd/nand/raw/vf610_nfc.c    | 14 ++++----
 include/linux/mtd/rawnand.h         | 36 ++++++++++-----------
 7 files changed, 97 insertions(+), 102 deletions(-)

-- 
2.7.4


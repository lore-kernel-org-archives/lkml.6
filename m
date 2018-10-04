Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8AC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1797A2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvW3r7fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1797A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJDJao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:30:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJDJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:30:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so3386452wmf.1;
        Wed, 03 Oct 2018 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BuoEHJC4jY4yqfepGWybkr9iFLkUViviRupxISAm+U=;
        b=EvW3r7fv3tKmGOcpnBjrSYmqIb6FxE+aC2jmSAESd7Ut/aE/+tf67spSMYZHz2pbIe
         gZzaUYrBqczc4Y1FUCPugntiJVowHpNYo3wTIu0M9x2CZSvFiPCw5HZEnwuS+r02DJJY
         0PVT+Pc+bcBabwljk+8KSwLwOPdtjStJT0wsKv7Fkob9m0xUahSOmp7KDMGBXbZaGUXE
         UBACGboRFaJRoTX0dSKAbJJcZjL1phkmZuqWqke48eVeZcL/LqDwRfdtXZJEMsa5hW3Y
         ueuHae2HMXzyPh42ub8JDoEZUtsvtP8i9C5DBa3HRjgDM94mMpu/OuV99VEQRbnJA9cz
         PLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BuoEHJC4jY4yqfepGWybkr9iFLkUViviRupxISAm+U=;
        b=Ju1Hu06qJh14HKAZ3gdXrZagJDP+gkQO+3B3JBZf4a262b7kUMqb1TDnX6ZGF3NjyN
         +2EwMU+6ZDClFhjrA1RAA+ZIHulzYljcYAtecAFoDI/rJEFToq/pGUh7sXAXN0JyFgdZ
         2qLaUM0ddIOd6A/4Kqd7psIkcRwxRkMB/CWJ/8J55bDKwkLObcfMPg+vH3aQ6LK+PE1d
         pDEH+X3Z4PbD4CpTtZN3y7Ro4hsfP1HwuxkxzFHWqg9P7qO8lBud1glbkc2aqOdUyNh9
         WzF0pcNtTCnuRVPsZU90qz00DhGo22jawzZR8MVOI940T9Q96ANN3lw4MRGnJCbsEGPw
         WIng==
X-Gm-Message-State: ABuFfogA0GzbCVJPx4LdSojC2/vo/HRo5FbJd3tjegBzPDpf/RqXT6Eg
        Qb13Jte65ao23VqgQlsRbEHaB7i92Hk=
X-Google-Smtp-Source: ACcGV60fnHJViYueUGL/CPfCIYEX2JJx0VGoLVAqVBNP98MgP2CWA6SSLoav1Vn9EEgRdyJ5CYMPZg==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr1170154wmc.41.1538620778116;
        Wed, 03 Oct 2018 19:39:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a6-v6sm3474462wmf.22.2018.10.03.19.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 19:39:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] spi: spi-ep93xx: Change dir type in ep93xx_spi_dma_{finish,prepare}
Date:   Wed,  3 Oct 2018 19:39:26 -0700
Message-Id: <20181004023926.15847-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
\#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
\#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
\#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expects an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Converting to
dma_data_direction would be desirable but there are a few shared
structures that expect dma_transfer_direction so it is just simpler to
change the parameter here. dma_transfer_direction and dma_data_direction
are different sizes but this driver only uses the 1 and 2 values which
mean the same thing so this change is safe.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/spi/spi-ep93xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..189fc2225b69 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  * in case of failure.
  */
 static struct dma_async_tx_descriptor *
-ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * Function finishes with the DMA transfer. After this, the DMA buffer is
  * unmapped.
  */
-static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
-- 
2.19.0


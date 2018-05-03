Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeECMU4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:20:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeECMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:20:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3101860588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 00/14]  Update for QCOM NAND driver
Date: Thu,  3 May 2018 17:50:27 +0530
Message-Id: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* v2:

1. Addressed all review comments in v1.
1. Make the generic helper function for NAND ECC parameters setup
   and used this helper function for QCOM and Denali nand driver
   for ECC setup.
2. Modified commit message for some of the patches and added more
   comments.
3. Added new patch for fixing ‘return 0’ for raw read.
4. Removed the read last codeword part for nand oob write.
5. Reorganized bad block check function and removed the
   read_last_cw function completely.

* v1:

This patch series mainly deals with error handling and erased page
bitflip detection for QCOM NAND driver.

1. The error handling was missing for some of the cases so fixed
   the same.

2. Add the support for taking ECC strength from ONFI parameter.
   The earlier QCOM boards were coming with 4-bit ECC chip but
   now the same boards are coming with 8-bit ECC chip since the
   earlier 4-bit parts are obsolete from some vendors.

3. We got few issues related with NAND erased page bitflips. The
   QCOM NAND controller can’t detect the bitflip in completely erased
   page so added the support to detect the same. It implemented the
   logic mentioned in patch [1] which didn’t go in mainline and later
   the generic functions were provided [2] to count the number of
   bitflips and make all 0xff. This patch series did some optimization
   logic to prevent the unnecessary full page raw read and data copy
   from QCOM NAND controller to DMA.

4. Following are the testing done for these patches in QCOM IPQ8074
   HK01 (4-bit and 8-bit ECC chip) and IPQ806x AP148 boards.
    a. Run all mtd test and check if it passes
    b. Introduce custom bitflips in erased page and check if it
       returns no error/EUCLEAN/EBADMSG depending upon number of
       bitflips and position.
    c. Introduce failure condition for operational failure and
       check if it detects the same.

[1]: https://patchwork.ozlabs.org/patch/328994/
[2]: https://patchwork.ozlabs.org/patch/509970/

Abhishek Sahu (14):
  mtd: rawnand: helper function for setting up ECC parameters
  mtd: rawnand: denali: use helper function for ecc setup
  dt-bindings: qcom_nandc: make nand-ecc-strength optional
  mtd: rawnand: qcom: use the ecc strength from device parameter
  mtd: rawnand: qcom: wait for desc completion in all BAM channels
  mtd: rawnand: qcom: erased page detection for uncorrectable errors
    only
  mtd: rawnand: qcom: fix null pointer access for erased page detection
  mtd: rawnand: qcom: parse read errors for read oob also
  mtd: rawnand: qcom: modify write_oob to remove read codeword part
  mtd: rawnand: qcom: fix return value for raw page read
  mtd: rawnand: qcom: minor code reorganization for bad block check
  mtd: rawnand: qcom: check for operation errors in case of raw read
  mtd: rawnand: qcom: helper function for raw read
  mtd: rawnand: qcom: erased page bitflips detection

 .../devicetree/bindings/mtd/qcom_nandc.txt         |   4 +-
 drivers/mtd/nand/raw/denali.c                      |  30 +-
 drivers/mtd/nand/raw/nand_base.c                   |  42 ++
 drivers/mtd/nand/raw/qcom_nandc.c                  | 622 ++++++++++++++-------
 include/linux/mtd/rawnand.h                        |   3 +
 5 files changed, 461 insertions(+), 240 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

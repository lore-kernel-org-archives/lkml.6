Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeBCH6l (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:58:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35208 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBCH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:58:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CEE36050D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 00/12] Major code reorganization to make all i2c transfers working
Date: Sat,  3 Feb 2018 13:28:05 +0530
Message-Id: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver is failing in following test case
1. Handling of failure cases is not working in long run for BAM
   mode. It generates error message “bam-dma-engine 7884000.dma: Cannot
   free busy channel” sometimes.
2. Following I2C transfers are failing
   a. Single transfer with multiple read messages
   b. Single transfer with multiple read/write message with maximum
      allowed length per message (65K) in BAM mode
   c. Single transfer with write greater than 32 bytes in QUP v1 and
      write greater than 64 bytes in QUP v2 for non-DMA mode.
3. No handling is present for Block/FIFO interrupts. Any non-error
   interrupts are being treated as the transfer completion and then
   polling is being done for available/free bytes in FIFO.

To fix all these issues, major code changes are required. This patch
series fixes all the above issues and makes the driver interrupt based
instead of polling based. After these changes, all the mentioned test
cases are working properly.

The code changes have been tested for QUP v1 (IPQ8064) and QUP
v2 (IPQ8074) with sample application written over i2c-dev.

Abhishek Sahu (12):
  i2c: qup: fixed releasing dma without flush operation completion
  i2c: qup: minor code reorganization for use_dma
  i2c: qup: remove redundant variables for BAM SG count
  i2c: qup: schedule EOT and FLUSH tags at the end of transfer
  i2c: qup: fix the transfer length for BAM rx EOT FLUSH tags
  i2c: qup: proper error handling for i2c error in BAM mode
  i2c: qup: use the complete transfer length to choose DMA mode
  i2c: qup: change completion timeout according to transfer length
  i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
  i2c: qup: send NACK for last read sub transfers
  i2c: qup: reorganization of driver code to remove polling for qup v1
  i2c: qup: reorganization of driver code to remove polling for qup v2

 drivers/i2c/busses/i2c-qup.c | 1538 +++++++++++++++++++++++++-----------------
 1 file changed, 924 insertions(+), 614 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E2C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E2A2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIj2IQkb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIj2IQkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E2A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLACMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:12:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeLACMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:12:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1A6D60B1E; Fri, 30 Nov 2018 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543590189;
        bh=TWe+V0+W9z/q6fEwQadzwTZsWBYX2QPZn4CzeULqfWM=;
        h=From:To:Cc:Subject:Date:From;
        b=aIj2IQkb9i7Eczpr/1J13C1t82oxpzZy4NKSXyx3rgSSo3CNByEEiarEaYpY9gDsX
         7SnYKtLsAtWcMeg+QobEgeCEYiwOEeP7rf3LPu7Z5hke3hEQ+1c0FqSi02EjUbLSvi
         /QUJy1ArVH5HGBFbt6FunI6lNIA4u/iBtmPN7K5M=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B2A6601D2;
        Fri, 30 Nov 2018 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543590189;
        bh=TWe+V0+W9z/q6fEwQadzwTZsWBYX2QPZn4CzeULqfWM=;
        h=From:To:Cc:Subject:Date:From;
        b=aIj2IQkb9i7Eczpr/1J13C1t82oxpzZy4NKSXyx3rgSSo3CNByEEiarEaYpY9gDsX
         7SnYKtLsAtWcMeg+QobEgeCEYiwOEeP7rf3LPu7Z5hke3hEQ+1c0FqSi02EjUbLSvi
         /QUJy1ArVH5HGBFbt6FunI6lNIA4u/iBtmPN7K5M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B2A6601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v3 0/4] Bug fixes for Qualcomm BT chip wcn3990 
Date:   Fri, 30 Nov 2018 20:32:43 +0530
Message-Id: <20181130150247.26294-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below issues are found in the recent testing.

1. Observed device is not going into off state or not responding.
    As wcn3990 require a power pulses to turn on the irrespctive of
    igniting regulators, it was observed that power on or power off
    pulses are not in sync with respective to chip.
    The below patch will help us to wait until byte is pushed on to wires.          

    * Bluetooth: hci_qca: use wait_until_sent() for power pulses

2. Observed Chip responding when we are in sleep.
   This is due to turn on flow control during change baudrate request.
   The below patch will only pull the RTS line high instead of turning off
   the flow.

   * Bluetooth: hci_qca: Pull RTS line high for baudrate change command.

3. Frame reassembly errors splashing on console.
   wcn3990 requires will use multiple baudrates during booting stage.
   i.e. 2400 bps while sending power off pulse
    115200 bps while sending power on pulse
    port close
    port open
    set baudrate to 115200 request the chip version.

  during above process, we are seeing some stray bytes coming up
  on the UART Rx FIFO it could be due to frequent baudrate change.

  This patch will stop the frame reassembly errors.

  * Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990

4. Disable IBS state machine and flush Tx buffer
   We are disabling IBS and flushing the Tx buffer before turning off the chip.
  
   This is due to IBS state machine is active when we turn off the chip.
   This will stop queuing IBS protocol bytes.

   * Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer

Changes in v3:
 * moved IBS & qca_flush to different patch
 * updated comments in code fo Deassert RTS patch

Changes in v2:
 * Removed Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE flag patch
   will be sending as separate series.
Balakrishna Godavarthi (4):
  Bluetooth: hci_qca: use wait_until_sent() for power pulses
  Bluetooth: hci_qca: Deassert RTS while baudrate change command
  Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990
  Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer

 drivers/bluetooth/hci_qca.c | 77 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


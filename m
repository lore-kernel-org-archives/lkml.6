Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00647C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E9B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6J7SEeo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P6J7SEeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbeLQONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:13:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46654 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeLQONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AD906076A; Mon, 17 Dec 2018 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056025;
        bh=QQPlGJ6nyMe+PA6Gkrfu1shbbb+6dt1ib4r73YjdKLc=;
        h=From:To:Cc:Subject:Date:From;
        b=P6J7SEeoOHOdAsjBM8TwuOjIFKe4iHDVZnRIxzYNj96YWUxogdk/q9R1w9k6eL+eF
         KcjZKd20WfekCCXu/UtyNt+T3/DJg1BxvIqT6bCB1+XJVXZ2o1MVgprpC1/hDbc8S5
         s1BlapuzSIdiCVFx8PoQsJ9KgVwheQhPITDNhb1o=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24A8160208;
        Mon, 17 Dec 2018 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056025;
        bh=QQPlGJ6nyMe+PA6Gkrfu1shbbb+6dt1ib4r73YjdKLc=;
        h=From:To:Cc:Subject:Date:From;
        b=P6J7SEeoOHOdAsjBM8TwuOjIFKe4iHDVZnRIxzYNj96YWUxogdk/q9R1w9k6eL+eF
         KcjZKd20WfekCCXu/UtyNt+T3/DJg1BxvIqT6bCB1+XJVXZ2o1MVgprpC1/hDbc8S5
         s1BlapuzSIdiCVFx8PoQsJ9KgVwheQhPITDNhb1o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24A8160208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 0/5] Bug fixes for Qualcomm BT chip wcn3990 
Date:   Mon, 17 Dec 2018 19:43:25 +0530
Message-Id: <20181217141330.6294-1-bgodavar@codeaurora.org>
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

5. btqca: inject command complete event during fw download
   
   Qualcomm latest chip will not send an command complete event
   for last packet of the fw dump sent, so here we are inject an command 
   complete event.

   * Bluetooth: btqca: inject command complete event during fw download

Changes in v3:
 * moved IBS & qca_flush to different patch
 * updated comments in code fo Deassert RTS patch

Changes in v4:
 * used serdev_device_write_buf() instead of serdev_device_write().
 * added new patch to stop logging of 0xfc00 timeout on console.
Balakrishna Godavarthi (5):
  Bluetooth: hci_qca: use wait_until_sent() for power pulses
  Bluetooth: hci_qca: Deassert RTS while baudrate change command
  Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990
  Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
  Bluetooth: btqca: inject command complete event during fw download

 drivers/bluetooth/btqca.c   | 39 ++++++++++++++++++-
 drivers/bluetooth/btqca.h   |  3 ++
 drivers/bluetooth/hci_qca.c | 77 +++++++++++++++++++++----------------
 3 files changed, 84 insertions(+), 35 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


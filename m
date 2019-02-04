Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DS5MVfGE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ikcv7c2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfBDPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:06:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:06:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3282F607F5; Mon,  4 Feb 2019 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292816;
        bh=R7qQaYeLaHBZ4OlnpE574h2tGHnIx/7WlkRp8HSGbHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DS5MVfGE364c4fuhA9dpLJGxyF6W+Y2MkJqmwlwe32TWWY8XxrWUdCjUxw8O9XfWt
         oUUfAG8nYxkWP2WtRkDr3Sr5xPLS0WsjCwfm4m6aefXCfQhubA7/yYecpQS/fw1XLk
         Vk6wRxlGu9u+L9CMxAJ6sPfl8wgOjqkLkzaAE2xY=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91DD16074F;
        Mon,  4 Feb 2019 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292815;
        bh=R7qQaYeLaHBZ4OlnpE574h2tGHnIx/7WlkRp8HSGbHQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ikcv7c2pzOtTK0y+SpbDS/Cv2ol957A6mkIk6/oiozxksyJR/6ZXyUeuCp7PLnpKJ
         SBGza/dO3xEptF620ZsexpLLRRtM08gKSgB/gyKs0z/41cdwdiQtRRRrIa2N34m8ei
         V67mHwyL05R8bBXNgq8U/FUz4GYhZjfxbMJezwOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91DD16074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 0/3] Bug fixes for Qualcomm BT chip wcn3990
Date:   Mon,  4 Feb 2019 20:36:40 +0530
Message-Id: <20190204150643.25165-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below issues are found in our recent testing.

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

3. Disable IBS state machine and flush Tx buffer
   We are disabling IBS and flushing the Tx buffer before turning off the chip.
  
   This is due to IBS state machine is active when we turn off the chip.
   This will stop queuing IBS protocol bytes.

   * Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer

Changes in v11:
* added correct signatures for the patch.

Changes in v10:
 * Decreased wait time for power pulse to 100 ms instead of 1second.
 * enabling the flow control back when baudarte change request fails.
 * updated review comments.
 
Changes in v9:
 * Reverted the 100us delay and used msecs to jiffies inline call.
 * Disabling the flow control and enabling it back while setting the firmware.
 * Added spinlock while clearing the IBS state machine.
  
Changes in v8:
 * dropped inject the command complete event.
 * added one second time for the power pules instead of the indefinite time.

Changes in v7:
 * dropped frame reassmebly error patch.
 * dropped baudrate change wait time patch.
 * increased a wait to 5 ms for power pulses.

Changes in v6:
 * added serdev_device_write_flush in qca_send_power_pulse().
 * added new patch to update the baudrate change wait time.

Changes in V5:
 * added serdev_device_write_flush before sending the power off pulse
   during shutdown.

Changes in v4:
 * used serdev_device_write_buf() instead of serdev_device_write().
 * added new patch to stop logging of 0xfc00 timeout on console.

Changes in v3:
 * moved IBS & qca_flush to different patch
 * updated comments in code fo Deassert RTS patch
Balakrishna Godavarthi (3):
  Bluetooth: hci_qca: use wait_until_sent() for power pulses
  Bluetooth: hci_qca: Deassert RTS while baudrate change command
  Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer

 drivers/bluetooth/hci_qca.c | 82 ++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 38 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


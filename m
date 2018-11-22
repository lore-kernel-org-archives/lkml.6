Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3CB204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TtjLDvr8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iEtOliUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3CB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbeKVWyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:54:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436604AbeKVWyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:54:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF04760722; Thu, 22 Nov 2018 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542888923;
        bh=imLFzE/n3oq6D6ViD/ARlYWDb4CzJYkGtQRNHvETa5k=;
        h=From:To:Cc:Subject:Date:From;
        b=TtjLDvr8NZ+K9Y9mhFgNApaoVCvSz8jsoMT2uV7haMVZ8BWL7VJ5pysAqgGICcPqa
         4E5n2nneInLPtBIC1Qc5fgRDEBT3b+FhmhY/0j7H+Y6owExDWMUtRHJLtZrdsTMkwg
         e9UeV0QceK5ocR7Qmuy2vDYuJQOGECMktzRfIU8M=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B9A460722;
        Thu, 22 Nov 2018 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542888922;
        bh=imLFzE/n3oq6D6ViD/ARlYWDb4CzJYkGtQRNHvETa5k=;
        h=From:To:Cc:Subject:Date:From;
        b=iEtOliUMJwPs6bs7A8ngELU/19kWzDbQZLORTnE7n1MNy8NVn/ajPAjDUkJZmDJuZ
         eEcHHs3pABwqAUpJtEMro3MBKf0xbKefsKD1bLdICAxSPQohEYZh9cpeM3UTX85Pix
         f4wn+KHv+QIsi/f958FF62NAwd5fy3GdGigZRHfE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B9A460722
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 0/3] Bug fixes for Qualcomm BT chip wcn3990 
Date:   Thu, 22 Nov 2018 17:45:09 +0530
Message-Id: <20181122121512.13136-1-bgodavar@codeaurora.org>
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


Changes in v2:
 * Removed Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE flag patch
   will be sending as separate series.

Balakrishna Godavarthi (3):
  Bluetooth: hci_qca: use wait_until_sent() for power pulses
  Bluetooth: hci_qca: Deassert RTS while baudrate change command
  Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990

 drivers/bluetooth/hci_qca.c | 76 ++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 34 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


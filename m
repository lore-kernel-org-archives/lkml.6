Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B98F2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Miv0nPTi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Miv0nPTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B98F2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeHVP3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:29:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeHVP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:29:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 557F8602BD; Wed, 22 Aug 2018 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939466;
        bh=Mi673Uz0eX7Y8JN2Gz6UdSp5vTdB53l76rdZIwK60bU=;
        h=From:To:Cc:Subject:Date:From;
        b=Miv0nPTiU9NNVuVEBGYJJ153cpW1gJX9LhE0Xn4AUkd4azFXgfklyzSfdqLVPVwfx
         XRdl0g3wp0xSCVqKmWxSvi8aR2SJPUsok431KC2gvQgczOw55pGI1om9uGN/hYzSTK
         YGKHnK5lVrDLh/lqi6gJi6kIltF1aoNfTMW5ytsI=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DBFD60159;
        Wed, 22 Aug 2018 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939466;
        bh=Mi673Uz0eX7Y8JN2Gz6UdSp5vTdB53l76rdZIwK60bU=;
        h=From:To:Cc:Subject:Date:From;
        b=Miv0nPTiU9NNVuVEBGYJJ153cpW1gJX9LhE0Xn4AUkd4azFXgfklyzSfdqLVPVwfx
         XRdl0g3wp0xSCVqKmWxSvi8aR2SJPUsok431KC2gvQgczOw55pGI1om9uGN/hYzSTK
         YGKHnK5lVrDLh/lqi6gJi6kIltF1aoNfTMW5ytsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DBFD60159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/2] Fix for proto races in hci_serdev.
Date:   Wed, 22 Aug 2018 17:34:10 +0530
Message-Id: <20180822120412.20285-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In recent testing we found that while removing hci_uart, we have seen
execution of hci_uart_write_work() after calling vendor specific
proto close. As we are freeing the vendor specific Tx and Rx buffers
in vendor close, execution of functions i.e. Rx or Tx functions may cause
a crash.

we already have a commit for hci_ldisc.c "e508e6026b19" and "048e1bd3a27f"
to overcome the race condition.

Changes of v1:
 
  * clearing flag HCI_UART_PROTO_READY while mnodule deinit such that
    we will not have any tractions further on Tx or Rx.
  * added check of HCI_UART_PROTO_READY while dequeuing an packet.
  

Balakrishna Godavarthi (2):
  Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing
    proto races
  Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().

 drivers/bluetooth/hci_serdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


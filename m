Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6234C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6664B20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJaMN4Sm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gDSuX0Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6664B20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHVPpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:45:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHVPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:45:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 17227601DA; Wed, 22 Aug 2018 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534940428;
        bh=mmINrn4jGdsfprfFqbr3U2qNextABHJwBuFs2Dxmabg=;
        h=From:To:Cc:Subject:Date:From;
        b=mJaMN4SmLfPhZ0JPOcfzWP9n0tiVSkgPz5i/7DIvqoEqQPRAfk+XWjigp1HAAyT72
         NbBZ7g8ZJZhjf4RTX3WWvOOrRc7rMvNO0gU9zjJzQexui0jxzS60JvsxaPU+uMgRix
         gRhyclJPyFo3cQLRWUwYHMnzMRvI0Skm0LDyA6gw=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C6C560159;
        Wed, 22 Aug 2018 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534940427;
        bh=mmINrn4jGdsfprfFqbr3U2qNextABHJwBuFs2Dxmabg=;
        h=From:To:Cc:Subject:Date:From;
        b=gDSuX0PcQqAybxi4ZywwSydLmkH5oePj/nTI2DY6h99/Cw7Xzsrq/pilNDtrL7HgQ
         vkRclkIYWdrrgq4poaQhPoosHBS2nvndSzDptAEMRVN9W/5eFz35mhP1YPts+9IKQ4
         78CDMvno+NSmkJBWPmoxpsnTO7saMDh/lAVhTP4M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C6C560159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/2] Bug fixes for qualcomm BT chip wcn3990. 
Date:   Wed, 22 Aug 2018 17:50:03 +0530
Message-Id: <20180822122005.11218-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we set an KASAN flags, we are seeing an crash while removing module hci_uart.
This is due to dereference of hdev. As in module deinit we are calling function
hci_free_dev() to free hdev.
 
Changes in v1:
 
  * removed dereference of hdev in qca_power_shutdown i.e. qca_close.
  * moved serdev open & close call from qca_open & qca_close.


Balakrishna Godavarthi (2):
  Bluetooth: hci_qca: Remove serdev_device_open/close function calls
  Bluetooth: hci_qca: Remove hdev dereference in qca_close().

 drivers/bluetooth/hci_qca.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


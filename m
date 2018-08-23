Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C92208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcM7fqDL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcM7fqDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C92208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeHWO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:59:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:59:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9306960116; Thu, 23 Aug 2018 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023794;
        bh=KOfShrouAh0o3MPquD80QsV3JNp3+ysEbChYR76+9Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=kcM7fqDLBu6SRn1O+Y1mL9OZBA63dpeJRAxhzbfYLDKHT3FxFw9LymYF9CbVjkSIo
         SROCj3Wsx8vyaPYRsSnCMGAK/zX5MYdFtVDjIlFFoLQxtThR61Z7+I6V1feWSih1Zo
         g7eYWoVUqieWjNND2SPHF32QL7+0ANYSpP3RoWVA=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D0D160227;
        Thu, 23 Aug 2018 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023794;
        bh=KOfShrouAh0o3MPquD80QsV3JNp3+ysEbChYR76+9Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=kcM7fqDLBu6SRn1O+Y1mL9OZBA63dpeJRAxhzbfYLDKHT3FxFw9LymYF9CbVjkSIo
         SROCj3Wsx8vyaPYRsSnCMGAK/zX5MYdFtVDjIlFFoLQxtThR61Z7+I6V1feWSih1Zo
         g7eYWoVUqieWjNND2SPHF32QL7+0ANYSpP3RoWVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D0D160227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 0/1] Cold on & off support for Qualcomm BT chip wcn3990. 
Date:   Thu, 23 Aug 2018 16:59:34 +0530
Message-Id: <20180823112935.17342-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will power off regulators while hci0 down and turn on them 
back on hci0 up. Every time we power off we call proto specific close
function, so that we will free the memory of Qualcomm BT specific buffers.
Will call proto open to assign the memory and turn on the regulators, before
calling qualcomm setup.

Balakrishna Godavarthi (1):
  Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990

 drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


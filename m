Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B7ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64F920877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BqO8R/W3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k8YXY1cM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64F920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbeISU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:59:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbeISU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:59:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6ED5E60C54; Wed, 19 Sep 2018 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537370483;
        bh=fWNsE9Q45px4YHyiXaY2ZIfd0l6k0BII1sBT8WV9GLA=;
        h=From:To:Cc:Subject:Date:From;
        b=BqO8R/W3CjfMPMLWHUFSf/IMS3hcwWEn8W0iR6UQhx1NUQxV9QqriPoURdbS1MK4v
         knXvnTy5UzZT4lMs9U+bzbpH4GvXP1d7MRSXQLIGH2ZDSO24mvjivgRH8BphKKEYA9
         7vmhhB11KeCLkTs5ZKYUUdMQt2rC4u8ZmGpWde78=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A8DD60BF5;
        Wed, 19 Sep 2018 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537370482;
        bh=fWNsE9Q45px4YHyiXaY2ZIfd0l6k0BII1sBT8WV9GLA=;
        h=From:To:Cc:Subject:Date:From;
        b=k8YXY1cMNz58+qt2dMrmJTooY5P+xV+qzDEX52ORQBipoWU9ev5TSIt8YSCNWBnYC
         xKRsDpeh9wS5KzCltTWY5NjkUkuI3DZbWgc3iUPRwtrpgERiiAPIZQyp1nWhTEcyGi
         3A/NaNby4OEgC7k/qVryV/Fu2foOYPPjUEJNPNOI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A8DD60BF5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 0/1] Cold on & off support for Qualcomm BT chip wcn3990 
Date:   Wed, 19 Sep 2018 20:51:12 +0530
Message-Id: <20180919152113.7611-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will power off regulators while hci0 down and turn on them 
back on hci0 up. Every time we power off we call proto specific close
function, so that we will free the memory of Qualcomm BT specific buffers.
Will call proto open to assign the memory and turn on the regulators, before
calling qualcomm setup.

v2:
   * Removed vendor specific hdev->open and close functions.
   * Added hdev->shutdown function to turn off the regs.	
	
v1:
   * initial patch.

Balakrishna Godavarthi (1):
  Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990

 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


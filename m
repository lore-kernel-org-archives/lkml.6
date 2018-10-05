Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E622208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YaR4aepZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YaR4aepZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E622208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJEN5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:57:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbeJEN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:57:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8797D60C1B; Fri,  5 Oct 2018 06:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538722789;
        bh=lUFiFZAlUpKVaK69371o6dNzx/lXGT6MRnhc8pb/7/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=YaR4aepZ7Dn16H4t6K32n8SPcl8wkerw+S37uyDo+Rk+hlXxpJ93xDS0t5kLraZYE
         DAlz3BilvnvVLQmWsaIzn4Jkv92wRPA5hWKCq/4oC74ptQ8Poye9q8y1l/tpyzGGtl
         FcPQ8PqNSCjkWG44J6h8A1tMgirdOxom6zblRtJA=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92FD960445;
        Fri,  5 Oct 2018 06:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538722789;
        bh=lUFiFZAlUpKVaK69371o6dNzx/lXGT6MRnhc8pb/7/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=YaR4aepZ7Dn16H4t6K32n8SPcl8wkerw+S37uyDo+Rk+hlXxpJ93xDS0t5kLraZYE
         DAlz3BilvnvVLQmWsaIzn4Jkv92wRPA5hWKCq/4oC74ptQ8Poye9q8y1l/tpyzGGtl
         FcPQ8PqNSCjkWG44J6h8A1tMgirdOxom6zblRtJA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92FD960445
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V3 0/4] Add TIOCM Signals support for RPMSG char devices
Date:   Fri,  5 Oct 2018 12:29:32 +0530
Message-Id: <1538722776-13648-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glink transport support signals to exchange state notification between
local and remote side clients. Adding support to send/receive the signal
command and notify the clients through callback and POLL notification.

Changes since v1:
- Split the patches as per functional areas like core, char, glink
- Add set, clear mask for TIOCMSET
- Merge the char signal callback and POLLPRI patches

Changes since v2:
- Modify the rpmsg_get_signals function prototype

Arun Kumar Neelakantam (4):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
  rpmsg: char: Add signal callback and POLLPRI support

 drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  74 +++++++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |   5 ++
 include/linux/rpmsg.h             |  26 ++++++++
 5 files changed, 269 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


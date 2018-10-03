Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1953C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C19F213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="deosrePp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJjxHg/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C19F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeJCSWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:22:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54908 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:22:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 305B060C67; Wed,  3 Oct 2018 11:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566482;
        bh=JstaqsInojtNPeIqrkhknMY3aUrHOUCYU+jxdoFnTLM=;
        h=From:To:Cc:Subject:Date:From;
        b=deosrePpFgDa7vd5WJqoQO1gd6tk7WkoNfFEGlwVjSzfsCgvUmJRQ+i2wAVoIV2Vo
         iGl+KpDWR7HfO7/Aty5xlKbustxlXfPI1EOaNQvEE78N7FWy6Rv36t5bMM9rl9Slas
         8eFfwq1qMjV2BD4j9ASxM5rotCQWI1mC3J3ApP7Q=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CB9960B26;
        Wed,  3 Oct 2018 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538566481;
        bh=JstaqsInojtNPeIqrkhknMY3aUrHOUCYU+jxdoFnTLM=;
        h=From:To:Cc:Subject:Date:From;
        b=mJjxHg/wy5tmosaQS+Vc3X5NBUOg0YXI7pWn1wWBZzYOzInMpg7AMIjp9n0UA5Hof
         5vQDSrvckUAv0x3JZKI03NSyMktdsMzXYOyeFVCdRVFTc5RClAGAONU1w/de18FXvV
         pel9uE5TLzcLutYjc0mx9tPdSjXp6sY8Q0YbDinc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CB9960B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 0/5] Add TIOCM Signals support for RPMSG char devices
Date:   Wed,  3 Oct 2018 17:04:18 +0530
Message-Id: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glink transport support signals to exchange state notification between
local and remote side clients. Adding support to send/receive the signal
command and notify the clients through callback and POLL notification.

Arun Kumar Neelakantam (5):
  rpmsg: glink: Add GLINK signal support for RPMSG
  rpmsg: Add signal callback to rpmsg char device
  rpmsg: Add TIOCMGET/TIOCMSET ioctl support
  rpmsg: wakeup poll to notify signal update
  rpmsg: glink: Convert the native signals to TIOCM

 drivers/rpmsg/qcom_glink_native.c | 109 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  76 ++++++++++++++++++++++++--
 drivers/rpmsg/rpmsg_core.c        |  41 ++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |   5 ++
 include/linux/rpmsg.h             |  25 +++++++++
 5 files changed, 253 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


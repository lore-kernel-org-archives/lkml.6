Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F37C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3688821480
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MzykVGAi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LxENiXKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688821480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJDUdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:33:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:33:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6703D607F4; Thu,  4 Oct 2018 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538660433;
        bh=sfcAhcy+9GmrPMHdIGm1/YtoQlNjJuS2G1krXZgBuqo=;
        h=From:To:Cc:Subject:Date:From;
        b=MzykVGAiIx4oakjg317vMbkrmOXGcXNYhp4CjzEmrjXGSj3CifIviLsTdQHc7G/1N
         EaP5sV5iigjcE8uCoKVqHwD3PyTzODoh0BWkT6FTYt7hS80SA5jSfZb91XNN1e0US1
         VK09yJOkgPlI05EIVhGcopCC3+2xyh6UbrNqt6ec=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 625966081B;
        Thu,  4 Oct 2018 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538660432;
        bh=sfcAhcy+9GmrPMHdIGm1/YtoQlNjJuS2G1krXZgBuqo=;
        h=From:To:Cc:Subject:Date:From;
        b=LxENiXKnW04Nub57f+6FE11A5TCmpjTMlNX0KaqNL/6GdIRv8ua1P68oXpRUb8qnn
         8k17fh7+mEZDAou1cGaXyjclkG0ldVBcN8F6OBJCQeTerd2tgN30dY+luqJimxAn2I
         nXwORDEk7Aibq3cORDqFPFKr7bAiMt6yA5pgSRMw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 625966081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V2 0/4] Add TIOCM Signals support for RPMSG char devices
Date:   Thu,  4 Oct 2018 19:10:16 +0530
Message-Id: <1538660420-27797-1-git-send-email-aneela@codeaurora.org>
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

Arun Kumar Neelakantam (4):
  rpmsg: core: Add signal API support
  rpmsg: glink: Add support to handle signals command
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
  rpmsg: char: Add signal callback and POLLPRI support

 drivers/rpmsg/qcom_glink_native.c | 130 ++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_char.c        |  75 +++++++++++++++++++++-
 drivers/rpmsg/rpmsg_core.c        |  42 ++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |   5 ++
 include/linux/rpmsg.h             |  27 ++++++++
 5 files changed, 276 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


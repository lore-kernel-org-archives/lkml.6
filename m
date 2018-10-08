Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9220B2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PHocA1jc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="keovbENC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9220B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJHNtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:49:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeJHNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:49:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45FC26079B; Mon,  8 Oct 2018 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980763;
        bh=4M9FjBCbxNPwoY0Ir8hV9E7tX1aQzE+/fokXOZLsMHk=;
        h=From:To:Cc:Subject:Date:From;
        b=PHocA1jcN7m2prEgcwMIeGVxAy7TFXu7y0nZM6mkp6SccbQYSdvXCNkRZ3W05dEa6
         oJMBChIOb+7jzA74lToh2SoyfmUy7+LSsn3rmJlxMLq01GRB5YZ9etzfgmtmXz7A01
         PtTRqwzbtLFkIfCyjcBTiFKl0CAlFokWnmnv/ios=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C67560388;
        Mon,  8 Oct 2018 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538980762;
        bh=4M9FjBCbxNPwoY0Ir8hV9E7tX1aQzE+/fokXOZLsMHk=;
        h=From:To:Cc:Subject:Date:From;
        b=keovbENCO+KmQ4PuPNjTCe3eBWPm3v8q8O3umdZvzuPNakj1a/zpS0krU98nVQFkE
         0Po6h9T+U2bTXD8h3CMBfBe0aU6KsAHBVRkexsY8x7i8ata7+uoinM3CSBiZBUuoYY
         v7rGUlgv/prcVwECYMlrxn0UAy4vB8A5WFi18cSA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C67560388
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 0/4] Add TIOCM Signals support for RPMSG char devices
Date:   Mon,  8 Oct 2018 12:08:14 +0530
Message-Id: <1538980699-21516-1-git-send-email-aneela@codeaurora.org>
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

Changes since v3:
- Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
- Update the rpmsg_get_signals function header

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


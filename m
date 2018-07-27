Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC24C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3EE208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PzdnfTOp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PqmvOcli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3EE208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeG0Nja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:39:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbeG0Nj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:39:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C2646085F; Fri, 27 Jul 2018 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693869;
        bh=0NUJQkoZv+1ixe9JLls0CwiZwu4oR3jNSVtfE52R8jA=;
        h=From:To:Cc:Subject:Date:From;
        b=PzdnfTOpILYOIYOlgMuk3o3BZPd41ok/+VtashQ7sWZpMmt1LTqiEyHwHtw2urnPv
         BzyFs38pUgk+Ap+EmQ4BC7tfAwamC5U/rDJ4kX8DLx2HWAR/eqGxLM6ax5Di8zPV+t
         8uFGixBZNsli4vzbo+WIbORQlm6BvH6ZSrsJpRaQ=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 035E3605BD;
        Fri, 27 Jul 2018 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693868;
        bh=0NUJQkoZv+1ixe9JLls0CwiZwu4oR3jNSVtfE52R8jA=;
        h=From:To:Cc:Subject:Date:From;
        b=PqmvOcliLmuCSTxQTgDbBWO7hm7aeAC0wnMPtdd+IT4R95YnUnJ+G/FVvhCt1NNT0
         raoZNCIDg9R9kHqiqEjwdDkBioxS4s9M3hkONK0RbX7QrldJsYOcyubWuM3Z1vwhiH
         dlH7jf3ZOupGjOVlE7g1AfyeZyK+o4XR4w34vU8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 035E3605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 0/9] Add chrdev and name query support for GLINK
Date:   Fri, 27 Jul 2018 17:47:20 +0530
Message-Id: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the GLINK rpmsg transport to register a rpmsg chrdev.
This will create the rpmsg_ctrl nodes for userspace clients to open 
rpmsg epts. Create a label property that will help userspace clients
distinguish between the different GLINK links. The rpmsg chrdev 
allocation is done by allocating a local channel which also allocates
an ept. We need to add some guards against edge cases for this chrdev
because it will never fully open.

Changes since v3:
- Change to device_add_group for rpmsg name attr
- Add patch to unregister the rpmsg device
- Add patch to support compat ioctl for rpmsg char driver

Changes since v2:
- Revert change to make glink attribute table const

Changes since v1:
- Add explanation to dt-bindings commit message
- Add patch complete_all the open_req/ack variables
- Add patch to prevent null pointer dereference in chrdev channel release
- Change chrdev allocation to use glink channel allocation
- Change glink attr struct to const

Arun Kumar Neelakantam (2):
  rpmsg: glink: unregister rpmsg device during endpoint destroy
  rpmsg: Add compat ioctl for rpmsg char driver

Chris Lew (7):
  dt-bindings: soc: qcom: Add label for GLINK bindings
  rpmsg: glink: Store edge name for glink device
  rpmsg: glink: Use complete_all for open states
  rpmsg: Guard against null endpoint ops in destroy
  rpmsg: glink: Add support for rpmsg glink chrdev
  rpmsg: glink: Expose rpmsg name attr for glink
  rpmsg: glink: Remove chunk size word align warning

 .../devicetree/bindings/soc/qcom/qcom,glink.txt    |  5 ++
 drivers/rpmsg/qcom_glink_native.c                  | 88 ++++++++++++++++++++--
 drivers/rpmsg/rpmsg_char.c                         |  2 +
 drivers/rpmsg/rpmsg_core.c                         |  2 +-
 4 files changed, 90 insertions(+), 7 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


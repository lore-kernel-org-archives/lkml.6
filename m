Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041CAC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD68420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CdM595XV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q1BRFxCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD68420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeJWM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:57:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:57:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78C28611F1; Tue, 23 Oct 2018 04:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269373;
        bh=emgBIf1Pwi67lf0bNoGLXKtdK36mpWNRlSIow7nthGA=;
        h=From:To:Cc:Subject:Date:From;
        b=CdM595XVDu/fteseqDT1mkYIbwZayABqEK9qukIt+O01Ld7BR1YDQ4Xow3q9o16ow
         WD6w8lU/apinS3RZ5kKdEtqAPqqZiuqGp39p1Z5Zh3d9HjtgTHpX8vRANoo45KFEV9
         DJR1ZpKjqfWdGbKHU+BcjsOLFxEU/9MRMl4jmiDM=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEB8960C48;
        Tue, 23 Oct 2018 04:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269372;
        bh=emgBIf1Pwi67lf0bNoGLXKtdK36mpWNRlSIow7nthGA=;
        h=From:To:Cc:Subject:Date:From;
        b=Q1BRFxCksEvK4ZJZ07r+VJ1DXKybGgkRF9bY8N67eGHjaWZIEFFQs2TVedU54rrg4
         jC8Ao1j4rmlZyxjPkAwsw2SHvjpZRSAbJuZL4719AE96s/GWVVPly6prQXTAGxBDfy
         QDaQh/xDLk8Fn5Y9u6crnW5+c4mCCGobV8ZBMu00=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEB8960C48
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 0/6] Support for Qualcomm UFS QMP PHY on SDM845
Date:   Mon, 22 Oct 2018 21:35:55 -0700
Message-Id: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for UFS QMP PHY on SDM845 and the
compatible string for it. This patch series depends on the current
proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
rebased on updated pipe_clk initialization sequence [3]. This series
can only be merged once the dependent patches do.
[1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
[2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
[3] https://patchwork.kernel.org/patch/10376551/

Changes since v9:
- Incorporated review comments from Rob.

Changes since v8:
- Add one new change to support ufs core reset.
- Incorporated review comments from Evan, Vivek.

Changes since v7:
- Add one new change to update UFS PHY power on sequence
- Incorporated review comments from Evan, Vivek and Manu.

Changes since v6:
- Add one new change to clean up some structs and field
- Updates the PHY power control sequence.
- Incorporated review comments from Vivek and Manu.

Changes since v5:
- Updates the PHY power control sequence.
- Updates UFS PHY power on condition check.

Changes since v4:
- Adds 'ref_aux' clock back to SDM845 UFS PHY clock list.
- Power on PHY before serdes configuration starts.
- Updates the UFS PHY initialization sequence.
- Updates a few UFS PHY registers.
- Incorporated review comments from Vivek and Manu.

Changes since v3:
- Incorporated review comments from Vivek and Rob.

Changes since v2:
- Incorporated review comments from Vivek and Rob.
- Remove "ref_aux" from sdm845 ufs phy clock list structure.

Changes since v1:
- Incorporated review comments from Vivek and Manu.
- Update the commit title of patch 2.

Can Guo (5):
  phy: Update PHY power control sequence
  phy: General struct and field cleanup
  phy: Add QMP phy based UFS phy support for sdm845
  scsi: ufs: Power on phy after it is initialized
  dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845

Dov Levenglick (1):
  scsi: ufs: Add core reset support

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 216 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
 drivers/scsi/ufs/ufs-qcom.c                        |  34 +++-
 drivers/scsi/ufs/ufs-qcom.h                        |   1 +
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |  22 +++
 drivers/scsi/ufs/ufshcd.c                          |  13 ++
 drivers/scsi/ufs/ufshcd.h                          |  12 ++
 8 files changed, 296 insertions(+), 21 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


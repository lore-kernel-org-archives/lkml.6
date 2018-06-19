Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC0E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dtYiIfl9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NU1H+Xl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965390AbeFSIhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:37:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937229AbeFSIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:37:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97F5F60714; Tue, 19 Jun 2018 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397420;
        bh=/q1z3Zl2O8+ScyZGea0qzPlLE2B9Q7VRkETsjSVYr28=;
        h=From:To:Cc:Subject:Date:From;
        b=dtYiIfl9p+FJoVd+HrVLEhqbTpnigveCmX8rphQR+t1Z7VhmSsnoSeK4TKXncWPFo
         oIJ328DgUQ4skXqW2JokTXixjQyLNStHICxy9765p/8uaAXJWXLkztgGm2iK/IcTGA
         +Cl/Sxrbn51yDER78un8Pvm9BoJG+E8KLLtvPRcU=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EF9C60227;
        Tue, 19 Jun 2018 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397419;
        bh=/q1z3Zl2O8+ScyZGea0qzPlLE2B9Q7VRkETsjSVYr28=;
        h=From:To:Cc:Subject:Date:From;
        b=NU1H+Xl9pm3iK4LexVbfFhpp2MV0ziiPOjMsR4mPCwQVqD0k017ic6UEChu50IVIj
         pnvAeHYpgjPQrNJcQOttW162dWdTzKme+GnBvC8tBU+/Mxgk6zxgF6ZBSi54twO+H3
         9+0fGvUP3ol78arnC6O8h8ioVXsh8v9/Iu0ybZc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EF9C60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v7 0/4] Support for Qualcomm UFS QMP PHY on SDM845
Date:   Tue, 19 Jun 2018 16:36:43 +0800
Message-Id: <20180619083647.10116-1-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
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

Can Guo (4):
  phy: Update PHY power control sequence
  phy: General struct and field cleanup
  phy: Add QMP phy based UFS phy support for sdm845
  dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 217 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
 3 files changed, 216 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


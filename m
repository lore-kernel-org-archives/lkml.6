Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E899208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fnkbnm+e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j4PLbDJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E899208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeGaLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:49:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGaLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:49:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A526E60397; Tue, 31 Jul 2018 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031766;
        bh=Jc0F//2nuVRvP9gR+qtfLGJB/xw9AcTLMjZX+KwebNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Fnkbnm+edx7nUeSeQ3F7kuDfCP3hvcfid+o36aoWyMEwyRHIkWeozhZKqPIL4lnFU
         aWlN/mQHTTywRbj4K6+geNI4QSNRAZS1Soz/bxXojxY87Uln7T9wEkCj0KoV4q+2mn
         hMQm28Jv5hZgYK9g8TwMZZJLcWLeJ0w2VdEBwAXU=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 983EE60397;
        Tue, 31 Jul 2018 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031765;
        bh=Jc0F//2nuVRvP9gR+qtfLGJB/xw9AcTLMjZX+KwebNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=j4PLbDJmcFH3LkrtgqmqY/xye8DN+etqIXrMJzyzI5c2ispjqj24dCvEDZiJdypEZ
         1CWdhmDIChr+EBOlvq+R7CvR1O8LurMRDNEKJFcjBFge26HIa/ZdygrC4VZU+d+kzy
         CgNg/Jjif7FnYys7Hv1gKaKDa90IRDECG2Xp5W3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 983EE60397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v8 0/5] Support for Qualcomm UFS QMP PHY on SDM845
Date:   Tue, 31 Jul 2018 18:09:09 +0800
Message-Id: <20180731100914.19856-1-cang@codeaurora.org>
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

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 216 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
 drivers/scsi/ufs/ufs-qcom.c                        |   4 +-
 drivers/scsi/ufs/ufs-qcom.h                        |   1 +
 5 files changed, 219 insertions(+), 21 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


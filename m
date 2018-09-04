Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3952AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB60120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MD40LeiA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OVOep1Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB60120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIDOl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:41:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:41:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7ACF06044E; Tue,  4 Sep 2018 10:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056252;
        bh=ybPaYb6viRqHXKsITq3uaIQ4LY8IOiS0SN0fq/Jo8kE=;
        h=From:To:Cc:Subject:Date:From;
        b=MD40LeiAGeh6fro4SQDpqr2behs1oun4jr3JwDRCjzJoz4huUmTxZ8I+FI7bnzD/B
         MRDbbVSoTiwlO3wDFNOcJhsCRW1iP9g8UvEqFAmuD7+Hzf75hC2k48eOTptAPIp5VG
         2TZOM/DeqRftSYwkxF4ZHGA59r9x/CEALfvtiVcI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BB0E6044E;
        Tue,  4 Sep 2018 10:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056251;
        bh=ybPaYb6viRqHXKsITq3uaIQ4LY8IOiS0SN0fq/Jo8kE=;
        h=From:To:Cc:Subject:Date:From;
        b=OVOep1RbCjIqz8gxXHICh9gBxQnp1W4OdK8B/Ka60Cl+PiOwUdThRvhdlNDhv3d4X
         axKpJ0e7Xpdt840w+xB1KUOKXltFcw477V7q9V6rvLoZtksscPmPfH2ygbxUzisNt/
         VIOYUO9eLnsY2OamCZZV6IZq/R/nNyfI4aAyK1X0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BB0E6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     subhashj@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/3] scsi: ufs-qcom: Remove all direct calls to qcom-ufs phy
Date:   Tue,  4 Sep 2018 15:47:16 +0530
Message-Id: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up the ufs-qcom host further to remove all direct calls
into qcom-ufs driver.
Only phy-qcom-ufs-qmp-20nm phy handles these direct calls from ufs host
and this phy is not used in any supported qcom platform in current kernel.
So, while we free up the host from all the ufs_qcom_phy_*() API calls
we should declare 20nm phy as broken.
For this we fork out couple of configs from PHY_QCOM_UFS -
PHY_QCOM_UFS_14NM and PHY_QCOM_UFS_20NM out of which we declare
PHY_QCOM_UFS_20NM as 'broken'.

This series helps in a clean use of ufs phy support for sdm845
and further SoCs that will also use phy-qcom-qmp phy driver.

Vivek Gautam (3):
  phy: qcom-ufs: Remove stale methods that handle ref clk
  scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
  phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as Broken

 drivers/phy/qualcomm/Kconfig          | 17 ++++++++++++
 drivers/phy/qualcomm/Makefile         |  4 +--
 drivers/phy/qualcomm/phy-qcom-ufs-i.h |  2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c   | 50 -----------------------------------
 drivers/scsi/ufs/ufs-qcom.c           | 28 +-------------------
 drivers/scsi/ufs/ufs-qcom.h           |  5 ----
 include/linux/phy/phy-qcom-ufs.h      | 38 --------------------------
 7 files changed, 21 insertions(+), 123 deletions(-)
 delete mode 100644 include/linux/phy/phy-qcom-ufs.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


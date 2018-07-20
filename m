Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0917FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A6020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dCNNaHuC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dCNNaHuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A6020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeGTMm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:42:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeGTMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:42:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B61D460274; Fri, 20 Jul 2018 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532087703;
        bh=RyxZvDTswu7GcidH6b6j60zBpaJdkfBdhHAgy3JKqMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dCNNaHuCgvyv8vngSA1YfHwW2t5E2gh7kRDTt7CMaS/GPZL6bfmY7b5wWnZkt/aWt
         Yp069szIS6UGpEV6MJuJCaZKuVOtpLiAs9vM5bc1Up0+GqFBHBKB1Ml3RTqASOQWrC
         gQE1l4N4COi0o3Luc6Ct/T1WAeGvwdT/OWV04VX0=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6D1F60541;
        Fri, 20 Jul 2018 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532087703;
        bh=RyxZvDTswu7GcidH6b6j60zBpaJdkfBdhHAgy3JKqMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dCNNaHuCgvyv8vngSA1YfHwW2t5E2gh7kRDTt7CMaS/GPZL6bfmY7b5wWnZkt/aWt
         Yp069szIS6UGpEV6MJuJCaZKuVOtpLiAs9vM5bc1Up0+GqFBHBKB1Ml3RTqASOQWrC
         gQE1l4N4COi0o3Luc6Ct/T1WAeGvwdT/OWV04VX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6D1F60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     timur@codeaurora.org, swboyd@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V2] Add SPI driver support for GENI based QUP
Date:   Fri, 20 Jul 2018 17:20:58 +0530
Message-Id: <1532087461-3474-1-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds SPI driver support for GENI based QUP.
Also adding the device tree binding document for reference
as per reviewers request which was merged in Linus tree.

Girish Mahadevan (1):
  spi: spi-geni-qcom: Add SPI driver support for GENI based QUP

 drivers/spi/Kconfig               |  12 +
 drivers/spi/Makefile              |   1 +
 drivers/spi/spi-geni-qcom.c       | 685 ++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-geni-qcom.h |  14 +
 4 files changed, 712 insertions(+)
 create mode 100644 drivers/spi/spi-geni-qcom.c
 create mode 100644 include/linux/spi/spi-geni-qcom.h

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


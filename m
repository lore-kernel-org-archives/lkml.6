Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691072098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ioCpSXI2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Erk05jGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691072098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHBIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:52:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHBIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:52:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 003D560B15; Thu,  2 Aug 2018 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533193392;
        bh=Jjgfyv+dQVVbyiQpmzCw+qM7xLiNSo29TtfRsgLwfE0=;
        h=From:To:Cc:Subject:Date:From;
        b=ioCpSXI2uHC8EoY4SvmSB2HCh23BIf+iih8CLkbu+x+KibKsd5kazXc381LVbHib1
         49X8bfvIACvyfvd7q+MKQws6QBxNudg/QHBLYn2Ohltpvrg3zbTlBztiYghlvflY+o
         SCsaGGB5JBugJ7zfZCkgs4vJ5v6IelEC4U6fmCrU=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B3E86044B;
        Thu,  2 Aug 2018 07:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533193390;
        bh=Jjgfyv+dQVVbyiQpmzCw+qM7xLiNSo29TtfRsgLwfE0=;
        h=From:To:Cc:Subject:Date:From;
        b=Erk05jGXK4x7w8pXPryU2zU1asjiH1bNxcuZNE5hROqxAApPJVtTzct//VG6mmQpH
         NAf7sGfKtn2tExgLFJxtj9s8WHYN26OpPZvWuOQRXa1vrlQG+3OLk311Xk/nHMdYk0
         O1m+BrOiGn32J9KYwkxfGXIxd8sH2wL7+wLXYVkw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B3E86044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, sfr@canb.auug.org.au,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Fix unmet dependency warning for SND_SOC_SDM845
Date:   Thu,  2 Aug 2018 12:32:59 +0530
Message-Id: <1533193379-1125-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DEPENDS_ON QCOM_APR for SND_SOC_SDM845 to fix the
warning: unmet direct dependencies detected for
SND_SOC_QDSP6.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 3507308..5f03312 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -93,6 +93,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
+	depends on QCOM_APR
 	select SND_SOC_QDSP6
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


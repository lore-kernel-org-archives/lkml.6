Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13857C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fFF4U/yG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fOzzwWrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04CD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393358AbeKVTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:45:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:45:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4508560B0D; Thu, 22 Nov 2018 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877624;
        bh=CrJL/NCQIUKGF2EHCfbdvMwRKZWKjAprJDLuL3npHR4=;
        h=From:To:Cc:Subject:Date:From;
        b=fFF4U/yGWVFoNd6sqd2VSrOFMtrcviEg6Yuqz5nVPr0kcb74TdFw7AOpcesYUdr2z
         AStshjKQQOTkIAkM6kwCVKFFCUugjsH16lH7aoYfqPrMSYzgcyDmVYh7SXAdhENeOz
         2i3RRspoTXUhm00XcxcxMFpSSnv57Saorgt4K/DA=
Received: from skolluku-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: skolluku@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE8BF60714;
        Thu, 22 Nov 2018 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542877623;
        bh=CrJL/NCQIUKGF2EHCfbdvMwRKZWKjAprJDLuL3npHR4=;
        h=From:To:Cc:Subject:Date:From;
        b=fOzzwWrjHTzlita3Sp81DhmLHLkhpNsE+Z+eqBGkl28Xbf5CD0XsyZ+Ji1cJUNuVr
         cR5LkQq6SaTxk7KLzQ+Ch/g8rKXcocsru9HOSZE3tp7mBfDzuKgnuZvNw5s4KCpjyZ
         Jmjiou4rqQe6BppsWI2MpK95eUd57IFnFoCzbv48=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE8BF60714
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skolluku@codeaurora.org
From:   Sravanthi Kollukuduru <skolluku@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, sean@poorly.run
Subject: [PATCH v3 0/3] Use interconnect API in MDSS on SDM845
Date:   Thu, 22 Nov 2018 14:36:50 +0530
Message-Id: <20181122090653.3523-1-skolluku@codeaurora.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect API provides an interface for consumer drivers to express
their bandwidth needs in the SoC. This data is aggregated and the on-chip
interconnect hardware is configured to the appropriate power/performance
profile.

MDSS is one of the interconnect consumers which uses the interconnect APIs
to get the path between endpoints and set its bandwidth requirements
for the given interconnected path.

Subsequently, there is a clean up patch to remove all the references
of the DPU custom bus scaling.

There is corresponding DT patch with the source and destination ports
defined for display driver which will be sent separately.

Changes in v2: 
	- Remove error log and unnecessary check (Jordan Crouse)
	- Fixed build error due to partial clean up

Changes in v3:
	- Remove common property definitions (Rob Herring)
	- Code clean up involving variable name change, removal
	  of extra paranthesis and variables (Matthias Kaehlcke)
	- Condense multiple lines into a single line (Sean Paul)

Sravanthi Kollukuduru (3):
  drm/msm/dpu: clean up references of DPU custom bus scaling
  drm/msm/dpu: Integrate interconnect API in MDSS
  dt-bindings: msm/disp: Introduce interconnect bindings for MDSS on
    SDM845

 .../devicetree/bindings/display/msm/dpu.txt        |   9 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      | 174 ++++++++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |  49 +++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c   |  47 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h   |  68 --------
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |  22 +--
 8 files changed, 142 insertions(+), 244 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BCAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACC20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LMwMKOVf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o1P2HAZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfAIRwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:52:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfAIRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:52:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBD2B60397; Wed,  9 Jan 2019 17:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056342;
        bh=wHm97bIlKWLwfY5ZmaBy6hInQMMcr7NNrSHDnsyn9M0=;
        h=From:To:Cc:Subject:Date:From;
        b=LMwMKOVfiYdPNie04x7+d2SVuRi/ogB6zlnx7ksUgEkAM4QddjFWVBSh9dBELHpWF
         1oI4p6l0HlBHHX9XHJlmJqSb+6py6TBPnmifhXB5wsfRCiS8S78WKvuXbFor/TnqGK
         48cRebqpmte8vFxwFOLg9TQGf4e7xLwN8LaIqdQE=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0557060397;
        Wed,  9 Jan 2019 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547056339;
        bh=wHm97bIlKWLwfY5ZmaBy6hInQMMcr7NNrSHDnsyn9M0=;
        h=From:To:Cc:Subject:Date:From;
        b=o1P2HAZa4D5nuHdf48u19pX5A4NGhYTETfPwlTEFQtjh2OPJ03vwoRH1csSl936PA
         RRXgFgM/EM1701Cgkdz71va6VDQMdvI+E0y+cxTY/g8y0iJ8NWFoE6yQ20Zw34Jgy7
         jyOCh63dqgbUR8UGdhtizFSCLyLK9BZDPN+x5MgE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0557060397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: [v5 0/3] Use interconnect API in MDSS on SDM845
Date:   Wed,  9 Jan 2019 23:22:02 +0530
Message-Id: <1547056325-1919-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
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

Changes in v4:
	- Add comments, spacings, tabs, proper port name and icc macro
	- Use port macros and change port string names (Georgi Djakov)

Changes in v5:
	- Updated commit text and parenthesis alignment (Georgi Djakov)

Sravanthi Kollukuduru (3):
  drm/msm/dpu: clean up references of DPU custom bus scaling
  drm/msm/dpu: Integrate interconnect API in MDSS
  dt-bindings: msm/disp: Introduce interconnect bindings for MDSS on
    SDM845

 .../devicetree/bindings/display/msm/dpu.txt        |  10 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      | 174 ++++++++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |  49 +++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c   |  47 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.h   |  68 --------
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |  22 +--
 8 files changed, 144 insertions(+), 243 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


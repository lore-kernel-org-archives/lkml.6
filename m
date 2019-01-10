Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D2CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LlspHK9V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bV5vaAfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfAJD7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:59:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfAJD7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:59:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 59ECD608D4; Thu, 10 Jan 2019 03:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092757;
        bh=0FuryYZjklruzdziuoXE2MTVf+rPH8jOd9Q2fjSPMPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlspHK9V+ZpYTB+UiNxcPbEq2F8vwL4L31mJeVl3BwWxlGxZhSndzyfx5TtW52IU1
         rZtboZb2s+TxC33Lw44iTuH/khtk8rTxT/9B1GjEVgLitbQpleOt5oXNB+qG5w72Zi
         W2oJ851cfkB6ekbuCb9ZnS6C9YWCcK/GbVrTAGcE=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08E286086A;
        Thu, 10 Jan 2019 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092756;
        bh=0FuryYZjklruzdziuoXE2MTVf+rPH8jOd9Q2fjSPMPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bV5vaAfL9DaPkpjlYJ3VwuqP71YrHrNYn03rL0CWT4zdF7uzUiPlKLPJ9dfpJIXwa
         ldHxgh/YkODQqSSQnSkOtJvAylEmhtP02bXHoptck/fRT7NeOD1sf21CJq5iPTHdkQ
         LnFSY1o9t2PbfeynLkcNjSgYt14s6yOfkDoMHcWA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08E286086A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v10 1/9] dt-bindings: opp: Introduce opp-level bindings
Date:   Thu, 10 Jan 2019 09:28:44 +0530
Message-Id: <20190110035852.5666-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110035852.5666-1-rnayak@codeaurora.org>
References: <20190110035852.5666-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (especially from Qualcomm and MediaTek) an OPP
node needs to describe an additional level/corner value
that is then communicated to a remote microprocessor by the CPU, which
then takes some actions (like adjusting voltage values across variousi
rails) based on the value passed.

Add opp-level as an additional property in the OPP node and describe it
in the OPP bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c396c4c0af92..e83fb7cbfd58 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -129,6 +129,11 @@ Optional properties:
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
 
+- opp-level: On some SoC platforms an OPP node can describe a positive value
+  representing a corner/level that's communicated with a remote microprocessor
+  (usually called the power manager) which then translates it into a certain
+  voltage on a voltage rail.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


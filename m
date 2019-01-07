Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA802147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CNa/UFoG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nFe4zjw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfAGKKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:10:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAGKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20F52609D4; Mon,  7 Jan 2019 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855817;
        bh=9zw1nV97nLtoQKZBtBtEAT12fbWhim0zzQLOZHMoGyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNa/UFoGDQIcXvOqDupuB+7Y1AydjMXNVgLRhFsHiixUlRRtrCpISjVhZhdI877mQ
         dsP+palQ+v3KP19OK9j1MgRDsXuvN9UFNqejdWFiFAuM9PyKL7lqB9i7F00OO62qJw
         mYDvSiLU+nwVu141z1m6y0LBt4vG9zv5vUhkknag=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2999560954;
        Mon,  7 Jan 2019 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855815;
        bh=9zw1nV97nLtoQKZBtBtEAT12fbWhim0zzQLOZHMoGyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFe4zjw4tm8hBfSb7dP8FdP+ssYGjtCsurPfymkbl0HZXCsEkto7V1od2XOTRMQe9
         Sux6zvhIDse83/29RKLWYbQCIG3TN0HpN4r8hRz0NfKI3VXFzwc99oxaR+d5eiTEMO
         +04aoBQAAAFKEo7UCNalRz2zALTnTfS06FJBYR38=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2999560954
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 01/10] dt-bindings: opp: Introduce opp-level bindings
Date:   Mon,  7 Jan 2019 15:39:50 +0530
Message-Id: <20190107100959.14528-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107100959.14528-1-rnayak@codeaurora.org>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (especially from Qualcomm and MediaTek) an OPP
node needs to describe an additional level/corner value
that is then communicated to a remote microprocessor by the CPU, which
then takes some actions (like adjusting voltage values across various rails)
based on the value passed.

Describe these bindings in the opp-level bindings document.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/opp/opp-level.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/opp-level.txt

diff --git a/Documentation/devicetree/bindings/opp/opp-level.txt b/Documentation/devicetree/bindings/opp/opp-level.txt
new file mode 100644
index 000000000000..f9134ed08164
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/opp-level.txt
@@ -0,0 +1,29 @@
+OPP level bindings to descibe OPP nodes with corner/level values
+
+OPP tables for devices on some SoCs, especially from Qualcomm and
+MediaTek require an additional platform specific corner/level
+value to be specified.
+This value is passed on to a Power Manager by
+the CPU, which then takes the necessary actions to set a voltage
+rail to an appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt,
+with the exception that all of the properties are now optional,
+including the opp-hz property.
+
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-level"
+
+* OPP Node
+
+Required properties:
+- opp-level: On some SoC platforms an OPP node can describe a positive value
+representing a corner/level that's communicated with a remote microprocessor
+(usually called the power manager) which then translates it into a certain voltage on
+a voltage rail.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


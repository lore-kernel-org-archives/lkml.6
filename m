Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D057D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9me2M/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfANTBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:01:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34290 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:01:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so51863pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jfEV92oU/BXZCP8yvuSufQIujV0ayfJ9QmhGwQnDaWs=;
        b=i9me2M/M9GPc2ytcKjp5DGAMrLOrYSOEqdZ3LWVj1UX6rGhT5oYyEmNJ1m/T5A6miV
         i76A0AnT71KMSSDPmhcfQWIDEb6s7Cp1AaApto+zfrksMSzA03K6eYdMgYR7Dt5DWmad
         gQiSR84r1X1ft0zjkfczl7vk4siLT4eCrHWVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jfEV92oU/BXZCP8yvuSufQIujV0ayfJ9QmhGwQnDaWs=;
        b=osBMYaxLNTH4+CSg2fUzFKwk5FREatmI7dIsZpovZUtXq1S59oY09X4GhVDwuGCCZy
         GuIf7TSIc59mqTTdXsRkiVP0ru4pK9Iah/0UwpPj6eQ7XwPa4qbgDQf3qzKoaXX3hNMA
         iqGSdTHLxJvt5ZCHG1+c3vjfyfQ6HoxP7gme8uCK3SD7P/mQ3a8wQN/WTtovXpSYGCQU
         XR6Z+ZYmOm5IBxXyKO6E2pWArchXz0q27Xm91CPcxZbHKxjRLuCImyHf8+eZaxM5V3XC
         1OUo0+0zVKtOg7y7zt+N4XM3rBB0ckf7/93CBi8sWTDwCf4BHQvgLoL5um37Dr7TKELM
         6mrw==
X-Gm-Message-State: AJcUukciw/ljOFWmvJgwUDV0A44o+2wo8NkVlW5FUpozeIAXDgUvelDi
        yU3R4sK5Gx0Td6X46lPI32wYmA==
X-Google-Smtp-Source: ALg8bN4syLCkq+ZRmkNooexV1p8UgALkw9hQry+SfUJeTX/GhzR6R1mEO6qEX3VLlP+mW1XpUwwxxg==
X-Received: by 2002:a62:c613:: with SMTP id m19mr27038791pfg.207.1547492494475;
        Mon, 14 Jan 2019 11:01:34 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id l85sm1958120pfg.161.2019.01.14.11.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 11:01:33 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-scsi@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Gross <andy.gross@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] arm64: defconfig: Add Qualcomm UFS PHY
Date:   Mon, 14 Jan 2019 11:01:12 -0800
Message-Id: <20190114190112.167922-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 326a859b2814 ("scsi: ufs: Remove select of phy-qcom-ufs from
ufs-qcom"), the Qualcomm UFS controller no longer selects the Qualcomm
UFS phy (since it's not a given that PHY will be the one present).

Add that PHY into the defconfig since it's no longer being selected, and
Qualcomm platforms except for SDM845 need it.

Fixes: 326a859b2814 ("scsi: ufs: Remove select of phy-qcom-ufs from ufs-qcom")
Signed-off-by: Evan Green <evgreen@chromium.org>
---
I unfortunately don't have a non-SDM845 device to test this on. I'm hoping
it Just Works, or someone might be willing to give it a try.

Also, Martin, I'm not sure if your git commit IDs are stable, or whether or
not I should put the Fixes: in there. If they're not, this could be reordered
with the other commit and then there wouldn't need to be a Fixes. Let me know.

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0478ef9e4b78e..d43644ca75997 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -694,6 +694,8 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_QMP=m
+CONFIG_PHY_QCOM_UFS=m
+CONFIG_PHY_QCOM_UFS_14NM=m
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.18.1


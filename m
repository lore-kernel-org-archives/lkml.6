Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E3C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4931920818
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBDRnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:43:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47677 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfBDRnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:43:23 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2646C13F8C8;
        Mon,  4 Feb 2019 18:43:05 +0100 (CET)
To:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v3 0/5] UFS on APQ8098/MSM8998
Message-ID: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
Date:   Mon, 4 Feb 2019 18:34:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is now good enough for the limelight, IMO.

Difference between, v2 and v3:
- Add qcom,msm8998-qmp-ufs-phy compat string and match it in the PHY driver
- Drop vdd-hba-fixed-regulator
- Write the reg addresses with full 32-bit width
- Set regulator-allow-set-load only on the 3 rails used by UFS.
- Revert the patch introducing ufshcd_set_vccq_rail_unused

Difference between v1 and v2:
- New patch to add 'regulator-allow-set-load' prop to all vreg nodes
- Rename rpmcc node to 'clock-controller' + Add Review tags
- Drop UFS pinctrl gymnastics (not required, probably left enabled in bootloader)
- Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
- Fix sizes of ufsphy register areas based on Jeffrey's feedback
- Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + reboot

Marc Gonzalez (5):
  arm64: dts: qcom: msm8998: Add UFS nodes
  arm64: dts: qcom: msm8998: Allow drivers to set-load
  dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-ufs-phy
  phy: qcom-qmp: Add QMP UFS PHY support for msm8998
  Revert "scsi: ufs: disable vccq if it's not needed by UFS device"

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |  1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 +++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 63 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c           |  3 +
 drivers/scsi/ufs/ufs.h                        |  1 -
 drivers/scsi/ufs/ufshcd.c                     | 59 ++---------------
 6 files changed, 93 insertions(+), 56 deletions(-)

-- 
2.17.1

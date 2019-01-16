Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7542C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA2720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392279AbfAPLBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:01:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:23960 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731772AbfAPLBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:01:19 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id CDA2F13F8E8;
        Wed, 16 Jan 2019 12:01:06 +0100 (CET)
To:     MSM <linux-arm-msm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [RFC PATCH v2 0/4] UFS on APQ8098
Message-ID: <88e04336-723f-c157-0384-c5054a73e0a4@free.fr>
Date:   Wed, 16 Jan 2019 11:50:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After weeks (literally!) of poking the system at random, Jeffrey found why UFS
refused to work on APQ8098: we were not setting the load on the vregs.

Difference between v1 and v2:
- New patch to add 'regulator-allow-set-load' prop to all vreg nodes
- Rename rpmcc node to 'clock-controller' + Add Review tags
- Drop UFS pinctrl gymnastics (not required, probably left enabled in bootloader)
- Delete GCC_UFS_ICE_CORE_CLK (ICE not used upstream, I think)
- Fix sizes of ufsphy register areas based on Jeffrey's feedback
- Hack ufshcd_set_vccq_rail_unused into a NOP to work around lock up + reboot


Marc Gonzalez (4):
  arm64: dts: qcom: msm8998: Add rpmcc node
  arm64: dts: qcom: msm8998: Add UFS nodes
  Add regulator-allow-set-load
  ufshcd_set_vccq_rail_unused locks up the board

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 52 +++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 69 +++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                 |  1 +
 3 files changed, 122 insertions(+)

-- 
2.17.1

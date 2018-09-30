Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE5C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2E20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+A0Tkd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A2E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeJABMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:12:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:32782 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeJABMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:12:17 -0400
Received: by mail-yb1-f194.google.com with SMTP id u88-v6so415929ybi.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lhxg0Wty1FLqZKr/TCLAd0dBs1+mJbyQ0l+4sGgov1w=;
        b=V+A0Tkd/0LNS85aw2Bb/FfC7+5xJXni6wtPU85/E9Mp0L/V4EeG5SBLlm9k3JeNuRl
         63E8pUVF4QrOl+bZqoW7nryNBihGBaj4MpsBF0Hwp/Ql437Dbvz6Wpt+J/mVvWeggUmN
         vMJzSPWp3aUdtUXZ/ubjxQ2egEcnGI/qVaoMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lhxg0Wty1FLqZKr/TCLAd0dBs1+mJbyQ0l+4sGgov1w=;
        b=QDgUU3pZDo1trTuhnuX7VUCVRgq0c+MSyU+MS+Upt4Cv77yfovTXMSMEMLeSpOOoJC
         gxIrzU+MS7ROhL9WVVnaeWPQSbjZ21p83Ot4gppHj9y/rVwv/axoEXLS7b1NgrDCkk7G
         Q2MRCoK8Qz3kMQSD6GCYFFimBPa/ml77piwiK1j/FrmvZpBiRTIshVLIc+HW9R/4Xh9z
         0p1wC+IENeyOdEXppJuQVbSLUbEsB9Y+AW4V5QzimdmqnVdWz7hbc1ASi++DuBytSD6+
         wW5BcLcVvhEsAJxSlkK42eRyXT3JYnx34av6h8X8Z3llE1vtUByiRd44vMfW3VbV7jEx
         ND0A==
X-Gm-Message-State: ABuFfohUMOKZ2fO6unyCjo1ZTwKHJZi/Xo6QKFNlDMPvtsTNvQStsuOk
        0wu6QhEwUzGWoQm+vyXK4xcerA==
X-Google-Smtp-Source: ACcGV63FYs5PizZu2XNnEZ9MDYC0X9AUSxCc+WAWSTmM/RJEh1T6r7KNpfTIPwY/iVQXbyBXWVdwGg==
X-Received: by 2002:a25:b2a8:: with SMTP id k40-v6mr4174984ybj.497.1538332689328;
        Sun, 30 Sep 2018 11:38:09 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id w201-v6sm1814235ywa.79.2018.09.30.11.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 11:38:08 -0700 (PDT)
From:   Andy Gross <andy.gross@linaro.org>
To:     arm@kernel.org
Cc:     Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [GIT PULL] Qualcomm Driver updates for 4.20
Date:   Sun, 30 Sep 2018 13:38:01 -0500
Message-Id: <1538332682-12018-4-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
References: <1538332682-12018-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.20

for you to fetch changes up to 579fde69dc1467a033ff44ced75ff368b9d3d072:

  Merge branch 'drivers-for-4.20' into drivers-for-4.20-final (2018-09-30 12:44:33 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.20

* Refactor of SCM compatibles and clock requirements
* SMEM cleanup
* Add LLCC EDAC driver
* Fixes for GENI clocks and macros
* Fix includes for llcc-slice and smem
* String overflow fixes for APR and wcnss_ctrl
* Fixup for COMPILE_TEST of qcom driver Kconfigs
* Cleanup of Kconfig depends of rpmh, smd_rpm, smsm, and smp2p
* Add SCM dependencies to SPM and rmtfs-mem

----------------------------------------------------------------
Alex Elder (12):
      soc: qcom: smem: rename variable in qcom_smem_get_global()
      soc: qcom: smem: initialize region struct only when successful
      soc: qcom: smem: always ignore partitions with 0 offset or size
      soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
      soc: qcom: smem: verify both host ids in partition header
      soc: qcom: smem: require order of host ids to match
      soc: qcom: smem: introduce qcom_smem_partition_header()
      soc: qcom: smem: verify partition header size
      soc: qcom: smem: verify partition offset_free_uncached
      soc: qcom: smem: small change in global entry loop
      soc: qcom: smem: verify partition host ids match
      soc: qcom: smem: a few last cleanups

Andy Gross (2):
      Merge tag 'qcom-geni-immutable-for-mark-brown' into drivers-for-4.20-final
      Merge branch 'drivers-for-4.20' into drivers-for-4.20-final

Bjorn Andersson (4):
      soc: qcom: rmtfs-mem: Validate that scm is available
      dt-bindings: firmware: scm: Refactor compatibles and clocks
      firmware: qcom: scm: Refactor clock handling
      dt-bindings: firmware: scm: Add MSM8998 and SDM845

Channagoud Kadabi (1):
      drivers: edac: Add EDAC driver support for QCOM SoCs

Colin Ian King (1):
      soc: qcom: apr: fix spelling mistake: "paket" -> "packet"

Douglas Anderson (4):
      soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_tbl_get()
      soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples
      soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_tbl_get()
      soc: qcom: geni: geni_se_clk_freq_match() should always accept multiples

Felix Fietkau (1):
      soc: qcom: spm: add SCM probe dependency

Lina Iyer (1):
      drivers: qcom: rpmh-rsc: clear wait_for_compl after use

Niklas Cassel (9):
      soc: qcom: smem: Add missing include of sizes.h
      soc: qcom: llcc-slice: Add missing include of sizes.h
      soc: qcom: smp2p: Add select IRQ_DOMAIN
      soc: qcom: smsm: Add select IRQ_DOMAIN
      soc: qcom: Remove bogus depends on OF from QCOM_SMD_RPM
      soc: qcom: Remove depends on OF from QCOM_RPMH
      soc: qcom: wcnss_ctrl: Avoid string overflow
      soc: qcom: apr: Avoid string overflow
      soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs

Stephen Boyd (2):
      soc: qcom: geni: Make version macros simpler
      soc: qcom: geni: Make version macros simpler

Venkata Narendra Kumar Gutta (3):
      soc: qcom: Add broadcast base for Last Level Cache Controller (LLCC)
      soc: qcom: Add support to register LLCC EDAC driver
      dt-bindings: msm: Update documentation of qcom,llcc

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  19 +-
 .../devicetree/bindings/firmware/qcom,scm.txt      |  33 +-
 MAINTAINERS                                        |   8 +
 drivers/edac/Kconfig                               |  14 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/qcom_edac.c                           | 414 +++++++++++++++++++++
 drivers/firmware/qcom_scm.c                        |  74 ++--
 drivers/soc/qcom/Kconfig                           |  21 +-
 drivers/soc/qcom/apr.c                             |   6 +-
 drivers/soc/qcom/llcc-slice.c                      |  74 ++--
 drivers/soc/qcom/qcom-geni-se.c                    |  41 +-
 drivers/soc/qcom/rmtfs_mem.c                       |   5 +
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +
 drivers/soc/qcom/smem.c                            | 174 +++++----
 drivers/soc/qcom/spm.c                             |   3 +
 drivers/soc/qcom/wcnss_ctrl.c                      |   2 +-
 include/linux/qcom-geni-se.h                       |  13 +-
 include/linux/soc/qcom/llcc-qcom.h                 |  30 +-
 18 files changed, 732 insertions(+), 202 deletions(-)
 create mode 100644 drivers/edac/qcom_edac.c

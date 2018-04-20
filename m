Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbeDTMPq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:15:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:15:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE29B606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From: Vijay Viswanath <vviswana@codeaurora.org>
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org,
        pramod.gurav@linaro.org, jeremymc@redhat.com, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org
Subject: [PATCH V5 0/2] mmc: sdhci-msm: Configuring IO_PAD support for sdhci-msm
Date: Fri, 20 Apr 2018 17:45:27 +0530
Message-Id: <1524226529-30100-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From the HPG:
In some platform, SDCC controller can be connected to either an eMMC device or
an SD card. The PADs for SD card are dual-voltage that support 3v/1.8v. Those
PADs have a control signal  (io_pad_pwr_switch/mode18 ) that indicates whether
the PAD works in 3v or 1.8v.

For SD usage the default value of this signal is ‘0’, and SD driver changes it
to ‘1’ as a part of voltage switching sequence.
For eMMC usage, SW should configure this signal to ‘1’ and supply 1.8v to PADs
before starting any activity on the eMMC BUS.

To set this signal, write the following in the
SDC1_SDCC_HC_VENDOR_SPECIFIC_FUNC register:
	HC_IO_PAD_PWR_SWITCH: bit 16
		HC_IO_PAD_PWR_SWITCH_EN: bit 15

Changes since v1:
	Modified comments on io_pad related changes.
	Split some read+modify+write commands to multiple lines

Changes since v2:
	IO_PAD_PWR_SWITCH_EN will be set only if we have info regarding what
	voltage is supported by the regulators.
	Replaced regulator_list_voltage() API with
	regulator_is_supported_voltage().

Changes since v3:
	Removed unnecessary prints and extra lines.

Changes since v4:
	Removed unnecessary mb() within sdhci_msm_handle_pwr_irq() since
	wakeup calls have implicit write barriers.

Krishna Konda (1):
  mmc: sdhci-msm: support voltage pad switching

Vijay Viswanath (1):
  mmc: sdhci-msm: Add support to store supported vdd-io voltages

 drivers/mmc/host/sdhci-msm.c | 99 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

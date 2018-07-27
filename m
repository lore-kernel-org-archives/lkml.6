Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F23DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4635208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4635208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bgodavar-linux.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbeG0P50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:57:26 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:32295 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730561AbeG0P50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:57:26 -0400
X-IronPort-AV: E=Sophos;i="5.51,409,1526322600"; 
   d="scan'208";a="115112"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Jul 2018 19:43:25 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8966"; a="828475"
Received: from bgodavar-linux.qualcomm.com ([10.206.64.85])
  by ironmsg04-blr.qualcomm.com with ESMTP; 27 Jul 2018 19:43:25 +0530
Received: by bgodavar-linux.qualcomm.com (Postfix, from userid 2304065)
        id 36B043C26; Fri, 27 Jul 2018 19:43:23 +0530 (IST)
From:   Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
Subject: [PATCH v11 0/7] Enable Bluetooth functionality for WCN3990 
Date:   Fri, 27 Jul 2018 19:43:13 +0530
Message-Id: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These patches enables Bluetooth functinalties for new Qualcomm
Bluetooth chip wnc3990. As this is latest chip with new features, 
along with some common features to old chip "qcom,qca6174-bt".
we have updated names of functions that are used for both the chips 
to keep this generic and would help in future when we would have new 
BT SoC.

The below are difference between new and old chips.

*Power:
 *New chip: we use voltage regulators to turn on/off the chip and we 
  must send a command on Tx line to turn on/off the chip completely.
 *Old chip: We turn on/off by setting a GPIO.

 *Note: Turning on sequence differs between two chips.

*Firmware download:
  Only firmware file name differ from New and Old chip.
  
  So we reused some functions/structure/variables which are used for old 
  chip to New chip by generic naming (may be future chips may use same functions).

 * As we have multiple changes for functions names,we have tested these patches 
   on both chips.

v11:
 * removed regulator current from dtbindings
 * addressed review comments.

v10:
 * update current load with actual values of WCN3990.
 * added support  for itterative connect with BT chip if it fails to respond to the HOST.
 * Added regulator current dtbindings.
 * addressed review comments.

v9:
 * removed smps regs.
 * hidded flow control in respective functions.
 * moved qca_soc_ver to qca_setup
 * addressed review comments.
 
v8:
  * Squashed [v7 2/8] and [v7 3/8] to one patch.
  * updated functions to set and get the UART speeds.
  * addressed review comments.

v7:
  * Renamed all the possible function of ROME to generic.
  * updated with review comments for hci_qca and btqca
  * fixed kbuild errors.
  * created wrapper functions for re-usable blocks.
 
v6:
  * Hooked up qca_power to qca_serdev.
  * renamed all the naming inconsistency functions with qca_*
  * leveraged common code of ROME for wcn3990.
  * created wrapper functions for re-usable blocks.
  * updated function of _*regulator_enable and _*regualtor_disable.  
  * removed redundant comments and functions.
  * add code to derive the firmware files based on ROM Version.
  * created new patch for common function of ROME and wcn3990.
  * enables Qualcomm chip to operate at 3.2Mbps.
  * updated names of functions that are used for both the chips to keep this generic. 

v5:
  * updated with review comments for hci_qca and btqca
 
v4:
  * rebased all changes on top of bluetooth-next.
  * addressed review comments.
  * New patch created for firmware download.

v3:
  * Rebased all changes on top of bluetooth-next.
  * dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
    - added dt-binding snippet for bluetooth chip wcn3990.
  * Bluetooth: Add support for wcn3990 soc.
    - updated BT_INFO with bt_dev_info, where ever necessary.

v2:
   * Add support for wcn3990:
    These changes are aligned as per serdev frame work.
          We implemented these changes on top of https://patchwork.kernel.org/patch/10316093/
        As this patch enable serdev for one of the Qualcomm BT chip.

        The changes in the patch include.
        - Adding support to voting up/down regulators for WCN3990.
           - Bluetooth firmware download for wcn3990.

  * Add device tree bindings for Atheros chips:
          These changes are on top of https://patchwork.kernel.org/patch/10316097/.
          - Description of device tree bindings.


Balakrishna Godavarthi (7):
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990
  Bluetooth: btqca: Rename ROME specific functions to generic functions
  Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
  Bluetooth: hci_qca: Add wrapper functions for setting UART speed
  Bluetooth: hci_qca: Enable 3.2 Mbps operating speed.
  Bluetooth: btqca: Add wcn3990 firmware download support.
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990

 .../bindings/net/qualcomm-bluetooth.txt       |  26 +-
 drivers/bluetooth/btqca.c                     | 119 +++--
 drivers/bluetooth/btqca.h                     |  22 +-
 drivers/bluetooth/hci_qca.c                   | 505 ++++++++++++++++--
 4 files changed, 556 insertions(+), 116 deletions(-)

-- 
2.17.1


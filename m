Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424823AbeE1LT5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424673AbeE1LQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:16:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filip Sadowski <filip.sadowski@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 265/272] i40e: Add delay after EMP reset for firmware to recover
Date: Mon, 28 May 2018 12:04:58 +0200
Message-Id: <20180528100302.414294391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filip Sadowski <filip.sadowski@intel.com>

[ Upstream commit 1fa51a650e1deb50410677f1bd6c0ce17aa48a49 ]

This patch adds necessary delay for 4.33 firmware to recover after
EMP reset. Without this patch driver occasionally reinitializes
structures too quickly to communicate with firmware after EMP reset
causing AdminQ to timeout.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9215,6 +9215,17 @@ static void i40e_rebuild(struct i40e_pf
 	}
 	i40e_get_oem_version(&pf->hw);
 
+	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
+	    ((hw->aq.fw_maj_ver == 4 && hw->aq.fw_min_ver <= 33) ||
+	     hw->aq.fw_maj_ver < 4) && hw->mac.type == I40E_MAC_XL710) {
+		/* The following delay is necessary for 4.33 firmware and older
+		 * to recover after EMP reset. 200 ms should suffice but we
+		 * put here 300 ms to be sure that FW is ready to operate
+		 * after reset.
+		 */
+		mdelay(300);
+	}
+
 	/* re-verify the eeprom if we just had an EMP reset */
 	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state))
 		i40e_verify_eeprom(pf);

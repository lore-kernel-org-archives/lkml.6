Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mai1dcvNu7FJkfQNgoINnwoosJrVw9CgNAxMLr3RZWCHMO2Ag0Hd5kpbbJbua/+rQ9zC7
ARC-Seal: i=1; a=rsa-sha256; t=1524406230; cv=none;
        d=google.com; s=arc-20160816;
        b=l3apcS4bXjqM9r6N9H8T9NXdIaO/YhLx5Dj6EsInrJ7JGvLfBzOxw2KNR5GyQJPVr+
         eWMSRO2o9Q+fmuia4YvnUerDGtFk3Q11D7WuSwN4IMLaa7pjq6ew/yr46HDw577HTMky
         yTgusgIul1x8ldy5VqwryFfOAIEuhCs+RTbdWdu8LyiH2kvWzxNYl6mqqp/5oWx100+O
         Nm93dC2iIMoXMhEVptKbv/anT61m1VDpRL+uUTGQICMI1hwTdeK1PgQDbSj6xkkTIVbj
         +mO/6DL1TZ2kRhuCvdkVTn0AlVw7SekOJcC4BUufFAY4a/oVfJVrCFvODny/1hlIn4Oc
         4gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CJDduh2dQovAY09eLhylnSm6V9djt0zsuGcME9j6Lls=;
        b=Rl37u7Ossr2PyM0beis5/95PHPM260uzYEtQ6NBAT9SDZ61R4F2TkDj/yNF087qFjS
         3tmjY/u8sQHaN7txGKk7WInXtcBw7mkYbuWa4GIGG5cspqD6vVt1o3zRXbN0MPqJwsEx
         mgf+36ewWGHjhl5enX65jVDD+5KiKxqsymq8WNulIPKswYWsviWytW4d6rGYvjLQNZdt
         GKjuJ+LFVtg36QWKZ5a5rYSfot8c+JlUp/bJGNrrVshBVEZDXt62LQS9JzPvaAPfXvjg
         9wwTQ7Vc3IuKlkAZgV/p5QNqa+4a6NEfPBD9qlnQAog+U/xuluuXRz1fy8Lv9g2jkm3v
         +whA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.14 160/164] iwlwifi: add shared clock PHY config flag for some devices
Date: Sun, 22 Apr 2018 15:53:47 +0200
Message-Id: <20180422135142.158483320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455787774060366?=
X-GMAIL-MSGID: =?utf-8?q?1598455787774060366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>

commit 86a2b2043af79deff5cf000c5a08847faa4f2ee0 upstream.

Some devices use a shared clock which is very sensitive to variations
and cause trouble in some situations.  We need to set a bit in the phy
configuration to indicate that to the FW.  To make this generic, add a
extra_phy_config_flags element to the device configuration and OR it
into the phy_cfg before sending it to the firmware.  And also create a
set of configurations for devices that use shared clocks and need this
extra bit to be set.

Fixes: c62446d2b028 ("iwlwifi: add new 9460 series PCI IDs")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   |   62 ++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h    |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     |    4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |   38 +++++++-------
 5 files changed, 91 insertions(+), 19 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -53,6 +53,7 @@
 #include <linux/stringify.h>
 #include "iwl-config.h"
 #include "iwl-agn-hw.h"
+#include "fw/file.h"
 
 /* Highest firmware API version supported */
 #define IWL9000_UCODE_API_MAX	34
@@ -264,6 +265,67 @@ const struct iwl_cfg iwl9560_2ac_cfg_soc
 	.integrated = true,
 	.soc_latency = 5000,
 };
+
+const struct iwl_cfg iwl9460_2ac_cfg_shared_clk = {
+	.name = "Intel(R) Dual Band Wireless AC 9460",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
+const struct iwl_cfg iwl9461_2ac_cfg_shared_clk = {
+	.name = "Intel(R) Dual Band Wireless AC 9461",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
+const struct iwl_cfg iwl9462_2ac_cfg_shared_clk = {
+	.name = "Intel(R) Dual Band Wireless AC 9462",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
+const struct iwl_cfg iwl9560_2ac_cfg_shared_clk = {
+	.name = "Intel(R) Dual Band Wireless AC 9560",
+	.fw_name_pre = IWL9000A_FW_PRE,
+	.fw_name_pre_b_or_c_step = IWL9000B_FW_PRE,
+	.fw_name_pre_rf_next_step = IWL9000RFB_FW_PRE,
+	IWL_DEVICE_9000,
+	.ht_params = &iwl9000_ht_params,
+	.nvm_ver = IWL9000_NVM_VERSION,
+	.nvm_calib_ver = IWL9000_TX_POWER_VERSION,
+	.max_ht_ampdu_exponent = IEEE80211_HT_MAX_AMPDU_64K,
+	.integrated = true,
+	.soc_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
+};
+
 MODULE_FIRMWARE(IWL9000A_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL9000B_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL9000RFB_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -434,6 +434,7 @@ enum iwl_fw_phy_cfg {
 	FW_PHY_CFG_TX_CHAIN = 0xf << FW_PHY_CFG_TX_CHAIN_POS,
 	FW_PHY_CFG_RX_CHAIN_POS = 20,
 	FW_PHY_CFG_RX_CHAIN = 0xf << FW_PHY_CFG_RX_CHAIN_POS,
+	FW_PHY_CFG_SHARED_CLK = BIT(31),
 };
 
 #define IWL_UCODE_MAX_CS		1
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -394,6 +394,7 @@ struct iwl_cfg {
 	u8 max_vht_ampdu_exponent;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
+	u32 extra_phy_cfg_flags;
 };
 
 /*
@@ -476,6 +477,10 @@ extern const struct iwl_cfg iwl9460_2ac_
 extern const struct iwl_cfg iwl9461_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9462_2ac_cfg_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
+extern const struct iwl_cfg iwl9460_2ac_cfg_shared_clk;
+extern const struct iwl_cfg iwl9461_2ac_cfg_shared_clk;
+extern const struct iwl_cfg iwl9462_2ac_cfg_shared_clk;
+extern const struct iwl_cfg iwl9560_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwla000_2ac_cfg_hr;
 extern const struct iwl_cfg iwla000_2ac_cfg_hr_cdb;
 extern const struct iwl_cfg iwla000_2ac_cfg_jf;
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -435,6 +435,10 @@ static int iwl_send_phy_cfg_cmd(struct i
 
 	/* Set parameters */
 	phy_cfg_cmd.phy_cfg = cpu_to_le32(iwl_mvm_get_phy_config(mvm));
+
+	/* set flags extra PHY configuration flags from the device's cfg */
+	phy_cfg_cmd.phy_cfg |= cpu_to_le32(mvm->cfg->extra_phy_cfg_flags);
+
 	phy_cfg_cmd.calib_control.event_trigger =
 		mvm->fw->default_calib[ucode_type].event_trigger;
 	phy_cfg_cmd.calib_control.flow_trigger =
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -577,25 +577,25 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x30DC, 0x0264, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A0, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x30DC, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x003C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0060, iwl9460_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0064, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x00A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x00A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0230, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0234, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0238, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x023C, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0260, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0264, iwl9461_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x02A0, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x02A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x4030, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x4034, iwl9560_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x31DC, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x003C, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0060, iwl9460_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0064, iwl9461_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x00A0, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x00A4, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0230, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0234, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0238, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x023C, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0260, iwl9461_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x0264, iwl9461_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x02A0, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x02A4, iwl9462_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x4030, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x4034, iwl9560_2ac_cfg_shared_clk)},
+	{IWL_PCI_DEVICE(0x31DC, 0x40A4, iwl9462_2ac_cfg_shared_clk)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0030, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0034, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x34F0, 0x02A4, iwl9462_2ac_cfg_soc)},

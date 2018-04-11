Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+xwo0YBt+Q7JseNNACGHx9JcjenWPHwQ/sIjVX7Ih9+zwxDSPBiK7zergLrrvnZtf9j9e9
ARC-Seal: i=1; a=rsa-sha256; t=1523473300; cv=none;
        d=google.com; s=arc-20160816;
        b=E3SKLZoEoPe/B9UZ7cNiuiVKikcGaEs/ruBjP9ie201bjEqxrMo+2472LepxeGyGZe
         rO3cYVDmK03u7YEEyFzUojKDRfj1swxhPWSV/Rh3N/L+ELV+rd6wy2TGMhguT4VhV7ZV
         E3UqgVwoO9VsTVkXA84xsg0h+4aQkGxMW71o3RyiRzmtmKUY3T/qQpCU0TWkhgFMh/iY
         rggXEC4YW+g90bU9xDrxJ0WmgdKY5zH2Y0MLEe4iiZUPEGY7ete15HEiGmhzL8SO8WKa
         fbSTBtrko02dvQtd8cFBLKRE8PR8Ps2l1Bya/x8u/WEwh4fTrILX5iiPrkFHDH2MZfbk
         DgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4fOjIxxyiI8bTRNI4nLnEqGLy+MpDnVBWyrvAMuMsoo=;
        b=DpOTl415XO/mJiVPPChn8mEbLKElyy5QWL3JgB52AGP2v+NMWTzwzqT+ZM9Qar4pIf
         seUXiPPUpqmfVDWXyQ2k37XbxiZ4V2qydbhI1xfuxm285lAe/Gew7sgVUHrZ+TLuA2rX
         1nwrqjx+lIusFva7ZCbwVI81h8pXeGCC9sEcj4ZN78fuOWeZBuE68ljEPLI96bYpXGCA
         sxi+plBRRVpzzHta5GJYp7l2SgELekf2F8FSviABHkQWJ8P4wwKNmHvf0d/bxCLzbZGj
         Pe61wfW1xxCB1b/fiYmePJs6WKhYfxRpTGYGn/wU1dS2MgTzdUXmHy6tLYv6rRSUYQL5
         l7aA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 197/310] iwlwifi: mvm: fix firmware debug restart recording
Date: Wed, 11 Apr 2018 20:35:36 +0200
Message-Id: <20180411183631.073377661@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477538995146827?=
X-GMAIL-MSGID: =?utf-8?q?1597477538995146827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit addce854f164a68da9cb158e2e7e447705068549 ]

When we want to stop the recording of the firmware debug
and restart it later without reloading the firmware we
don't need to resend the configuration that comes with
host commands.
Sending those commands confused the hardware and led to
an NMI 0x66.

Change the flow as following:
* read the relevant registers (DBGC_IN_SAMPLE, DBGC_OUT_CTRL)
* clear those registers
* wait for the hardware to complete its write to the buffer
* get the data
* restore the value of those registers (to restart the
  recording)

For early start (where the configuration is already
compiled in the firmware), we don't need to set those
registers after the firmware has been loaded, but only
when we want to restart the recording without having
restarted the firmware.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h   |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c |   12 ---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    |   32 ++++++++++++++++++------
 4 files changed, 27 insertions(+), 19 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -369,6 +369,7 @@
 #define MON_DMARB_RD_DATA_ADDR		(0xa03c5c)
 
 #define DBGC_IN_SAMPLE			(0xa03c00)
+#define DBGC_OUT_CTRL			(0xa03c0c)
 
 /* enable the ID buf for read */
 #define WFPM_PS_CTL_CLR			0xA0300C
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c
@@ -914,14 +914,6 @@ int iwl_mvm_fw_dbg_collect_trig(struct i
 	return 0;
 }
 
-static inline void iwl_mvm_restart_early_start(struct iwl_mvm *mvm)
-{
-	if (mvm->cfg->device_family == IWL_DEVICE_FAMILY_7000)
-		iwl_clear_bits_prph(mvm->trans, MON_BUFF_SAMPLE_CTL, 0x100);
-	else
-		iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, 1);
-}
-
 int iwl_mvm_start_fw_dbg_conf(struct iwl_mvm *mvm, u8 conf_id)
 {
 	u8 *ptr;
@@ -935,10 +927,8 @@ int iwl_mvm_start_fw_dbg_conf(struct iwl
 	/* EARLY START - firmware's configuration is hard coded */
 	if ((!mvm->fw->dbg_conf_tlv[conf_id] ||
 	     !mvm->fw->dbg_conf_tlv[conf_id]->num_of_hcmds) &&
-	    conf_id == FW_DBG_START_FROM_ALIVE) {
-		iwl_mvm_restart_early_start(mvm);
+	    conf_id == FW_DBG_START_FROM_ALIVE)
 		return 0;
-	}
 
 	if (!mvm->fw->dbg_conf_tlv[conf_id])
 		return -EINVAL;
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1687,6 +1687,7 @@ void iwl_mvm_enable_ac_txq(struct iwl_mv
 static inline void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 {
 	mvm->ucode_loaded = false;
+	mvm->fw_dbg_conf = FW_DBG_INVALID;
 	iwl_trans_stop_device(mvm->trans);
 }
 
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1118,21 +1118,37 @@ static void iwl_mvm_fw_error_dump_wk(str
 
 	mutex_lock(&mvm->mutex);
 
-	/* stop recording */
 	if (mvm->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+		/* stop recording */
 		iwl_set_bits_prph(mvm->trans, MON_BUFF_SAMPLE_CTL, 0x100);
+
+		iwl_mvm_fw_error_dump(mvm);
+
+		/* start recording again if the firmware is not crashed */
+		if (!test_bit(STATUS_FW_ERROR, &mvm->trans->status) &&
+		    mvm->fw->dbg_dest_tlv)
+			iwl_clear_bits_prph(mvm->trans,
+					    MON_BUFF_SAMPLE_CTL, 0x100);
 	} else {
+		u32 in_sample = iwl_read_prph(mvm->trans, DBGC_IN_SAMPLE);
+		u32 out_ctrl = iwl_read_prph(mvm->trans, DBGC_OUT_CTRL);
+
+		/* stop recording */
 		iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, 0);
-		/* wait before we collect the data till the DBGC stop */
 		udelay(100);
-	}
+		iwl_write_prph(mvm->trans, DBGC_OUT_CTRL, 0);
+		/* wait before we collect the data till the DBGC stop */
+		udelay(500);
 
-	iwl_mvm_fw_error_dump(mvm);
+		iwl_mvm_fw_error_dump(mvm);
 
-	/* start recording again if the firmware is not crashed */
-	WARN_ON_ONCE((!test_bit(STATUS_FW_ERROR, &mvm->trans->status)) &&
-		     mvm->fw->dbg_dest_tlv &&
-		     iwl_mvm_start_fw_dbg_conf(mvm, mvm->fw_dbg_conf));
+		/* start recording again if the firmware is not crashed */
+		if (!test_bit(STATUS_FW_ERROR, &mvm->trans->status) &&
+		    mvm->fw->dbg_dest_tlv) {
+			iwl_write_prph(mvm->trans, DBGC_IN_SAMPLE, in_sample);
+			iwl_write_prph(mvm->trans, DBGC_OUT_CTRL, out_ctrl);
+		}
+	}
 
 	mutex_unlock(&mvm->mutex);
 

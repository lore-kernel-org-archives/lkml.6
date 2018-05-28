Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165242AbeE1NQL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163635AbeE1KuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 201/496] iwlwifi: mvm: fix TX of CCMP 256
Date: Mon, 28 May 2018 11:59:46 +0200
Message-Id: <20180528100328.404461495@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit de04d4fbf87b769ab18c480e4f020c53e74bbdd2 ]

We don't have enough room in the TX command for a CCMP 256
key, and need to use key from table.

Fixes: 3264bf032bd9 ("[BUGFIX] iwlwifi: mvm: Fix CCMP IV setting")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -419,11 +419,11 @@ static void iwl_mvm_set_tx_cmd_crypto(st
 {
 	struct ieee80211_key_conf *keyconf = info->control.hw_key;
 	u8 *crypto_hdr = skb_frag->data + hdrlen;
+	enum iwl_tx_cmd_sec_ctrl type = TX_CMD_SEC_CCM;
 	u64 pn;
 
 	switch (keyconf->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_CCMP_256:
 		iwl_mvm_set_tx_cmd_ccmp(info, tx_cmd);
 		iwl_mvm_set_tx_cmd_pn(info, crypto_hdr);
 		break;
@@ -447,13 +447,16 @@ static void iwl_mvm_set_tx_cmd_crypto(st
 		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
+		type = TX_CMD_SEC_GCMP;
+		/* Fall through */
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		/* TODO: Taking the key from the table might introduce a race
 		 * when PTK rekeying is done, having an old packets with a PN
 		 * based on the old key but the message encrypted with a new
 		 * one.
 		 * Need to handle this.
 		 */
-		tx_cmd->sec_ctl |= TX_CMD_SEC_GCMP | TX_CMD_SEC_KEY_FROM_TABLE;
+		tx_cmd->sec_ctl |= type | TX_CMD_SEC_KEY_FROM_TABLE;
 		tx_cmd->key[0] = keyconf->hw_key_idx;
 		iwl_mvm_set_tx_cmd_pn(info, crypto_hdr);
 		break;

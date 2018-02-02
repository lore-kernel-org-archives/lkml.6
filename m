Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22742kI0cBVj5aHcJCgftrlqyIVtHSC73fHE9x33tM+7j7iG3MYurI/5MLYerb4z2zYSy/5V
ARC-Seal: i=1; a=rsa-sha256; t=1517591557; cv=none;
        d=google.com; s=arc-20160816;
        b=bHI1HsEBEWEDjtsyXWJa49dXh5ws8iLFcuovN8Dj96Gk3ykaYZNbZhNB7Fn4I9vuCh
         /5rLUpaKyAd8qLRc0LZuBHOIU9P/o8Gurg9swDT1wtwVygrglDUwxnsz+ADkeS/N0IeX
         tTMJ7zKeTgP97CLnt8Nmq/g8es9sKB6EQ/nY4wzk3CzPyttPJ8TYniDvPE1ljEsTiZul
         BqN61Psr+rq+IJAuCQQxJierM0pbg5Okws2vLDRqoe4mWRmvEWesklsaelsbC+vjA1Jn
         j6d9b3ao2cQmfBcGpD8c3cIZ03ixW8fYC5FH0cW2gAesKMWg+uelyXDRPq3z5Hzut/Bo
         KrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NUTQUYpVNJ4/jbRTdQBSztHwbcxPQoVbLIyzErPW6Ec=;
        b=rtlyOXZgC97sL67xRT3bqJI1/I1HizU+IM6TM3Ajc7Qmc7rqYIhi/l29MZ6DApFFXc
         K9zkXnEmj5JEGnqkeCAY+zNpxa3Hbd+hkTT037UrmCyztiDColpTgW6FmlCP75YOqKLh
         I46VRW4EgvirQHak0D6c+hNqqapyWazqI8LDrvVFLAALb+iHi4E3pIhs2pc9M8j9P9kA
         USvf77las5MAFU+Y6fYtWZLoUdc0G86eh4bUaLdTbaxKQwkACB9LJ098kYXwOELQDfNq
         bL8yAb+d+csYR54HLBf1IV0PyQqm9m0dceTKek7FUkRmbLLsumdHw7i2acK6km1xRBr5
         mozg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sara Sharon <sara.sharon@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 120/156] iwlwifi: fix access to prph when transport is stopped
Date: Fri,  2 Feb 2018 17:58:21 +0100
Message-Id: <20180202140845.605790897@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310084879691899?=
X-GMAIL-MSGID: =?utf-8?q?1591310084879691899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>


[ Upstream commit 0232d2cd7aa8e1b810fe84fb4059a0bd1eabe2ba ]

When getting HW rfkill we get stop_device being called from
two paths.
One path is the IRQ calling stop device, and updating op
mode and stack.
As a result, cfg80211 is running rfkill sync work that shuts
down all devices (second path).
In the second path, we eventually get to iwl_mvm_stop_device
which calls iwl_fw_dump_conf_clear->iwl_fw_dbg_stop_recording,
that access periphery registers.
The device may be stopped at this point from the first path,
which will result with a failure to access those registers.
Simply checking for the trans status is insufficient, since
the race will still exist, only minimized.
Instead, move the stop from iwl_fw_dump_conf_clear (which is
getting called only from stop path) to the transport stop
device function, where the access is always safe.
This has the added value, of actually stopping dbgc before
stopping device even when the stop is initiated from the
transport.

Fixes: 1efc3843a4ee ("iwlwifi: stop dbgc recording before stopping DMA")
Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h          |    2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c |    6 ++++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      |    9 +++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -209,8 +209,6 @@ static inline void iwl_fw_dbg_stop_recor
 
 static inline void iwl_fw_dump_conf_clear(struct iwl_fw_runtime *fwrt)
 {
-	iwl_fw_dbg_stop_recording(fwrt);
-
 	fwrt->dump.conf = FW_DBG_INVALID;
 }
 
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -49,6 +49,7 @@
  *
  *****************************************************************************/
 #include "iwl-trans.h"
+#include "iwl-prph.h"
 #include "iwl-context-info.h"
 #include "internal.h"
 
@@ -156,6 +157,11 @@ void _iwl_trans_pcie_gen2_stop_device(st
 
 	trans_pcie->is_down = true;
 
+	/* Stop dbgc before stopping device */
+	iwl_write_prph(trans, DBGC_IN_SAMPLE, 0);
+	udelay(100);
+	iwl_write_prph(trans, DBGC_OUT_CTRL, 0);
+
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
 
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1138,6 +1138,15 @@ static void _iwl_trans_pcie_stop_device(
 
 	trans_pcie->is_down = true;
 
+	/* Stop dbgc before stopping device */
+	if (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000) {
+		iwl_set_bits_prph(trans, MON_BUFF_SAMPLE_CTL, 0x100);
+	} else {
+		iwl_write_prph(trans, DBGC_IN_SAMPLE, 0);
+		udelay(100);
+		iwl_write_prph(trans, DBGC_OUT_CTRL, 0);
+	}
+
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
 

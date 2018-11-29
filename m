Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B9F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGnSkk7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B9F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbeK3Bbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbeK3Bbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C23213A2;
        Thu, 29 Nov 2018 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501572;
        bh=K40okUInr6f/r0vMi+uA4SqKFLacxyK3tjxtreYW3XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGnSkk7fguT/ec822CTUDkNn/DBir26FeX+y2fFiWXvQ/BJ6DqAginA4S4Q0jL2Br
         JYTqY8C+CwARLuF9mXWA2nR3qLCINl2rhehAvzOsaThpJDdV7h3iWCJm8ZpYnWMzR2
         +37vHs5g1FA8FUhZ2Ld49RhbVg3Ux+1n2zMZgbaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.14 017/100] iwlwifi: mvm: fix regulatory domain update when the firmware starts
Date:   Thu, 29 Nov 2018 15:11:47 +0100
Message-Id: <20181129140100.369156971@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 82715ac71e6b94a2c2136e31f3a8e6748e33aa8c upstream.

When the firmware starts, it doesn't have any regulatory
information, hence it uses the world wide limitations. The
driver can feed the firmware with previous knowledge that
was kept in the driver, but the firmware may still not
update its internal tables.

This happens when we start a BSS interface, and then the
firmware can change the regulatory tables based on our
location and it'll use more lenient, location specific
rules. Then, if the firmware is shut down (when the
interface is brought down), and then an AP interface is
created, the firmware will forget the country specific
rules.

The host will think that we are in a certain country that
may allow channels and will try to teach the firmware about
our location, but the firmware may still not allow to drop
the world wide limitations and apply country specific rules
because it was just re-started.

In this case, the firmware will reply with MCC_RESP_ILLEGAL
to the MCC_UPDATE_CMD. In that case, iwlwifi needs to let
the upper layers (cfg80211 / hostapd) know that the channel
list they know about has been updated.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201105

Cc: stable@vger.kernel.org
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    8 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c      |    5 ++---
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -328,8 +328,12 @@ struct ieee80211_regdomain *iwl_mvm_get_
 		goto out;
 	}
 
-	if (changed)
-		*changed = (resp->status == MCC_RESP_NEW_CHAN_PROFILE);
+	if (changed) {
+		u32 status = le32_to_cpu(resp->status);
+
+		*changed = (status == MCC_RESP_NEW_CHAN_PROFILE ||
+			    status == MCC_RESP_ILLEGAL);
+	}
 
 	regd = iwl_parse_nvm_mcc_info(mvm->trans->dev, mvm->cfg,
 				      __le32_to_cpu(resp->n_channels),
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -732,9 +732,8 @@ iwl_mvm_update_mcc(struct iwl_mvm *mvm,
 	}
 
 	IWL_DEBUG_LAR(mvm,
-		      "MCC response status: 0x%x. new MCC: 0x%x ('%c%c') change: %d n_chans: %d\n",
-		      status, mcc, mcc >> 8, mcc & 0xff,
-		      !!(status == MCC_RESP_NEW_CHAN_PROFILE), n_channels);
+		      "MCC response status: 0x%x. new MCC: 0x%x ('%c%c') n_chans: %d\n",
+		      status, mcc, mcc >> 8, mcc & 0xff, n_channels);
 
 exit:
 	iwl_free_resp(&cmd);



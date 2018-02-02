Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225k25kkhu3l5vFtb6E09XY3EQqBpnAgTAOuKtMIMnzYxooG8VU4SA2ywQUMuvGJwqnNWFyC
ARC-Seal: i=1; a=rsa-sha256; t=1517591138; cv=none;
        d=google.com; s=arc-20160816;
        b=w5nEQnof7dMVNm8QmQ/gcSCd5SBN9f/VmGX/uls7CDiBnui8GMSFlYo57ZAyYQIuzu
         /Xkr0D7WECPnpTUGTU6Rw3hQMXEiPq5as0kyTuPkOG/k/eDZwiAl1cspLhJN8v4216E3
         odY0JK7RPSuM5tpA5hnDOa20Ndi3Y/fCj9LeJ9eQGJEKfBNCH0W3fMqkhXNYdKr/suTo
         +A/AGf9YMs/bdDPj0/8gHVPaeHlfSjrenz2B+85QTQGxw3KHezMvwtyJl5nhS5ImhTMy
         Vidb9A9IDkl/L1gUz7/VsOqSoCyu3rhEnkhJck8ntH+xEOMBlk1YFOwhTI0G/FTzXPXM
         zvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XZ7QqfXSlGlpU5c3h1Mw83TrN4uP3S9DTYomhw4HNHc=;
        b=SFoHnu612qM/MoF/we9vXKqKNHzrriM9x9btlE9OYVQh4P4sO3UPHDFR8bYSQu4amM
         GBpHC+AzWqUu1H3XF7bLe6m1FOokNb1wGH9idhw7/7FWybmrwj0S2GiL1s3xmzDcEsSN
         87YmMDY2Dw55os20WnMAowomZq4MnLjjGe/HDVi7WcDMIoEo6JvHkqcBvB4yBjKqhFwF
         za7utvzf0Ts8LIYHhlGwz0lT5Tqi2Cal3GJRSfIGuxovRYEoye6baH09akbcN65ZOGhg
         RVTXl1WmEEJVJsgzTfftX4qq5v3m21z3zrktci3x/VdXaJyo8sfZnP7nN5FMsWhxex3n
         D29A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 65/86] iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type
Date: Fri,  2 Feb 2018 17:58:25 +0100
Message-Id: <20180202140828.647980820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309645672364356?=
X-GMAIL-MSGID: =?utf-8?q?1591309645672364356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit d1b275ffec459c5ae12b5c7086c84175696e5a9f ]

The MONITOR type is missing in the interface type switch.
Add it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1040,6 +1040,8 @@ unsigned int iwl_mvm_get_wd_timeout(stru
 		return le32_to_cpu(txq_timer->p2p_go);
 	case NL80211_IFTYPE_P2P_DEVICE:
 		return le32_to_cpu(txq_timer->p2p_device);
+	case NL80211_IFTYPE_MONITOR:
+		return default_timeout;
 	default:
 		WARN_ON(1);
 		return mvm->cfg->base_params->wd_timeout;

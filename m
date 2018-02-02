Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224AbDliJQ5HrAjl26Z+vs8H2FSpNBjnOtEEvUKB/D3qLmKAUfvMqgi2P7PQ8iRxECVXMOeJ
ARC-Seal: i=1; a=rsa-sha256; t=1517591554; cv=none;
        d=google.com; s=arc-20160816;
        b=nKrb6fRk8iQzfqSfgMcXX0a7b1u/vP4n/AzHTaCDNXOsNIMhbunKpeMhjWxxk2e+R/
         bAtYbcQn7QDNxDdBkg1qVF5SAR09AHassyy2R9iemU2P3GETtVJ2ohxPOsnR2mo+nTQa
         HhXeHEHcToZdCStutBN00cowdPlrSxvgBAMPbUZ71Ev0ufHtRN8+W5H0B1kc3lXwyh1b
         rdTEXDBZi6KbCQ0V8pTOiXQToxlmZ/DPaJt8A4r0jc7pjWbCOvRIy78OV4N1lluY21ny
         JPVhCiB4OyLoCILbN5oh2ldejvLQqmZOTHiYWbBSlM9k9PuCSeC70qCbbcf//rLv+hVQ
         eeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VbOkSq7T2Y5BMPCh4jfdV6TOX06GGdFuBm+Mmy41Sqk=;
        b=sXrZ6zfOWGr4eH/J+gvSMl5blMID05JXKJlDqT+nvuK0aNEb3+sNPWdhh5UHL6iaGP
         etjvzBqae7onjhWlJcAIkQPg80HKetpQsMcnDaLFndI5xluu7tOiaCpE7qguy0DxivHd
         6Zwqi+R8Dzhyy0ITTXNDlGkvG2njKMSr5v3Hk8c9p/xlY3DatYn/V+Udm7uPNw+HviCk
         uM11dfJ2BSNu0r83U17Zr+0HILZVf7RVBrncIrQbNQC7RkPXmC761eGBsnYMaSN7Vw+e
         FuXcqcKVQIgrLn7glyXhywhHzLTtBBc2zrRiyV1acqqgEWzIO/N9FbgNemQ4RAUJYPq7
         k6Sg==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 119/156] iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type
Date: Fri,  2 Feb 2018 17:58:20 +0100
Message-Id: <20180202140845.559895558@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309645672364356?=
X-GMAIL-MSGID: =?utf-8?q?1591310082444999508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>


[ Upstream commit d1b275ffec459c5ae12b5c7086c84175696e5a9f ]

The MONITOR type is missing in the interface type switch.
Add it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1181,6 +1181,8 @@ unsigned int iwl_mvm_get_wd_timeout(stru
 		return le32_to_cpu(txq_timer->p2p_go);
 	case NL80211_IFTYPE_P2P_DEVICE:
 		return le32_to_cpu(txq_timer->p2p_device);
+	case NL80211_IFTYPE_MONITOR:
+		return default_timeout;
 	default:
 		WARN_ON(1);
 		return mvm->cfg->base_params->wd_timeout;

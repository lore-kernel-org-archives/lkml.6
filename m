Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx488y/QbmCBqN1hP+6NEDKWe2iTpP5eTE7hkrdEwcQqths857EGeTa96oCms7LWHBIgt2B12
ARC-Seal: i=1; a=rsa-sha256; t=1523473308; cv=none;
        d=google.com; s=arc-20160816;
        b=N4nSEuI8jBvlNMMlvu3ZHTUt+RdrbTevT+o7NgvhFm5wQcg5Oc8z4fgr3uEBUuINz3
         atae7RByjTjbKG6tCYMo0bOHL02htFJRJY8Ge5g2bFWfWQlG/bZyGwg1aDP9MDV4+CVY
         DO2AruDMsfGW2vi5eT1Y+pSYbIzewmBergCLUcASl+GFeLpG/w4PqRCRfpmQKLPvF4Wn
         2E8xUDDsgv7QaBSjCYEYBoY3G3vRH0FJruKazrPucbZXEpsjrlu54ml81S/0eSXGDmKP
         aNZPwMkz5rbDsafRvF9VF/+lfw4s+VgQyt/GwhLg9otBlLBig1x/oXM1gQ5DpWRZRSNl
         xSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xp9zkvbeQVcfOrDJFq+PyiQcxBDde2/GMwKWgkl/Io4=;
        b=r8y+5JUc4k07pC95aRhuFDInv7Cs0a5aN/xZk2rlSuv+za1ts6fYZIws7rZ9aiDfDO
         IRfnf8BtTVE+SVsdfEyXlclQxhe27IF9kvsCbZqPkIJkiuMbw3TNKT2zgvsTehgDbTsn
         Bv0l/FUIJuqsg9iTw8NHgp+4K1VqmP2smp6QBGtrCsml8K6GRJmXWjRpoB4dS0e2scrM
         bMQb8TGlFdO29u/KpHkzPrRl4gB3xGpcH61VA6djymhmlZTV/GLnj1QkEWjomYsqzHNN
         e55bT/Byy/MBbyTu1oPwrwJsBEKe36G7pMfO9nlvfhkEc5SYFf8sL/G0JWm+GBr7979K
         +bOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 200/310] iwlwifi: tt: move ucode_loaded check under mutex
Date: Wed, 11 Apr 2018 20:35:39 +0200
Message-Id: <20180411183631.191781128@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477547224515461?=
X-GMAIL-MSGID: =?utf-8?q?1597477547224515461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit d9954405758a0cbbe258d9b4d4dc12a06fa48a28 ]

The ucode_loaded check should be under the mutex, since it can
otherwise change state after we looked at it and before we got
the mutex. Fix that.

Fixes: 5c89e7bc557e ("iwlwifi: mvm: add registration to cooling device")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -790,11 +790,13 @@ static int iwl_mvm_tcool_set_cur_state(s
 	struct iwl_mvm *mvm = (struct iwl_mvm *)(cdev->devdata);
 	int ret;
 
-	if (!mvm->ucode_loaded || !(mvm->cur_ucode == IWL_UCODE_REGULAR))
-		return -EIO;
-
 	mutex_lock(&mvm->mutex);
 
+	if (!mvm->ucode_loaded || !(mvm->cur_ucode == IWL_UCODE_REGULAR)) {
+		ret = -EIO;
+		goto unlock;
+	}
+
 	if (new_state >= ARRAY_SIZE(iwl_mvm_cdev_budgets)) {
 		ret = -EINVAL;
 		goto unlock;

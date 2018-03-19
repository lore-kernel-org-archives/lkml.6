Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsD9Z7wlp9hthdAnsZsip0W36rLI0LxQA0squPjwppCbcoVDtxb/uyeS5WXglNdVX43Fqwf
ARC-Seal: i=1; a=rsa-sha256; t=1521483905; cv=none;
        d=google.com; s=arc-20160816;
        b=ZnRv9jQDUhFxfcAu60KYCiT0hRKKhuIxnn8PPEIM2Rb5SuSXtLDSnrjN1yev12DVaI
         Bu3rmoiFjmucRWbsOfJhrU91dwO80PURrIDg3FAHrDLYEZYgGh5pKlSBDsdCoge1biOQ
         O7uTlwbqN5fL9IteHtiR5ezR1HNR1iiL87ydCUGBgFZmUCs2qe/jomc2ckBaIr8fEVsB
         sJ8Y3ubDCxbuf3dS4tzDyn0rph/vwk+JUMDR5H9Wh+Mot450pRI6NzB6aSeaQel+aRXT
         SDJ5xGhiSTsBXyTjNefcklq7lxsH87hvJq3v5jJlFQA/2bJl75t47qm3OqL/wQ9EerAH
         8jLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7NDfgmXAJup6Gjs7rGR73YVAswxHltb9BYNGwXlCOjI=;
        b=Tzeg8TzpK8jfoQPb9lOnxDLpYYrQu82EGuIJJv3L16mfZKW9OZv+WLllj+2IbMjp5e
         oF8DoxUqGMP+42w3ABk+FqNTSNvMqmUlO0wOOtbQTBlqVlfIyIO0VYnlBnW6BI0DsLQI
         7gN3H6XEA7npv4xs7apEDRLnNXqtwRTvXFE5VINU7asaeQU7hzbeQmRqFe8M8Bo8HdQj
         rTDdjgEgJN2FE25zTc1l3nLVJzi5SQLzdE0J0B9Jdbu/nbPSEOqxsspRYBkbG8eolZDr
         DYXU6Pw3VINLjaX30NqcUOvih692LSVzpenAW0LS1aXGuALEKoZf3RLR/MMI3aKKOLE3
         NSsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>,
	Maya Erez <qca_merez@qca.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 160/241] wil6210: fix protection against connections during reset
Date: Mon, 19 Mar 2018 19:07:05 +0100
Message-Id: <20180319180757.792911861@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391507962917998?=
X-GMAIL-MSGID: =?utf-8?q?1595391507962917998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>


[ Upstream commit b819447dfc4bd120c9d6cd8521252d544fce8fe7 ]

Existing code that ignores connection events during
reset flow will never take effect since it locks the
same mutex taken by the reset flow.

In addition, in case of unsolicited disconnect events ignore
those as well since device is about to get reset.

Signed-off-by: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -501,16 +501,16 @@ static void wmi_evt_connect(struct wil62
 		assoc_resp_ielen = 0;
 	}
 
-	mutex_lock(&wil->mutex);
 	if (test_bit(wil_status_resetting, wil->status) ||
 	    !test_bit(wil_status_fwready, wil->status)) {
 		wil_err(wil, "status_resetting, cancel connect event, CID %d\n",
 			evt->cid);
-		mutex_unlock(&wil->mutex);
 		/* no need for cleanup, wil_reset will do that */
 		return;
 	}
 
+	mutex_lock(&wil->mutex);
+
 	if ((wdev->iftype == NL80211_IFTYPE_STATION) ||
 	    (wdev->iftype == NL80211_IFTYPE_P2P_CLIENT)) {
 		if (!test_bit(wil_status_fwconnecting, wil->status)) {
@@ -608,6 +608,13 @@ static void wmi_evt_disconnect(struct wi
 
 	wil->sinfo_gen++;
 
+	if (test_bit(wil_status_resetting, wil->status) ||
+	    !test_bit(wil_status_fwready, wil->status)) {
+		wil_err(wil, "status_resetting, cancel disconnect event\n");
+		/* no need for cleanup, wil_reset will do that */
+		return;
+	}
+
 	mutex_lock(&wil->mutex);
 	wil6210_disconnect(wil, evt->bssid, reason_code, true);
 	mutex_unlock(&wil->mutex);

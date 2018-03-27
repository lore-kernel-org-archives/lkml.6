Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aNEujCo/16TaueZWsJ6LJrAWhgq+u3hQt/Gy3uuc6CZoRvVWnso1/pqLYUIReIYjSbFIB
ARC-Seal: i=1; a=rsa-sha256; t=1522168891; cv=none;
        d=google.com; s=arc-20160816;
        b=UeiqlAVK1WEQFyywPN/VVRHISSq6D8LDuCp6pPp2qA7X5/vwQTyyZHATebmBdMG8U3
         7J7uzVUqNm7fSo+pV9hNUiT3vnIkUPoK7LGbY9YpK2MQQOPa5J7uawJSbpzoUZ09SQZA
         gYWjzg2QSTOASepjSaXs09LuiAIus/PnsIXNzO1yY0jFHP2Q7La++wI/hwjnwfDQ5HVh
         br3CiV2dt7XNTZ/oWKjhSufZy5/K4kkc2g+uEhC07Fi9yVx7xMspLru1QIX1akoGIrOV
         iWDsiG93MGdINEupVHogYHpGm3UdvGi7pDi3vGSjoTNjY4gAqN3me5dAj3COA0cby6it
         oRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4CW3bmwc48XSCthywazGKNGnidg2Z+7MStGdvlOUQKQ=;
        b=XZgfPfwuOt3lyK9S+vBKI8wmP4+QNa+Y7zzxnDkhLJCkVXLJf5R05lEWnpFZGVlexU
         V4sYWs60xCzZyWZphdDirY2sMa3MT5ME87trLfH+nNAYaRpfEEYEe/eriP2Ks/ONxMce
         /9Bu50G1LnR+kOE8BWWpOXNGbjiK2D2/2BZU93Mrzb874FN2EM1W3ZXsJVsppwk4VZCI
         blPB38ln/4UIaO+65NEMQOqG2jA2wJB/qVR40iOzrEuuA17dE5TM9umN6ouVWy5B552L
         yspQdkZQOEl9bRrZl05/Laxvx21ykY7DeKnjeS1raa3IoWN7vcznONdjrrMqSOR3KuBn
         s+2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	James Cameron <quozl@laptop.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 068/105] rtlwifi: rtl8723be: Fix loss of signal
Date: Tue, 27 Mar 2018 18:27:48 +0200
Message-Id: <20180327162802.038887372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109011873420590?=
X-GMAIL-MSGID: =?utf-8?q?1596109767491092451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 78dc897b7ee67205423dbbc6b56be49fb18d15b5 upstream.

In commit c713fb071edc ("rtlwifi: rtl8821ae: Fix connection lost problem
correctly") a problem in rtl8821ae that caused loss of signal was fixed.
That same problem has now been reported for rtl8723be. Accordingly,
the ASPM L1 latency has been increased from 0 to 7 to fix the instability.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org>
Tested-by: James Cameron <quozl@laptop.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -1124,7 +1124,8 @@ static void _rtl8723be_enable_aspm_back_
 
 	/* Configuration Space offset 0x70f BIT7 is used to control L0S */
 	tmp8 = _rtl8723be_dbi_read(rtlpriv, 0x70f);
-	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7));
+	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7) |
+			     ASPM_L1_LATENCY << 3);
 
 	/* Configuration Space offset 0x719 Bit3 is for L1
 	 * BIT4 is for clock request

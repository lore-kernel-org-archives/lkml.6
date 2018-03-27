Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iHioURBciUtLuu77lrJLS9JQMTjClEfrX9t1iWIf+ERxq2HNzpYoNRMF6XNsdJs+YEiCZ
ARC-Seal: i=1; a=rsa-sha256; t=1522168687; cv=none;
        d=google.com; s=arc-20160816;
        b=T9aRRQRQvD97cnm4irFRuNEeHp5A8s5mqPqiy6CM9XJpnjC97AbZb0yAjaBT0HtMTS
         i9EMPqghWEMu/LgYYtKXWTae7Jj5sgeAmNmFh0bVrkMbFYyGXlbCI5GNVwVJDXJhGeIi
         +yHbNFav6mQr6w4v11mIq2RdtN9yNmnfO33ZVCKJl2eFYeh1q8B06uQDJSzflLBbPJRz
         WQ39YOgaobi/phnUtWRabw2xvf2Of2EcGQZ1JdePDBbCO9GsfE282KQOAwg3GbLYQRRg
         sw1DTUQc2t94BykbBbFguUksYyDdK5a4+4iRa5HwpIqOJ505rtGqsAr1w140rpDlez54
         5/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/I3D52+rd/DOVYVkkKIMbPDW5RlbWPV+TePchm6H0gM=;
        b=e1PwHK+jzO6J4jGUyWvqUlbYykW82H4cIqfYu4S0HthrDojGDev4UTBUG3GAkdMsdv
         RFkT8px427dvqqzpppIYEeURsx1Rm98a3QKW6RGagOaMXJ9skJ16Ti+XI0v1w4KJwxbp
         vPQvTpv8O2v2AjacsRWl32Rw/rAdjltRnqzwMUEx5DvhJrqDA29UZHPWoVqFq9oGPPYt
         VBFwV9dOksuV2seL/oj2TOyp8nIKo2YWlF5F+2HJ+idHVqjtjfyNEDEG8hXK1jJFe8PB
         a5AyJfBYKKXv0sk6n/7lEaRI0rqva+VJeyAuUI+cCLxCwrjunQSaMUK4nZIpzjgZbbo8
         NoRA==
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
Subject: [PATCH 4.14 063/101] rtlwifi: rtl8723be: Fix loss of signal
Date: Tue, 27 Mar 2018 18:27:35 +0200
Message-Id: <20180327162753.863418192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109011873420590?=
X-GMAIL-MSGID: =?utf-8?q?1596109554209692351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1123,7 +1123,8 @@ static void _rtl8723be_enable_aspm_back_
 
 	/* Configuration Space offset 0x70f BIT7 is used to control L0S */
 	tmp8 = _rtl8723be_dbi_read(rtlpriv, 0x70f);
-	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7));
+	_rtl8723be_dbi_write(rtlpriv, 0x70f, tmp8 | BIT(7) |
+			     ASPM_L1_LATENCY << 3);
 
 	/* Configuration Space offset 0x719 Bit3 is for L1
 	 * BIT4 is for clock request

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukY7cHBLzk0mYRXnClp55atUMMXdmrLsD/1gzyx6p6Hjqp+Rehs8vqvZN5fWGho7NvAhlb
ARC-Seal: i=1; a=rsa-sha256; t=1521800097; cv=none;
        d=google.com; s=arc-20160816;
        b=xDil7TBx7lI85XrJxSvbuGZ852eDIBvZk8zm+uKjuGLWwbK6XF2TtH5v4vsG1y2hEv
         uPcql46aEK6xT8RUHmokJ9RnKN+wCisBt33DQB20NfPehGoEcMUTf0Vywgar3c32ALYp
         ZvX1MiqxvO3/ov0dAFOtNTCMW1iIFv4Y9CLOkqP8TvUSXPoUKYczYRr9BQPRAZuDdOEq
         ZVyMevB8ihj3mWdYPneEazUI14movSccpTk1kY3KJZaoRv/ZTH78I7nVfI7Wz/suXjjL
         bey1f1jrSP/jHTeXssFPrl1DTsF+gyHMCuGk9Rm+wMtAYmE0wfd3Ezj4C5jUEiOz1Uc1
         dl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JD5LTOXNNU1S0KKiG/x72+/vpGMbukTIcV/4T0gnZUA=;
        b=XGZVaVg7nDNbNfEFbTYbLK79qzkncOdfx0F6ud+kOrCrG4Cx/eOgsxoKiKRe2mjblB
         defY1cks8t35ISrEA0/aBn5W4A/7bkWWSedcD/diOr+v88UthydyAoFt+pPF+fLDFssk
         pt3i2L/HVdFu0w7Flg7BWe6fdqpTgQ+pp5tMvzm5efUeoeLBbqaV25SX4VP8dwBafvD5
         OhscihT8r28HWl6u2K3IyBFnfSUNkJcUJLMMyZ44t2yMrjMOOLfl6Tclc2dGHLrnI1Kf
         K1kAJXaHQ6vbHdoxWePZ2ws7n/4uqhvgig+UxzKjsbsbnGJkxWnsZ0LWIAL54fLf5Bz+
         hTuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 48/97] rndis_wlan: add return value validation
Date: Fri, 23 Mar 2018 10:54:35 +0100
Message-Id: <20180323094200.302960637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722625840527825?=
X-GMAIL-MSGID: =?utf-8?q?1595723059112028874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 9dc7efd3978aa67ae598129d2a3f240b390ce508 ]

Function create_singlethread_workqueue() will return a NULL pointer if
there is no enough memory, and its return value should be validated
before using. However, in function rndis_wlan_bind(), its return value
is not checked. This may cause NULL dereference bugs. This patch fixes
it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rndis_wlan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -3425,6 +3425,10 @@ static int rndis_wlan_bind(struct usbnet
 
 	/* because rndis_command() sleeps we need to use workqueue */
 	priv->workqueue = create_singlethread_workqueue("rndis_wlan");
+	if (!priv->workqueue) {
+		wiphy_free(wiphy);
+		return -ENOMEM;
+	}
 	INIT_WORK(&priv->work, rndis_wlan_worker);
 	INIT_DELAYED_WORK(&priv->dev_poller_work, rndis_device_poller);
 	INIT_DELAYED_WORK(&priv->scan_work, rndis_get_scan_results);

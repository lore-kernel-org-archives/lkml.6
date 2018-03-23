Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELumK3iDdMtETkUGwg89LcU4to1IJV1O0C+xDI23KMfuE6QjpviRC7FEstTRq2SnuaJjOmyS
ARC-Seal: i=1; a=rsa-sha256; t=1521800356; cv=none;
        d=google.com; s=arc-20160816;
        b=ZRlCcx2eOHwLt+b/NsEyX4784Bwid29UBqS1lvpoKhBViMvViykzOA+kAmHcqOpO2U
         W3r8I2vsHSUv05A36/6gGZEWDDGAytVf6FxEsPVBinpmt0n3AN1nVDBBRfsbgDC6F9pn
         8zW8C3XM4x9Z9wsoJd9m9JGANYasycxyZY7m4qKgW1ZswerCPWFdiAhIv6fcISmoi2Yf
         kXFddSKknI7ex0n7AjReUK2lrzj9+60kdtnZdd9EsD+UBcb94+F0htqmZzNaLwHih/3z
         wcC55oGUOgfGY8RBbcaXZJueQPJwTuaRqHxyKVLiv+qHNuiJvepkBwHqwnMOtfEOnwQZ
         LQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tnOpbOVtUCCtCaz84vsp51jL6e6yM9g+dUO0/JzqW7U=;
        b=u+o22VIrVmmZXmjRmChAq9/IIh1dJ2KzQ+aGlpnTuYnz/hLd2XSec7LSaHpwCv4n5A
         Bj1QBILc9pkRTtTH9azykk8mo73BTRFDRR386k5NbTIXyr+Myi2pxkN9ZE68DkD2JTKe
         CUsU7DXYdJmgIssGGfZ77u13q5uvZYJi6wgEmcK4D8k3VwZlyQlS7EWsMABjL7H2IFTe
         Uu1SwgpXuNYl1ebkyJ1WbgPYWkToCh5+DRjZMOhHSySxo6ZTZ3oj1K3YuTSKTTAbkeox
         dvu7Af+djd1oaiHK9Sp4BREsgZZ/GHPKR3X26rVmnXKDTslKdH0XLB64YottpMcr5Ffr
         adgQ==
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
Subject: [PATCH 3.18 24/47] rndis_wlan: add return value validation
Date: Fri, 23 Mar 2018 10:55:15 +0100
Message-Id: <20180323094249.153770370@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722625840527825?=
X-GMAIL-MSGID: =?utf-8?q?1595723331219145812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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

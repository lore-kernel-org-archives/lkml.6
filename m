Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48LFV218YnkR14u46ciIMvU5mVvoyaPn5JBVPlAum9Q7/QZBLBblAJ7+mE/sKaYcEQpl3un
ARC-Seal: i=1; a=rsa-sha256; t=1523399229; cv=none;
        d=google.com; s=arc-20160816;
        b=Grs/KXXBKugq0Egf6oCEJujBpwnXItPpRMqlCd6IjNsL5xDz4qkKOK/Uujs3T2qsR9
         msLYuGajPuiyqtq6ScI/6u5d6pERhcDAfkgjuPCXbs3T7wFxG5vhHFgTwntNdoTbLOL+
         Av2KAgt4bC7J6QoiML+NrULR/UWarBT4qz7gqwTFJ/qjn64c5t9yZ1wFmnew4vu3JX9h
         76c4moBtnzxdE0FwE3pgbk8aHQnoDqSXFf6tpV2rg1ov0py3Nn8TVlam4qbTCmuNTwvi
         Rhbb4skhj+8cneoaKVtSm3/aTAYOBSWt7AJGtN1IL1QxFmz+LgGiVa9DmqK5baM+kdWt
         Dq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9kzKEq3hY9krkM4+yYmMEmiTY/UYkpGZsJNELkSgF9U=;
        b=STN24uMxvBFHLEVEFb5K+NlbVKgvAVSRfBHoWKTL+T4JsfmCr2cEqT22OynxQSQEMz
         lDkRTb3G5vfr1DYzRDw/5gr2QMdiAfQ4BJ8fB3K2F/vP5SG229J/40KWtdY1Z3NWia6U
         aZZAY85yhwGLx09j/cinc8LgJ9vfZqZZ+1sDUJvrAAFtIVqcHGX59aF5IHfVueAhCTcr
         MRbYhn4Pg+y7onju9HqS4qxcmjYm+ageB6FkU4qQSEHeif0fYBY8b14Za4okeePhB+TR
         eKVIBOrAL9GbI5awpiGotoKkXK0ARDf995DIIJTlyiDcODpCGiUmQwGhrEaY13GfmWt7
         KG1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fuyun Liang <liangfuyun1@huawei.com>,
	Peng Li <lipeng321@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 014/168] net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg
Date: Wed, 11 Apr 2018 00:22:36 +0200
Message-Id: <20180410212800.824613837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399870427815524?=
X-GMAIL-MSGID: =?utf-8?q?1597399870427815524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuyun Liang <liangfuyun1@huawei.com>


[ Upstream commit 27b5bf49f0924fd62d2b1ef8467b40773973da34 ]

When phy exists, we use the value of phydev.autoneg to represent the
auto-negotiation state of hardware. Otherwise, we use the value of
mac.autoneg to represent it.

This patch fixes for getting a error value of auto-negotiation state in
hclge_get_autoneg().

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2189,6 +2189,10 @@ static int hclge_get_autoneg(struct hnae
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	struct phy_device *phydev = hdev->hw.mac.phydev;
+
+	if (phydev)
+		return phydev->autoneg;
 
 	hclge_query_autoneg_result(hdev);
 

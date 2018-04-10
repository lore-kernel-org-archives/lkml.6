Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48JiSbpest2PjnRwKX05vsEqANAdgyrizjpEuYionraFTHRTl13P20s0igL96BdZC9EGQSQ
ARC-Seal: i=1; a=rsa-sha256; t=1523399338; cv=none;
        d=google.com; s=arc-20160816;
        b=VAIkAuSKTiJsKNB8tLC+ttgm/3aGZcUpifdTT7kWhDljqh0tly1gB24xCw+tj1angI
         cXOFy/YjcCxwttZfdx6NwDnp3lBWG+9cTF9Yut3F9a5jlysqItWw4CMKuRDBNCoQoFoP
         lS60dVhgpA2hYxFayd6XtTd2SH6QksddDbQiX+SopK4vgjGfzm4htuuou+BWIOP98bf8
         h9Mo9Ha9UP4zI1HY6ChPk17WckFBMY0P2eSK6jLfBsF2fS3AhO8JyfnE/dPIYc8Vkz/O
         N9vhdsPZE1DcJCbP3WObFGNKejxVK8KIQNJsfmdC0c2lKlAfG1Xi44NJ4ASF0xaxpGqO
         pt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+heoV3HAnskpreWr5+2yWz7dXuMTPqRgLt/KVWx5nQM=;
        b=C4nGn6cD4GkOWJp49X2yH0U6sW/0Xgid6sp3y7P78xACSH+TVWS0ENCf22jAbUNuW8
         kawjWzbM0eGbs0Kf1ju/8MhboQCiLAbuan6tCQaBv6DPdUBU+PffYbxkW61iE12FR4+w
         EDYFtNazJGKC8xfwXyqItkjHjT2YY6CYZVzQtRDRVeyVaEmTIKaQuuu2RC/FvchLte+w
         nLo0VbI56KmOTw3OFKOFoDWWLjQdQHBlVC+IDCW2/dYwm8eGO1YHc68ZPGNXpAvgcL5s
         AaCmQl5todXoM0NDaL3+zUYOke4mLMttIchPr8Hy01ZFjvkriTN7BzGfbqRJqgMCkra0
         xGoA==
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
Subject: [PATCH 4.15 071/168] net: hns3: fix for changing MTU
Date: Wed, 11 Apr 2018 00:23:33 +0200
Message-Id: <20180410212803.218501589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399984249014896?=
X-GMAIL-MSGID: =?utf-8?q?1597399984249014896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fuyun Liang <liangfuyun1@huawei.com>


[ Upstream commit 5bad95a1e55f4d5bb41e130db859d57eaf1b1549 ]

when changing MTU, The new MTU must need to be set to netdevice.

Fixes: a8e8b7ff3517 ("net: hns3: Add support to change MTU in HNS3 hardware")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -1324,6 +1324,8 @@ static int hns3_nic_change_mtu(struct ne
 		return ret;
 	}
 
+	netdev->mtu = new_mtu;
+
 	/* if the netdev was running earlier, bring it up again */
 	if (if_running && hns3_nic_net_open(netdev))
 		ret = -EINVAL;

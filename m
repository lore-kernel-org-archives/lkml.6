Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48sYiod4W5Tr+0gJGlG72JoxuWc2klXdMUZ5O22rpgCzpcemz/gr8s2xT9iSVs4pXvnk4LX
ARC-Seal: i=1; a=rsa-sha256; t=1523399227; cv=none;
        d=google.com; s=arc-20160816;
        b=ZzsIIpLQqmohR0/AXlRTORXrztcXSIICIef8O+d9MtW6feav9SMGHrzKwCoYSZLCRO
         KMpk1xoj7HjPrHEb7Sz8dx7qrqvFQ00mD3hTDcZ90E9uFKPB1SMqMgbDKgBtJdaYzdqF
         XASthNUvCSmQvawoFnuv//sdFZeLfNcngQrr1JkuBslQFKpg88ENu2hzW60y8uC8YTvG
         FwtOfYwEJLVq2orjmo/NcE2yjkbm2EB0Z+4dFRkE8eZGMuJqP5X4PTTRu39GJr3ADG0h
         RyAfQ6PJN0GNZL5JWlNkflBL2xZHmokGX0DRSOFIHjWb1D5meqOQMcDhK2LCODVhKmgl
         JsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sMxMa4LZ/ppIJ+nv7J+1CvXNPVDmPKaZ+fgEWOwKE14=;
        b=EUsC/q3w1L1HxAVllc13bnHK+AhuQcxukOXHM04yyW0wAVn0H/iytJLs24ScGearlU
         d0bvPEFrxybeAemgbk+lQx0jheX045i97TO6BsEWeCA9CJfKeBejKomTlaoKTSayx7+d
         lVOPWHRieG4EVA9k8MrhHRufxYEXetM/d0RGWN/Bp6IfUpBu5HeXlFWxulIHWbpeSrhW
         0LMeeMARC/It1TVUiDYrIdQFOO5u4ImCJffZGpFnpdCHorp5aWoxS79LVqw/AcdIuThf
         DicaPI3bLFBsCJGiYjXgu6AfonvZuKuNj9avAufFCPDUUaG/R3Hc9IeohwNgO5bha4zU
         POzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peng Li <lipeng321@huawei.com>,
	Mingguang Qu <qumingguang@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 013/168] net: hns3: free the ring_data structrue when change tqps
Date: Wed, 11 Apr 2018 00:22:35 +0200
Message-Id: <20180410212800.774687234@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399868116740967?=
X-GMAIL-MSGID: =?utf-8?q?1597399868116740967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Li <lipeng321@huawei.com>


[ Upstream commit 99fdf6b1cadf41bb253408589788f025027274f3 ]

This patch fixes a memory leak problems in change tqps process,
the function hns3_uninit_all_ring and hns3_init_all_ring
may be called many times.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Mingguang Qu <qumingguang@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c
@@ -2785,8 +2785,12 @@ int hns3_uninit_all_ring(struct hns3_nic
 			h->ae_algo->ops->reset_queue(h, i);
 
 		hns3_fini_ring(priv->ring_data[i].ring);
+		devm_kfree(priv->dev, priv->ring_data[i].ring);
 		hns3_fini_ring(priv->ring_data[i + h->kinfo.num_tqps].ring);
+		devm_kfree(priv->dev,
+			   priv->ring_data[i + h->kinfo.num_tqps].ring);
 	}
+	devm_kfree(priv->dev, priv->ring_data);
 
 	return 0;
 }

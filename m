Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv7YOL1OV+qCfVg6X3dYqdRR2ukC8hfZTq4gT/OVxHtQmyovEXLnpPy9Wpbf4aOKfF0453j
ARC-Seal: i=1; a=rsa-sha256; t=1521800350; cv=none;
        d=google.com; s=arc-20160816;
        b=YBUR5DBdSi9DITtaCBFxjl0OXpbHOL1kZO9egBP/rsuqSCl9RqPexySIRI9ucU6D6A
         QCk23jsWhYPP3DCtZIe1UBrFSD4H2JIHF55A3MZNyh76f3lc+61ChKNF8bfZLgD5DL0+
         hye8H0z6tqOKViCl8xJhlAo4ssQ8nCyl45+hqon4XmjrOb07NqrV/nl9593rwgd+Iaq7
         4mJGZpvkOTsCPdAeEpclbamopSdp1vC09tRDpWtSKqY1WDv4meKSP6vSMNJTBBI0ilr7
         CCt+ZYCqzaCBkWPsQbZVeRbJIXOY4ycKPF8iQdW31v5Jll+3ITcn33q5W7Z95yPotVP4
         pYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CQZAKlYNrGKmwmJzV92iPRYSdFLhSRtKc/14wHuOLYc=;
        b=yCURQPt3AMy8uf33bH/zase0RBFJwmjKFMeneYDqZJCUc2gMl+mO2m7E9KpWG+PYOz
         T2N8Zc4aI0yQXZHlyYjgXVkQuyeGXeNtf+Xi1M3Fb3It4oI8RsBVO9QRESYBizH/dCPE
         z1mSDxDHitsKugHV/KYtPwQ/78WM0Ur+xSUFNce9XkdZ+4D2neZrUOmgKG5DYxiv+1Ku
         eguhcW8BkGJ/Dsyhm+B0nuBCclGGlLy4q8EYn1N4LLVEqIZ/62I9hgIoSsbeVPweTbhk
         CODF58hUFIgMZlF8zXEtYzdkRbA3qzxQXScZfjjZItWJPC/9XszeKjkp7dnD7Sb+v374
         uBDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/47] qlcnic: fix unchecked return value
Date: Fri, 23 Mar 2018 10:55:13 +0100
Message-Id: <20180323094249.070391163@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722595715994642?=
X-GMAIL-MSGID: =?utf-8?q?1595723324959288306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 91ec701a553cb3de470fd471c6fefe3ad1125455 ]

Function pci_find_ext_capability() may return 0, which is an invalid
address. In function qlcnic_sriov_virtid_fn(), its return value is used
without validation. This may result in invalid memory access bugs. This
patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -126,6 +126,8 @@ static int qlcnic_sriov_virtid_fn(struct
 		return 0;
 
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
+	if (!pos)
+		return 0;
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
 

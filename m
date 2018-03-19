Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu0W5qbHP8wIkxC/e8D4KdSmYbAxUeNvJ6IfuOkQXyJFSKlAPq4B0BU+17tx5UEyuRFdMNN
ARC-Seal: i=1; a=rsa-sha256; t=1521483142; cv=none;
        d=google.com; s=arc-20160816;
        b=pq868HWaUBKeHU+rXAfoO1ee4AiqfZ4epAKc9AoFZdnmuF4fU5u9FLiI/y3qtDdYgE
         VqIO+sLk+KHBPDTIB+KfpVV4yGk3F8VP6lXZ0mTCA2MYHzn8tQhpEezBCJ1B21nHpbfD
         bJcyJPVa/ms4u8tP5iET9EadwNFPWj6cRNlA/i8q5mToZJF3L2x/167luEOApSaii2m/
         KJ6wL3NpZFnngZEbThBHAmjfBSCYrlaND1WQErVzDRZDjwqyYMNtS87DgqLFzAOC2XTf
         d8hmv3baQP3mdTrjpJUPCQTZHeuViMfs7oEoJR8OzOpL0TIh33BWr66jEFiinu+cApzH
         /GZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rrp9R6uMfhXXL43yk0Yjaed2ttNAdKAZh5cZU8yx6WQ=;
        b=NWErMszKJzN0+2y7s5twhl9x2pW328o1FYlFP8Cbko4XGXPVf2qZmXzk2VETP7h8Nh
         PJQ+Xv5e0CuOnTAVR0DYHRd9egHYg6/VE3pkL+ujzt+VVBzGkU8sgu6IhRlb5RE2rAo6
         QzUEyYcT4Aek4fXJgoSdcJ9OdByCcSVaC29HJlccR7SsxC/M1e+4bymL+aYydQojEilN
         8WvL6I/Bh6UKs3uy6JWBwB134zV1Oifcz8BVwNRDcK+coN3tusgmlETUb/V3yQKae9Uf
         rkIdiUjOOD6nmaJj6W+y/eX45yZmfKk6HMf94wDfcWQBOjsLiZpH2h6DzePPUn9R7sEX
         lC3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quan Nguyen <qnguyen@apm.com>,
	Iyappan Subramanian <isubramanian@apm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 015/134] drivers: net: xgene: Fix hardware checksum setting
Date: Mon, 19 Mar 2018 19:04:58 +0100
Message-Id: <20180319171851.297389761@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390583134295858?=
X-GMAIL-MSGID: =?utf-8?q?1595390707421136071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Nguyen <qnguyen@apm.com>


[ Upstream commit e026e700d940a1ea3d3bc84d92ac668b1f015462 ]

This patch fixes the hardware checksum settings by properly program
the classifier. Otherwise, packet may be received with checksum error
on X-Gene1 SoC.

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c |    1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -604,6 +604,7 @@ static void xgene_enet_cle_bypass(struct
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG0_0_ADDR, &cb);
 	cb |= CFG_CLE_BYPASS_EN0;
 	CFG_CLE_IP_PROTOCOL0_SET(&cb, 3);
+	CFG_CLE_IP_HDR_LEN_SET(&cb, 0);
 	xgene_enet_wr_csr(pdata, CLE_BYPASS_REG0_0_ADDR, cb);
 
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG1_0_ADDR, &cb);
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -147,6 +147,7 @@ enum xgene_enet_rm {
 #define CFG_RXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 26, 3)
 
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)

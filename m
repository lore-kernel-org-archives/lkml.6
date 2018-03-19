Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvuCntpa4nwh42IOcrGsPqcyxDIVlO776K/95JIhg4uKwqGWfxjE37CK1TqxcQgxAKOlWMl
ARC-Seal: i=1; a=rsa-sha256; t=1521483642; cv=none;
        d=google.com; s=arc-20160816;
        b=utWKw06JPwDeztr8g+cMbjN9vWRCiV8R7SxclD8iyaWPbisGBkVNqdI5xqg8GduKlY
         ef88rAVlX/O0FlE03GkG/LsiI6X8yP/J3QUFSRds/asdrmbiWh7oguvyBH4626is3kOK
         cX+wkGsADIDd20Z0wqZlvR5GPguFsSQIODXk1XD+cvgloysmQy31LQxRDg0jSBG3IW3+
         BItDAFGHwjgR7EgfP8AE9RAC49uNFUkfcvEh4lVd0bAcs3vmr06d4u4l1FCd0maJSRxj
         3pQlqkUTbeyGtDM/ZOnTPQHwiUhCq5khjCbbpBih3O8yANGrE+dAiOJEZIRXcg+W/urX
         GOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6fCjedc9f4H3riZGCrsK41qqkMrnxu66whZiblUe8A4=;
        b=O/tB27u+f+SxYIK5CvmYHjGayY9XY+r2DCQzGM1zXjfxyZgwOPYPl6Den5krptJWIQ
         4tcJnSaImKdnbITjrK1rmKXImug2jLkzra4QDUxE1XHCPKOX/zIVxcrB80bLWrCMGGo/
         yhtzo90QI6T1FAmEDpXgRm51gnWCpndyUXxVWI2CHoK2QqyMnGDwGtPt5v4PMUrq3Rgk
         va2sld0seXcVkpqKim9wJEQ0rJNT6+0oLpK8ZDyZ+LxBe3TNyUitB8m1tE0XHAkOi1ci
         f6ujw7pQyxIPmJme6JtzEzl/vwkZ6kzIMyK736HpZ7zyB9sHMYmks/EuWsT6KEWRHejA
         /GPw==
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
Subject: [PATCH 4.9 028/241] drivers: net: xgene: Fix hardware checksum setting
Date: Mon, 19 Mar 2018 19:04:53 +0100
Message-Id: <20180319180752.333911485@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390583134295858?=
X-GMAIL-MSGID: =?utf-8?q?1595391232311131278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -560,6 +560,7 @@ static void xgene_enet_cle_bypass(struct
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG0_0_ADDR, &cb);
 	cb |= CFG_CLE_BYPASS_EN0;
 	CFG_CLE_IP_PROTOCOL0_SET(&cb, 3);
+	CFG_CLE_IP_HDR_LEN_SET(&cb, 0);
 	xgene_enet_wr_csr(pdata, CLE_BYPASS_REG0_0_ADDR, cb);
 
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG1_0_ADDR, &cb);
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -163,6 +163,7 @@ enum xgene_enet_rm {
 #define CFG_RXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 26, 3)
 
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)

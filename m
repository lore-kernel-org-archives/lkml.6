Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsFSzK4l4s9lPDIl9uUMfwlK2b6kC3FmdAOnjXl/lR5esgIyM68DI2eqin4A/uzD0XQh6Vk
ARC-Seal: i=1; a=rsa-sha256; t=1521483023; cv=none;
        d=google.com; s=arc-20160816;
        b=LeMpWjAd3bu34mYMjV55qZVDwF9zXurUc97Spd5P2akhE7nHTeuj6Bwm6TzF5RVOzD
         quwNjV/Aacu3iIGlmlr7oGUej65+5CFyh8OG+dz4D0IOHK6gsiXaUMdoOJBJHM6u1525
         /zJPvkChOsctyu1JeCZA+8NzmJgPloAk7SteH2fvMuOLWP6UNBzIswxUN+VIlDdCMV7w
         icCAPPCbscyk7JoHvoYCS/8/jW7sa6+5uCr6ZzP2BQznZbHQqtlElqeWVfgRltWH00bV
         6ayeWZ+rGSYPAkWK0z6eAJuUYUSIxK/uVlJU8+7Ru1X/px+W/AARED6g3nE/fhZxc+HL
         VTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qy0bRBff7j+D7hY22+uwDySvDIKDt2EQl/1LSYV4Zco=;
        b=kv8wsKWx4sgCC1MFxdFILtusesBjYKn/oKs4mzucdyM3DOIepYPTZHv6l/TrELPjI6
         Sp8wCnkbuKzaUN7Y7EZBMkYe8dhIxLQ73++pPqasxG44odBeGsWRmrSVfccPC4ZmpMIk
         Pp1J0nUPdn1iakCzVHEEzugG63KY8XVB/f4RK6JA5/Q09UwPDlo53jaNxSFPd6EJBbzB
         YMBD3GaKkZBhQSyXw58dW/YEt9sfOrwfh/4+cBWIgjUOqKDclw+R+B3VH5IH8zrj8osY
         foKOu5lToXbX46DFEn6wnTxMKnJjXIvuWcwkXviRX8eHy7xWpIkMiT8UqtGobwQxdjQe
         h4Nw==
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
Subject: [PATCH 3.18 07/68] drivers: net: xgene: Fix hardware checksum setting
Date: Mon, 19 Mar 2018 19:05:45 +0100
Message-Id: <20180319171828.968598430@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390583134295858?=
X-GMAIL-MSGID: =?utf-8?q?1595390583134295858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -535,6 +535,7 @@ static void xgene_enet_cle_bypass(struct
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG0_0_ADDR, &cb);
 	cb |= CFG_CLE_BYPASS_EN0;
 	CFG_CLE_IP_PROTOCOL0_SET(&cb, 3);
+	CFG_CLE_IP_HDR_LEN_SET(&cb, 0);
 	xgene_enet_wr_csr(pdata, CLE_BYPASS_REG0_0_ADDR, cb);
 
 	xgene_enet_rd_csr(pdata, CLE_BYPASS_REG1_0_ADDR, &cb);
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.h
@@ -143,6 +143,7 @@ enum xgene_enet_rm {
 #define CFG_TXCLK_MUXSEL0_SET(dst, val)	xgene_set_bits(dst, val, 29, 3)
 
 #define CFG_CLE_IP_PROTOCOL0_SET(dst, val)	xgene_set_bits(dst, val, 16, 2)
+#define CFG_CLE_IP_HDR_LEN_SET(dst, val)	xgene_set_bits(dst, val, 8, 5)
 #define CFG_CLE_DSTQID0_SET(dst, val)		xgene_set_bits(dst, val, 0, 12)
 #define CFG_CLE_FPSEL0_SET(dst, val)		xgene_set_bits(dst, val, 16, 4)
 #define CFG_MACMODE_SET(dst, val)		xgene_set_bits(dst, val, 18, 2)

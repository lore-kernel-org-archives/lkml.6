Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226IlwsHo9mz9kfv169/gIOyZHF/6zQAjpE/1WDZWgcZoYrQuXOCzX6xgoSlrWu4jMM6IwtM
ARC-Seal: i=1; a=rsa-sha256; t=1518707932; cv=none;
        d=google.com; s=arc-20160816;
        b=cjBuwtxF/mXZgJtRq1eP1G+tL8gc8qNrHR51mT76R4cByR1cz535tJUHWHjjiKWWCI
         KwcfmQm42ht6rQTfj99Lp+mzA9CCSeOq/1hB8CJTvVzVGBlronxnO1NFGr1W+bFgNdVd
         yFaaXR7XszoQpP33/qNyXu/jSLmdgW5Vap71Cn2ye2f+E1g9Zeiee/SiCH06wf0b6UB7
         JBqvWmS4QcLR/rymtyBrSEsF0SzvP/32cCEKLoXDSbGITlyCNsHGpJCoDdd4gnNuq89Y
         F4IoBjkvaLjx2wjv+Ek0iQzeycYZOok/EAP2XjWfqDN43Q1pe2GV0RSqDXR2J3JKwPoX
         JcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v8zi7me87yVuRIrp+W0V9bB3mF2h5X1X5airx6IFBUE=;
        b=Oasow3Oc3Iqw2VmY9cI6vCmsx7CNW9Mgvjo6gCVTZ17xHI5no0bdy9T1VtrqqJy+fr
         FVzFCb7sUc7/KJ8Z/akyXfDf/4HeSleFcz3fpEP+DOHVZW7nUoPKYlvE7/5ZMo27XulR
         28SxYp2BeNvcGpVQVStXuKg7durBZpVT353rCRi395DZNkDQLuX+7W9gRUzxFxAf9Uly
         Djdu4d9ySLoI4Mgay2vt9OILpmIktIvf8cyixQhCc348Xjjixh1Hhp+J6NNrS0eRly6D
         haQgmuhJcXPWz7kzzoyLz3BRF/g1LltLCd4Wp6mROZ19Nv5muO5IIFUwL5yEMXa1SIdF
         Btww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chunhao Lin <hau@realtek.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 05/45] r8169: fix RTL8168EP take too long to complete driver initialization.
Date: Thu, 15 Feb 2018 16:16:56 +0100
Message-Id: <20180215144117.023077476@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480688468300089?=
X-GMAIL-MSGID: =?utf-8?q?1592480688468300089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunhao Lin <hau@realtek.com>


[ Upstream commit 086ca23d03c0d2f4088f472386778d293e15c5f6 ]

Driver check the wrong register bit in rtl_ocp_tx_cond() that keep driver
waiting until timeout.

Fix this by waiting for the right register bit.

Signed-off-by: Chunhao Lin <hau@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1375,7 +1375,7 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	return RTL_R8(IBISR0) & 0x02;
+	return RTL_R8(IBISR0) & 0x20;
 }
 
 static void rtl8168dp_driver_start(struct rtl8169_private *tp)
@@ -1421,7 +1421,7 @@ static void rtl8168ep_driver_stop(struct
 	void __iomem *ioaddr = tp->mmio_addr;
 
 	RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
 	RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
 	RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);
 	ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);

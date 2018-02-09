Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225QnjaOnb+KCnMZaho7+p7xeE1fp+pY748uWFog0xnSwEsmop+dx/YjKIH86dFlsf7X0rTy
ARC-Seal: i=1; a=rsa-sha256; t=1518184022; cv=none;
        d=google.com; s=arc-20160816;
        b=zL/r+NCk39+R2BuTJ5esKD13n5OIf6qpH8iJz0VCp0zZU/ORqf+WWHtb+8mxmiGdBg
         fPk5tl3OGRiBVarHHGxFjbDTTDaOy726/RT4QI8ldg8WXkmmXFMzsF759pyvHjO6rlKK
         abeYKodfka8F6R80MRaowXzOdNGhkSJCugtJx2oP1YHlkysT/TayE8O5Be7N1dS910f6
         wD0JKf+aIlE9vnFK/h6uuEkxCS5F1KHVfJUFtuwM/kCA+DIMH49a5mo99d+uCUtcWF2I
         MWHBGP6qUun5X/A8wjEr8PvuV5WldpA5Cnc6BOpkh2+ltA0+fHc2zWf0LvKRqKC+xyq6
         7twQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wn1KvWeC1+HEiHHcvEksPqi6dzYQwjW10rmyVJO32Gw=;
        b=efJsXNGpSVs9stQMYVwtuybpgiuSUOunJvHjgFH5o9LX83oY34NLZ0PdYuwwKu7L3Q
         D/YsJUPlluhaw0RwKnJS8NzgnLfykL9KCVzxd/L6BnlLVRskqeyP1tfWnLb2Dbq+h6NF
         u6rIZg4HHspL87wOS3vXewJFxNmtVxelvROq8AMmCanaxchIJkZxn6B8DX35eYnp+q4P
         NkCCEfBZSJKYYpfVE30iM6HSWwCSva579YjLvA3dqvpj7WzgxLccz8MVldx7LeJD3Nzo
         JJdC964ba7v0trOLnSRzk+kyKbpmNsS+NWQlc7bKSmPzthAb5p7Orb8xQrQD2HI8Enev
         dp/A==
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
Subject: [PATCH 4.15 05/23] r8169: fix RTL8168EP take too long to complete driver initialization.
Date: Fri,  9 Feb 2018 14:40:03 +0100
Message-Id: <20180209133938.643166383@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930965250640663?=
X-GMAIL-MSGID: =?utf-8?q?1591931330044981169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1395,7 +1395,7 @@ DECLARE_RTL_COND(rtl_ocp_tx_cond)
 {
 	void __iomem *ioaddr = tp->mmio_addr;
 
-	return RTL_R8(IBISR0) & 0x02;
+	return RTL_R8(IBISR0) & 0x20;
 }
 
 static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
@@ -1403,7 +1403,7 @@ static void rtl8168ep_stop_cmac(struct r
 	void __iomem *ioaddr = tp->mmio_addr;
 
 	RTL_W8(IBCR2, RTL_R8(IBCR2) & ~0x01);
-	rtl_msleep_loop_wait_low(tp, &rtl_ocp_tx_cond, 50, 2000);
+	rtl_msleep_loop_wait_high(tp, &rtl_ocp_tx_cond, 50, 2000);
 	RTL_W8(IBISR0, RTL_R8(IBISR0) | 0x20);
 	RTL_W8(IBCR0, RTL_R8(IBCR0) & ~0x01);
 }
